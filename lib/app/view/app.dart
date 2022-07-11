// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_recipes/l10n/l10n.dart';
import 'package:my_recipes/recipe_overview/recipe_overview.dart';
import 'package:my_recipes/search/search.dart';
import 'package:recipe_repository/recipe_repository.dart';

class App extends StatelessWidget {
  const App({super.key, required this.recipeRepository});

  final RecipeRepository recipeRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: recipeRepository,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(color: Color(0xFF13B9FF)),
          colorScheme: ColorScheme.fromSwatch(
            accentColor: const Color(0xFF13B9FF),
          ),
        ),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const SearchPage(),
      ),
    );
  }
}
