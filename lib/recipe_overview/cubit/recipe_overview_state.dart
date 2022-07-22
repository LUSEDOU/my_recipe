part of 'recipe_overview_cubit.dart';

enum RecipeOverviewStatus { initial, loading, success }

class RecipeOverviewState extends Equatable {
  const RecipeOverviewState({
    required this.recipe,
    required this.recipeIndex,
    this.status = RecipeOverviewStatus.initial,
  });

  final Recipe recipe;
  final RecipeOverviewStatus status;
  final int recipeIndex;

  RecipeOverviewState copyWith({
    Recipe? recipe,
    RecipeOverviewStatus? status,
    int? recipeIndex,
  }) {
    return RecipeOverviewState(
      recipe: recipe ?? this.recipe,
      status: status ?? this.status,
      recipeIndex: recipeIndex ?? this.recipeIndex,
    );
  }

  @override
  List<Object> get props => [recipe, status, recipeIndex];
}
