// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_recipes/app/app.dart';
import 'package:my_recipes/search/search.dart';
import 'package:recipe_repository/recipe_repository.dart';

class MockRecipeRepository extends Mock implements RecipeRepository {}

void main() {
  late RecipeRepository recipeRepository;

  setUp(() {
    recipeRepository = MockRecipeRepository();
  });

  group('App', () {
    testWidgets('renders CounterPage', (tester) async {
      await tester.pumpWidget(App(recipeRepository: recipeRepository));
      expect(find.byType(SearchPage), findsOneWidget);
    });
  });
}
