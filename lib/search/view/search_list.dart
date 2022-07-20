import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_recipes/recipe_overview/recipe_overview.dart';
import 'package:my_recipes/search/search.dart';
import 'package:recipes_repository/recipes_repository.dart';

class RecipeList extends StatelessWidget {
  const RecipeList({super.key, required this.recipes});

  final List<Recipe> recipes;

  @override
  Widget build(BuildContext context) {
    final page = context.read<SearchBloc>().state.page;

    return ListView.builder(
      itemCount: context.read<SearchBloc>().state.hasReachMax
          ? recipes.length
          : recipes.length + 1,
      itemBuilder: (BuildContext context, int index) {
        return index >= recipes.length
            ? _BottomLoader(page: page)
            : _RecipeListTile(recipe: recipes[index]);
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

    return Padding(
      padding: EdgeInsets.only(bottom: size.height * 0.02),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: size.width * 0.02),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
        ),
        child: ListTile(
          leading: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
            ),
            child: Image.network(recipe.thumbnail),
          ),
          title: Text(
            recipe.title,
            style: textTheme.headline5,
          ),
          subtitle: Text(
            recipe.cuisine.isNotEmpty 
                ? recipe.cuisine
                : '',
            style: textTheme.bodyText2,
          ),
          onTap: () {
            Navigator.of(context).push(
              RecipeOverviewPage.route(recipe: recipe),
            );
          },
        ),
      ),
    );
  }
}

class _BottomLoader extends StatelessWidget {
  const _BottomLoader({required this.page});

  final int page;

  @override
  Widget build(BuildContext context) {
    context.read<SearchBloc>().add(PageChanged(page: page + 1));
    return const CircularProgressIndicator();
  }
}
