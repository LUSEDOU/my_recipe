import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_recipes/l10n/l10n.dart';
import 'package:my_recipes/search/search.dart';
import 'package:recipe_repository/recipe_repository.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SearchBloc(recipeRepository: context.read<RecipeRepository>()),
      child: _SearchView(),
    );
  }
}

class _SearchView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(size.width * 0.05),
          child: Column(
            children: <Widget>[
              SizedBox(height: size.height * 0.03),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  l10n.recipeSearcherTitle,
                  style: textTheme.headline1,
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Text(
                l10n.recipeSearcherSubtitle,
                style: textTheme.subtitle1,
              ),
              SizedBox(height: size.height * 0.02),
              const SearchForm(),
              SizedBox(height: size.height * 0.04),
              const Expanded(
                child: SearchBody(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
