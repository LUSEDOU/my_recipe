import 'package:big_oven_api/big_oven_api.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:recipe_repository/recipe_repository.dart';
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
    on<PageChanged>(_onPageChanged);
  }

  final RecipeRepository recipeRepository;

  Future<void> _onQueryChanged(
    QueryChanged event,
    Emitter<SearchState> emit,
  ) async {
    final query = event.query;

    if (query.isEmpty) return;

    emit(
      state.copyWith(
        status: SearchStatus.loading,
        query: query,
        page: 1,
      ),
    );

    try {
      final result = await recipeRepository.getRecipes(query, 1);
      emit(
        state.copyWith(
          status: SearchStatus.success,
          recipes: result.recipes,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: SearchStatus.failure,
          message: error is SearchResultError
              ? error.toString()
              : 'Something wrong happened',
        ),
      );
    }
  }

  Future<void> _onPageChanged(
    PageChanged event,
    Emitter<SearchState> emit,
  ) async {
    if (state.hasReachMax) return;

    final page = event.page;
    if (page == state.page || page == 1) return;

    emit(
      state.copyWith(
        status: SearchStatus.loading,
        page: page,
      ),
    );

    try {
      final result = await recipeRepository.getRecipes(state.query, page);
      emit(result.recipes.isEmpty
            ? state.copyWith(hasReachMax: true) 
            : state.copyWith(
                status: SearchStatus.success,
                recipes: List.of(state.recipes)..addAll(result.recipes),
              ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: SearchStatus.failure,
          message: error is SearchResultError
              ? error.toString()
              : 'Something wrong happened',
        ),
      );
    }
  }
}
