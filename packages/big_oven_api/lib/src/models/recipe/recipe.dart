import 'package:big_oven_api/src/models/models.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'recipe.freezed.dart';
part 'recipe.g.dart';

@Freezed(copyWith: false)
/// {@template recipe}
/// Recipe returned by the BigOven API
/// Each [Recipe] contains its [id], [title], [image] 
/// and a [thumbnail].
/// Could contains [cuisine], [category], [subcategory]
/// and [user] if aren't null.
/// {@endtemplate}
class Recipe with _$Recipe{
  /// {@macro recipe}
  const factory Recipe({
    /// The id of the recipe
    @JsonKey(name: 'RecipeID')
    required int id,

    /// The title of the recipe
    @JsonKey(name: 'Title')
    required String title,

    /// The image's url of the recipe's photo in
    @JsonKey(name: 'ImageURL')
    required String image,

    /// The image's url of the recipe's photo in 120 x 120 px
    @JsonKey(name: 'ImageURL120')
    required String thumbnail,

    /// The cuisine of the recipe. Can be null.
    @JsonKey(name: 'Cuisine')
    required String? cuisine,

    /// The category of the recipe. Can be null.
    @JsonKey(name: 'Category')
    required String? category,

    /// The subcategory of the recipe. Can be null.
    @JsonKey(name: 'Subcategory')
    required String? subcategory,

    /// The recipe's owner. Can be null.
    @JsonKey(name: 'Poster')
    required User? user,
  }) = _Recipe;

  /// Converts a [Map<String, dynamic>] into a [Recipe] instance.
  factory Recipe.fromJson(Map<String, dynamic> json) 
      => _$RecipeFromJson(json);
}
