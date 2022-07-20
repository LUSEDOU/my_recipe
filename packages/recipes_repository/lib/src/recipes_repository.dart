import 'package:recipes_api/recipes_api.dart';
import 'package:recipes_repository/recipes_repository.dart';

/// {@template recipe_repository}
/// An abstract model of a RecipeRepository
/// {@endtemplate}
abstract class RecipeRepository {
  /// Get a [SearchResult]
  Future<SearchResult> getRecipes(
    String query, {
    int pages = 1,
    bool forceRefresh = false,
  });

  /// Return a dynamic for a request from the [LocalStorageRecipesApi]
  dynamic getFromCache(
    String endPoint, {
    Map<String, dynamic>? queryParameters,
  });

  /// Return a dynamic for a request from the [HttpRecipesApi]
  Future<dynamic> getFromNetwork(
    String endPoint, {
    Map<String, dynamic>? queryParameters,
  });
}
