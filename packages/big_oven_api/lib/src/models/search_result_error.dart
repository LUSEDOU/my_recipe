/// {@template search_result_error}
/// Throw if a error occurs in search
/// {@endtemplate}
class SearchResultError implements Exception{
  /// {@macro search_result_error}
  const SearchResultError({
    required this.message, 
    this.query,
    this.page,
  });

  /// The error message
  final String message;

  /// The query of the error result
  final String? query;

  /// The page of the error result
  final int? page;
}
