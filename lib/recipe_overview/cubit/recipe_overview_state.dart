part of 'recipe_overview_cubit.dart';

class RecipeOverviewState extends Equatable {
  const RecipeOverviewState({
    required this.recipe,
  });

  final Recipe recipe;

  @override
  List<Object> get props => [recipe];
}
