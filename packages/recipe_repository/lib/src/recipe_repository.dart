import 'package:big_oven_api/big_oven_api.dart';
import 'package:local_storage/local_storage.dart';
import 'package:recipe_repository/recipe_repository.dart';

/// {@template recipe_repository}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class RecipeRepository {
  /// {@macro recipe_repository}
  RecipeRepository({
    BigOvenApiClientHTTP? bigOvenApiClient,
    LocalStorage? localStorage,
  }) : _bigOvenApiClient = bigOvenApiClient ?? BigOvenApiClientHTTP(),
       _localStorage = localStorage ?? LocalStorage();

  final BigOvenApiClientHTTP _bigOvenApiClient;
  final LocalStorage _localStorage;

  /// Get a list of [Search]
  Future<SearchResult> getRecipes(String query, int pages) async {
    if (_localStorage.has('$query$pages')) {
      return _localStorage.get('$query$pages') as SearchResult;
    }
    final result = await _bigOvenApiClient.search(query: query, page: pages);
    await _localStorage.write('$query$pages', result);

    return result;
  }
}
