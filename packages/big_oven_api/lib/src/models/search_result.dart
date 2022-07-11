import 'dart:developer';

import 'package:big_oven_api/big_oven_api.dart';

///
class SearchResult {
  ///
  const SearchResult({required this.recipes});

  ///
  static SearchResult fromJson(Map<String, dynamic> json) {
    final items = (json['Results'] as List<dynamic>)
        .map((dynamic recipe) {
            log(recipe.toString());
            return Recipe.fromJson(recipe as Map<String, dynamic>);
            },)
        .toList();
    log(items.length.toString());
    return SearchResult(recipes: items);
  }

  ///
  final List<Recipe> recipes;
}

///
class SearchResultError implements Exception{
  ///
  const SearchResultError({required this.message});

  ///
  static SearchResultError fromJson(dynamic json) {
    return SearchResultError(
      message: json['message'] as String,
    );
  }

  ///
  final String message;
}
