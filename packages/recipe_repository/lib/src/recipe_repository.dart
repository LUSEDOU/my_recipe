import 'package:big_oven_api/big_oven_api.dart';
import 'package:local_storage/local_storage.dart';
import 'package:recipe_repository/recipe_repository.dart';

/// {@template recipe_repository}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class RecipeRepository {
  /// {@macro recipe_repository}
  RecipeRepository({
    BigOvenApiClient? bigOvenApiClient,
    LocalStorage? localStorage,
  }) : _bigOvenApiClient = bigOvenApiClient ?? BigOvenApiClient(),
       _localStorage = localStorage ?? LocalStorage();

  final BigOvenApiClient _bigOvenApiClient;
  final LocalStorage _localStorage;

  /// Get a list of [Search]
  Future<Search> getRecipes(String query, int pages) async {
    if (_localStorage.has(query)) {
      return _localStorage.get(query) as Search;
    }

    final result = await _bigOvenApiClient.search(query: query, page: pages);
    await _localStorage.write(query, result);

    return Search(recipes: result.recipes);
  }
}
