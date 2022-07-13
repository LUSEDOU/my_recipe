import 'package:big_oven_api/big_oven_api.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:recipe_repository/recipe_repository.dart';

part 'recipe_overview_state.dart';

class RecipeOverviewCubit extends Cubit<RecipeOverviewState> {
  RecipeOverviewCubit({
    required RecipeRepository recipeRepository,
    required Recipe recipe,
  }) : _recipeRepository = recipeRepository,
       super(RecipeOverviewState(recipe: recipe));

  final RecipeRepository _recipeRepository;
}
