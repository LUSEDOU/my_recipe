// coverage: ignore_for_file
// ignore_for_file: prefer_if_elements_to_conditionals_expressions

import 'package:big_oven_api/big_oven_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_recipes/l10n/l10n.dart';
import 'package:my_recipes/recipe_overview/recipe_overview.dart';
import 'package:recipe_repository/recipe_repository.dart';

class RecipeOverviewPage extends StatelessWidget {
  const RecipeOverviewPage({super.key});

  static Route<void> route({required Recipe recipe}) {
    return MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => BlocProvider(
        create: (context) => RecipeOverviewCubit(
          recipeRepository: context.read<RecipeRepository>(),
          recipe: recipe,
        ),
        child: const RecipeOverviewPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _RecipeOverviewView();
  }
}

class _RecipeOverviewView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final recipe 
        = context.select((RecipeOverviewCubit cubit) => cubit.state.recipe);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(), 
          icon: const Icon(Icons.arrow_back_rounded),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
        child: Column(
          children: <Widget>[
            Expanded(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Image.network(
                  recipe.image,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(height: size.height * 0.03),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
              ),
              color: theme.colorScheme.secondary,
              child: Text(
                recipe.category.isNotEmpty
                    ? recipe.category
                    : 'No available',
                style: textTheme.bodyText2,  
                // TODO(LUSEDOU): Add subtitleRecipeOverview or edit bodyText2
              ),
            ),
            SizedBox(height: size.height * 0.03),
            Text(
              recipe.title,
              style: textTheme.headline2,
              // TODO(LUSEDOU): Add titleRecipeOverview or edit headline2
            ),
            ColoredBox(
              color: theme.primaryColor,
              child: Row(
                children: <Widget>[
                  Column(
                    children: const <Widget>[
                      Text('ID'), // TODO(LUSEDOU): Add l10n.recipeOverviewID
                      Text('Cuisine'), // TODO(LUSEDOU): Add l10n.recipeOverviewCuisine
                      Text('Category'), // TODO(LUSEDOU): Add l10n.recipeOverviewCategory
                    ],
                  ),
                  SizedBox(height: size.width * 0.03),
                  Column(
                    children: <Widget>[
                      Text('${recipe.id}'),
                      Text(recipe.cuisine.isNotEmpty
                          ? recipe.cuisine
                          : 'No available', // TODO(LUSEDOU): Add l10n.recipeOverviewNull
                      ),
                      Text(recipe.category.isNotEmpty
                          ? recipe.cuisine
                          : 'No available', 
                      ),
                    ],
                  ),/*
                  recipe.user.isEmpty
                    ? Column(
                      children: <Widget>[
                        const Text('Post by'), // TODO(LUSEDOU): Add l10n.recipeOverviewPoster
                        Column(
                          children: <Widget> [
                            Image.network(recipe.user.thumbnail)
                          ],
                        )
                      ],
                    )
                    : const SizedBox.expand(),*/
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
