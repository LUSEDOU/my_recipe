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
    final onRefresh = RefreshController();

    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state.status == SearchStatus.success) {
          if (onRefresh.headerStatus == RefreshStatus.refreshing) {
            onRefresh.refreshCompleted();
          }

          if (onRefresh.footerStatus == LoadStatus.loading) {
            state.hasReachMax
              ? onRefresh.loadNoData()
              : onRefresh.loadComplete();
          } 
        }

        if (state.status == SearchStatus.failure) {
          onRefresh
              ..refreshFailed()
              ..loadFailed();
        }

        return SmartRefresher(
          controller: onRefresh,
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
              return _RecipeListTile(recipe: recipes[index]);
            },
          ),
        );
      },
    );
  }
}

class _RecipeListTile extends StatelessWidget {
  const _RecipeListTile({required this.recipe});
  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.symmetric(vertical: size.width * 0.02),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: theme.colorScheme.primary,
      ),
      child: ListTile(
        leading: Hero(
          tag: recipe.id,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Image.network(recipe.thumbnail),
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
            RecipeOverviewPage.route(recipe: recipe),
          );
        },
      ),
    );
  }
}
