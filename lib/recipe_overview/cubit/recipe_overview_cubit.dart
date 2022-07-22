import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:recipes_repository/recipes_repository.dart';

part 'recipe_overview_state.dart';

class RecipeOverviewCubit extends Cubit<RecipeOverviewState> {
  RecipeOverviewCubit({
    required Recipe recipe,
  }) : super(RecipeOverviewState(recipe: recipe));

  Future<void> init() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 500));

    emit(state.copyWith(status: RecipeOverviewStatus.success));
  }
}
