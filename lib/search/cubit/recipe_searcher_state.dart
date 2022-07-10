part of 'recipe_searcher_cubit.dart';

enum RecipeSearcherStatus {
  initial,
  loading,
  success,
  failure,
}

class RecipeSearcherState extends Equatable{
  const RecipeSearcherState({
    this.recipes = empty,
    this.query = '',
    this.status = RecipeSearcherStatus.initial,
  });

  final List<dynamic> recipes;
  final String query;
  final RecipeSearcherStatus status;

  static const List<dynamic> empty = [];

  bool get isEmpty => recipes == empty;

  RecipeSearcherState copyWith({
    List<dynamic>? recipes,
    String? query,
    RecipeSearcherStatus? status,
  }) {
    return RecipeSearcherState(
      recipes: recipes ?? this.recipes,
      query: query ?? this.query,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [recipes, query, status];
}
