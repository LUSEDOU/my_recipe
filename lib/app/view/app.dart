// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_recipes/l10n/l10n.dart';
import 'package:my_recipes/search/search.dart';
import 'package:my_recipes/utils/theme.dart';
import 'package:recipes_repository/recipes_repository.dart';

class App extends StatelessWidget {
  const App({super.key, required this.recipeRepository});

  final RecipeRepository recipeRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: recipeRepository,
      child: MaterialApp(        
        debugShowCheckedModeBanner: false,
        theme: kMyRecipeTheme,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const SearchPage(),
      ),
    );
  }
}
