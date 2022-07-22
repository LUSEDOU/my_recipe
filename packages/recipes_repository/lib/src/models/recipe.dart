import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:recipes_repository/recipes_repository.dart';

part 'recipe.g.dart';

@JsonSerializable()
/// {@template recipe}
/// Recipe returned by the BigOven API
/// Each [Recipe] contains its [id], [title], [image] 
/// and a [thumbnail].
/// Could contains [cuisine], [category], [subcategory]
/// and [user] if aren't null.
/// {@endtemplate}
class Recipe extends Equatable{
  /// {@macro recipe}
  const Recipe({
    required this.id,
    required this.title,
    required this.image,
    required this.thumbnail,
    required this.web,
    this.cuisine = '',
    this.category = '',
    this.subcategory = '',
    this.user = User.empty,
  });

  /// Converts a [Map<String, dynamic>] into a [Recipe] instance.
  factory Recipe.fromJson(Map<String, dynamic> json) 
      => _$RecipeFromJson(json);

  /// The id of the recipe
  @JsonKey(name: 'RecipeID')
  final int id;

  /// The title of the recipe
  @JsonKey(name: 'Title')
  final String title;

  /// The image's url of the recipe's photo in
  @JsonKey(name: 'ImageURL')
  final String image;

  /// The image's url of the recipe's photo in
  @JsonKey(name: 'WebURL')
  final String web;

  /// The image's url of the recipe's photo in 120 x 120 px
  @JsonKey(name: 'ImageURL120')
  final String thumbnail;

  /// The cuisine of the recipe. Can be null.
  @JsonKey(name: 'Cuisine')
  final String cuisine;

  /// The category of the recipe. Can be null.
  @JsonKey(name: 'Category')
  final String category;

  /// The subcategory of the recipe. Can be null.
  @JsonKey(name: 'Subcategory')
  final String subcategory;

  /// The recipe's owner. Can be null.
  @JsonKey(name: 'Poster')
  final User user;

  @override
  List<Object> get props 
      => [id, title, image, thumbnail, cuisine, category, subcategory, user];
}
