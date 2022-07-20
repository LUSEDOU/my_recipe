// ignore_for_file: prefer_const_constructors
import 'package:recipes_repository/recipes_repository.dart';
import 'package:test/test.dart';

void main() {
  group('RecipeRepository', () {
    test('can be instantiated', () {
      expect(HttpRecipesRepository(), isNotNull);
    });
  });
}
