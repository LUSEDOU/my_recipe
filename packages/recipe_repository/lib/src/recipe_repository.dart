import 'dart:convert';
import 'dart:developer';

import 'package:big_oven_api/big_oven_api.dart';
import 'package:local_storage/local_storage.dart';

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

  /// Get a list of [SearchResult]
  Future<SearchResult> getRecipes(String query, int pages) async {
    if (_localStorage.has('$query$pages')) {
      final cachedResult = _localStorage.get('$query$pages');
      final result 
          = jsonDecode(cachedResult.toString()) as Map<String, dynamic>;
      return SearchResult.fromJson(result);
    }
    log('Getting from Client');

    try {
      final result = await _bigOvenApiClient.search(query: query, page: pages);
      final cachedResult = result.toJson();
      await _localStorage.write('$query$pages', cachedResult);

      return result; 
    } catch (e) {
      throw SearchResultError(
        message: e.toString(), 
        query: query, 
        page: pages,
      );
    }
  }
}
