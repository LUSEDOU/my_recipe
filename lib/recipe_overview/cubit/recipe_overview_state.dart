part of 'recipe_overview_cubit.dart';

enum RecipeOverviewStatus { loading, success }

class RecipeOverviewState extends Equatable {
  const RecipeOverviewState({
    required this.recipe,
    this.status = RecipeOverviewStatus.loading,
  });

  final Recipe recipe;
  final RecipeOverviewStatus status;

  RecipeOverviewState copyWith({
    Recipe? recipe,
    RecipeOverviewStatus? status,
  }) {
    return RecipeOverviewState(
      recipe: recipe ?? this.recipe,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [recipe, status];
}
