import 'package:big_oven_api/big_oven_api.dart';

/// {@template search_result}
/// A model of a search result
/// {@endtemplate}
class SearchResult{
  /// {@macro search_result}
  const SearchResult({
    required this.recipes,
  });

  /// The recipes of the result
  final List<Recipe> recipes;
}
