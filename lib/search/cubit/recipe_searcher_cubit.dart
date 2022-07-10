import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'recipe_searcher_state.dart';

class RecipeSearcherCubit extends Cubit<RecipeSearcherState> {
  RecipeSearcherCubit() : super(const RecipeSearcherState());

  Future<void> search() async {
    emit(
      state.copyWith(
        status: RecipeSearcherStatus.loading,
      ),
    );
    try {
      await Future<dynamic>.delayed(const Duration(milliseconds: 300));
      emit(state.copyWith(status: RecipeSearcherStatus.success));
    } catch (_) {
      emit(state.copyWith(status: RecipeSearcherStatus.failure));
    }
  }

  void queryChanged(String query) {
    emit(state.copyWith(query: query));
  }
}
