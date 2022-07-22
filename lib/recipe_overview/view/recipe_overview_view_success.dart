import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_recipes/l10n/l10n.dart';
import 'package:my_recipes/recipe_overview/recipe_overview.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:zoom_pinch_overlay/zoom_pinch_overlay.dart';

class RecipeOverviewViewSuccess extends StatelessWidget {
  const RecipeOverviewViewSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final recipe 
        = context.select((RecipeOverviewCubit cubit) => cubit.state.recipe);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 2,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: ZoomOverlay(
              twoTouchOnly: true,
              child: CachedNetworkImage(
                imageUrl: recipe.image,
                fit: BoxFit.cover,
                width: size.width,
                progressIndicatorBuilder: (context, url, progress) => 
                  Center(
                    child: CircularProgressIndicator(
                      color: theme.colorScheme.onPrimary,
                      strokeWidth: 3,
                    ),
                  ),
              ),
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
                    Text(
                      recipe.cuisine.isNotEmpty
                          ? recipe.cuisine
                          : l10n.recipeOverviewParameterNull,
                      style: textTheme.bodyText2,
                    ),
                    Text(
                      recipe.category.isNotEmpty
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
        Container(
          alignment: Alignment.centerRight,
          height: size.height * 0.04,
          child: TextButton(
            onPressed: () async {
              if (await canLaunchUrlString(recipe.web)) {
                await launchUrlString(recipe.web);
              }
            },
            child: Text(
              'More info',
              style: textTheme.subtitle2,
            ),
          ),
        ),
        Expanded(
          child: _Poster(),
        ),
      ],
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
          return SizedBox(
            height: size.height * 0.2,
          );
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
              leading: ClipOval(
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
