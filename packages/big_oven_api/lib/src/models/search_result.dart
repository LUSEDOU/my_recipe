import 'package:big_oven_api/big_oven_api.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_result.freezed.dart';
part 'search_result.g.dart';

@freezed
/// {@template search_result}
/// A model of a Search Result
/// {@endtemplate}
class SearchResult with _$SearchResult{
  /// {@macro search_result}
  const factory SearchResult({
    @JsonKey(name: 'Results')
    /// The recipes of the result
    required List<Recipe> recipes,

    @JsonKey(name: 'ResultCount')
    /// The recipes' count
    required int recipesCount,
  }) = _SearchResult;

  /// Converts a [Map<String, dynamic>] into a [SearchResult] instance.
  factory SearchResult.fromJson(Map<String, dynamic> json) 
      => _$SearchResultFromJson(json);
}
