import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:recipes_repository/recipes_repository.dart';

part 'recipe_overview_state.dart';

class RecipeOverviewCubit extends Cubit<RecipeOverviewState> {
  RecipeOverviewCubit({
    required Recipe recipe,
    required int recipeIndex,
  }) : super(
      RecipeOverviewState(
        recipe: recipe,
        recipeIndex: recipeIndex,
      ),
    );

  Future<void> init() async {
    emit(state.copyWith(status: RecipeOverviewStatus.loading));

    await Future<dynamic>.delayed(const Duration(milliseconds: 500));

    emit(state.copyWith(status: RecipeOverviewStatus.success));
  }

}
