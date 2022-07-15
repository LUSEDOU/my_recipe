// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:big_oven_api/big_oven_api.dart';
import 'package:local_storage/local_storage.dart';
import 'package:my_recipes/app/app.dart';
import 'package:my_recipes/bootstrap.dart';
import 'package:recipe_repository/recipe_repository.dart';

Future<void> main() async {
  final localStorage = LocalStorage();
  await localStorage.init();

  final recipeRepository = RecipeRepository(
    bigOvenApiClient: BigOvenApiClient(
      apiKey: '',
    ),
    localStorage: localStorage,
  );

  await bootstrap(() => App(recipeRepository: recipeRepository));
}
