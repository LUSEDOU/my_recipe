// coverage: ignore_for_file
// ignore_for_file: prefer_if_elements_to_conditionals_expressions

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_recipes/l10n/l10n.dart';
import 'package:my_recipes/recipe_overview/recipe_overview.dart';
import 'package:my_recipes/utils/mock_recipe.dart';
import 'package:recipes_repository/recipes_repository.dart';

class RecipeOverviewPage extends StatelessWidget {
  const RecipeOverviewPage({super.key});

  static Route<void> route({required Recipe recipe}) {
    return MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => BlocProvider(
        create: (context) => RecipeOverviewCubit(
          recipe: recipe,
        ),
        child: _RecipeOverviewView(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => RecipeOverviewCubit(
          recipe: Mocks.recipeNoSubCategoryNoUser,
        ),
        child: _RecipeOverviewView(),
      );
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
          // TODO(LUSEDOU): ASK: Get out shadow
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(size.width * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(
                width: size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: theme.colorScheme.onTertiary,
                ),
                child: Image.network(
                  recipe.image,
                  fit: BoxFit.fitWidth,
                  // TODO(LUSEDOU): ASK: Image's border radius
                  // TODO(LUSEDOU): ASK: Zoom
                ),
              ),
            ),
            SizedBox(height: size.height * 0.02),
            _SubCategory(),
            SizedBox(height: size.height * 0.02),
            Text(
              recipe.title,
              style: textTheme.headline3,
            ),
            SizedBox(height: size.height * 0.02),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(size.width * 0.04),
                decoration: BoxDecoration(
                  color: theme.primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          l10n.recipeOverviewID,
                          style: textTheme.bodyText1,
                        ),
                        Text(
                          l10n.recipeOverviewCuisine,
                          style: textTheme.bodyText1,
                        ),
                        Text(
                          l10n.recipeOverviewCategory,
                          style: textTheme.bodyText1,
                        ),
                      ],
                    ),
                    SizedBox(width: size.width * 0.15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          '${recipe.id}',
                          style: textTheme.bodyText2,  
                        ),
                        Text(recipe.cuisine.isNotEmpty
                            ? recipe.cuisine
                            : l10n.recipeOverviewParameterNull,
                          style: textTheme.bodyText2,
                        ),
                        Text(recipe.category.isNotEmpty
                            ? recipe.category
                            : l10n.recipeOverviewParameterNull,
                          style: textTheme.bodyText2,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: size.height * 0.04,),
            Expanded(
              child: _Poster(),
            ),
          ],
        ),
      ),
    );
  }
}

class _SubCategory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeOverviewCubit, RecipeOverviewState>(
      builder: (context, state) {
        final theme = Theme.of(context);
        final textTheme = theme.textTheme;
        final size = MediaQuery.of(context).size;
        final subCategory = state.recipe.subcategory;

        if (subCategory.isEmpty) {
          return SizedBox(height: size.height * 0.02);
        }

        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 5,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            color: theme.colorScheme.tertiary,
          ),
          child: Text(
            subCategory,
            style: textTheme.subtitle2,
          ),
        );
      },
    );
  }
}

class _Poster extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeOverviewCubit, RecipeOverviewState>(
      builder: (context, state) {
        final size = MediaQuery.of(context).size;
        final user = state.recipe.user;
        final l10n = context.l10n;
        final textTheme = Theme.of(context).textTheme;

        if (user.isEmpty) {
          return SizedBox(height: size.height * 0.2,);
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              l10n.recipeOverviewPoster,
              style: textTheme.headline4,
            ),
            SizedBox(height: size.height * 0.02),
            ListTile(
              leading: CircleAvatar(
                child: Image.network(user.thumbnail),
              ),
              title: Text(user.user),
            )
          ],
        );
      },
    );
  }
}
