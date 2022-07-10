// ignore_for_file: prefer_const_constructors
import 'package:recipe_repository/recipe_repository.dart';
import 'package:test/test.dart';

void main() {
  group('RecipeRepository', () {
    test('can be instantiated', () {
      expect(RecipeRepository(), isNotNull);
    });
  });
}
