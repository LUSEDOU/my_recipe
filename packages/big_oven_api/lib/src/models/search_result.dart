import 'dart:developer';

import 'package:big_oven_api/big_oven_api.dart';

///
class SearchResult {
  ///
  const SearchResult({
    required this.recipes, 
    required this.recipesCount,
  });

  ///
  factory SearchResult.fromJson(Map<String, dynamic> json) {
    final recipes = (json['Results'] as List<dynamic>)
        .map((dynamic recipe) {
            log(recipe.toString());
            return Recipe.fromJson(recipe as Map<String, dynamic>);
            },)
        .toList();
    log(recipes.length.toString());
    return SearchResult(
      recipes: recipes,
      recipesCount: json['ResultCount'] as int,
    );
  }

  ///
  final List<Recipe> recipes;
  
  ///
  final int recipesCount;
}

///
class SearchResultError implements Exception{
  ///
  const SearchResultError({
    required this.message, 
    required this.query,
    required this.page,
  });

  ///
  factory SearchResultError.fromJson(Map<String, dynamic> json) {
    return SearchResultError(
      message: json['message'] as String,
      query: json['query'] as String,
      page: json['page'] as int,
    );
  }

  ///
  final String message;

  ///
  final String query;

  /// 
  final int page;
}
