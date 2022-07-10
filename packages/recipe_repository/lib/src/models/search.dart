import 'package:big_oven_api/big_oven_api.dart';
import 'package:equatable/equatable.dart';

/// {@template search}
/// A model of a search_result
/// {@endtemplate}
class Search extends Equatable {
  /// {@macro search}
  const Search({
    required this.recipes,
  });

  /// The recipes of the 
  final List<Recipe> recipes;

  /// A empty search 
  static const Search empty = Search(recipes: []);

  /// If the  is empty
  bool get isEmpty => this == empty;

  /// If the  is not empty
  bool get isNotEmpty => this != empty;

  @override
  List<Object> get props => [recipes];
}
