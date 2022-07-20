// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:recipes_repository/recipes_repository.dart';

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
