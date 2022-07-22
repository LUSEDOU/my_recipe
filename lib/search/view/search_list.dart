import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_recipes/recipe_overview/recipe_overview.dart';
import 'package:my_recipes/search/search.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:recipes_repository/recipes_repository.dart';

class RecipeList extends StatelessWidget {
  const RecipeList({super.key, required this.recipes});

  final List<Recipe> recipes;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final controller = RefreshController();

    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state.status == SearchStatus.failure) {
          controller
              ..refreshFailed()
              ..loadFailed();
        }

        return SmartRefresher(
          controller: controller,
          enablePullUp: true,
          onLoading: () => context.read<SearchBloc>().add(const ScrollDown()),
          onRefresh: () => context.read<SearchBloc>().add(const Refresh()),
          header: const WaterDropHeader(),
          footer: const ClassicFooter(
            noDataText: 'No more data',
          ),
          child: ListView.separated(
            separatorBuilder: (context, index) 
                => SizedBox(height: size.height * 0.02),
            itemCount: recipes.length,
            itemBuilder: (BuildContext context, int index) {
              return _RecipeTile(
                recipe: recipes[index],
                recipeIndex: index,
              );
            },
          ),
        );
      },
    );
  }
}

class _RecipeTile extends StatelessWidget {
  const _RecipeTile({
    required this.recipe,
    required this.recipeIndex,
  });
  final Recipe recipe;
  final int recipeIndex;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final size = MediaQuery.of(context).size;

    return Hero(
      tag: recipeIndex,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: size.width * 0.02),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: theme.colorScheme.primary,
        ),
        child: ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: CachedNetworkImage(
              imageUrl: recipe.thumbnail,
              fit: BoxFit.cover,
              progressIndicatorBuilder: (context, url, progress) =>
                Center(
                child: CircularProgressIndicator(
                  color: theme.colorScheme.onPrimary,
                  strokeWidth: 1,
                ),
              ),
            ),
          ),
          title: Text(
            recipe.title,
            style: textTheme.headline5,
          ),
          subtitle: Text(
            recipe.cuisine,
            style: textTheme.bodyText2,
          ),
          onTap: () {
            Navigator.of(context).push(
              RecipeOverviewPage.route(
                recipe: recipe,
                recipeIndex: recipeIndex,
              ),
            );
          },
        ),
      ),
    );
  }
}
