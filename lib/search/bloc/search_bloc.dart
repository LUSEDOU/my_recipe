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
  SearchBloc({required this.recipeRepository}) : super(SearchStateEmpty()) {
    on<QueryChanged>(_onQueryChanged, transformer: debounce(_duration));
  }

  final RecipeRepository recipeRepository;

  Future<void> _onQueryChanged(
    QueryChanged event,
    Emitter<SearchState> emit,
  ) async {
    final query = event.query;

    if (query.isEmpty) return emit(SearchStateEmpty());

    emit(SearchStateLoading());

    try {
      final result = await recipeRepository.getRecipes(query, 1);
      emit(SearchStateSuccess(result.recipes));
    } catch (error) {
      emit( error is SearchResultError
          ? SearchStateFailure(error.message)
          : SearchStateFailure(error.toString()),
      );
    }
  }
}
