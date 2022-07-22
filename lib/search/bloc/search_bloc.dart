import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:recipes_api/recipes_api.dart';
import 'package:recipes_repository/recipes_repository.dart';
import 'package:stream_transform/stream_transform.dart';

part 'search_event.dart';
part 'search_state.dart';

const _duration = Duration(milliseconds: 300);

EventTransformer<Event> debounce<Event>(Duration duration) {
  return (events, mapper) => events.debounce(duration).switchMap(mapper);
}

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc({required this.recipeRepository}) : super(const SearchState()) {
    on<QueryChanged>(_onQueryChanged, transformer: debounce(_duration));
    on<ScrollDown>(_onScrollDown);
    on<Refresh>(_onRefresh);
    on<DeleteQuery>(_onDeleteQuery);
    on<ImageCached>(_onImageCached);
  }

  final RecipeRepository recipeRepository;

  Future<void> _onQueryChanged(
    QueryChanged event,
    Emitter<SearchState> emit,
  ) async {
    final query = event.query;

    if (query.isEmpty) return;

    emit(
      SearchState(
        status: SearchStatus.loading,
        query: query,
      ),
    );

    try {
      final result 
          = await recipeRepository.getRecipes(query);
      emit(
        state.copyWith(
          status: SearchStatus.success,
          recipes: result.recipes,
          hasReachMax: result.recipes.length == result.recipesCount,
          isCaching: true,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: SearchStatus.failure,
          message: error is ApiException
              ? '${error.title}: ${error.message}'
              : 'Something wrong happened',
        ),
      );
    }
  }

  Future<void> _onScrollDown(
    ScrollDown event,
    Emitter<SearchState> emit,
  ) async {
    if (state.hasReachMax) return;

    final page = state.page;

    try {
      final result 
          = await recipeRepository.getRecipes(state.query, pages: page + 1);

      final hasReachMax 
          = state.recipes.length + result.recipes.length == result.recipesCount;

      emit(
        hasReachMax
          ? state.copyWith(
              status: SearchStatus.success,
              hasReachMax: true,
              isCaching: true,
          )
          : state.copyWith(
              status: SearchStatus.success,
              recipes: List.of(state.recipes)..addAll(result.recipes),
              isCaching: true,
          ), 
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: SearchStatus.failure,
          message: error is ApiException
              ? '${error.title}: ${error.message}'
              : 'Something wrong happened',
        ),
      );
    }
  }

  Future<void> _onRefresh (
    Refresh event,
    Emitter<SearchState> emit,
  ) async {
    final query = state.query;

    emit(
      SearchState(
        status: SearchStatus.loading,
        query: query,
      ),
    );

    try {
      final result 
          = await recipeRepository.getRecipes(query, forceRefresh: true);
      emit(
        state.copyWith(
          status: SearchStatus.success,
          recipes: result.recipes,
          hasReachMax: result.recipes.length == result.recipesCount,
          isCaching: true,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: SearchStatus.failure,
          message: error is ApiException
              ? '${error.title}: ${error.message}'
              : 'Something wrong happened',
        ),
      );
    }
  } 

  void _onDeleteQuery(
    DeleteQuery event,
    Emitter<SearchState> emit,
  ) {
    emit(const SearchState());
  }

  void _onImageCached(
    ImageCached event,
    Emitter<SearchState> emit,
  ) {
    emit(state.copyWith(isCaching: false));
  }
}
