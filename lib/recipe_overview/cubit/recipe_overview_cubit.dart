import 'package:big_oven_api/big_oven_api.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'recipe_overview_state.dart';

class RecipeOverviewCubit extends Cubit<RecipeOverviewState> {
  RecipeOverviewCubit({
    required Recipe recipe,
  }) : super(RecipeOverviewState(recipe: recipe));
}
