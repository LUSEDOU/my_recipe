import 'package:big_oven_api/big_oven_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_recipes/l10n/l10n.dart';
import 'package:my_recipes/search/search.dart';
import 'package:my_recipes/utils/utils.dart';
import 'package:recipe_repository/recipe_repository.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) 
          => SearchBloc(recipeRepository: context.read<RecipeRepository>()),
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
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
          child: Column(
            children: <Widget>[
              SizedBox(height: size.height * 0.03),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  l10n.recipeSearcherTitle,
                  style: textTheme.headlineMedium,
                ),
              ),
              SizedBox(height: size.height * 0.01,),
              Text(
                l10n.recipeSearcherSubtitle,
                style: textTheme.subtitle1,
              ),
              SizedBox(height: size.height * 0.02),
              _SearchForm(),
              const SizedBox(height: 10),
              _SearchBody(),
            ],
          ),
        ),
      ),
    );
  }
}

class _SearchForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final _textController = TextEditingController();

    return TextField(
      controller: _textController,
      onChanged: (text) => 
        context.read<SearchBloc>().add(QueryChanged(query: text)),
      autocorrect: false,
      decoration: InputDecoration(
        filled: true,
        hintText: l10n.recipeSearcherTextLabel,
        prefixIcon: const Icon(Icons.search_rounded),
        border: InputBorder.none,
        suffixIcon: IconButton(
          onPressed: () {
            _textController.clear();
            context.read<SearchBloc>().add(const QueryChanged(query: ''));
          },
          icon: const Icon(Icons.cancel_rounded),
        ),
      ),
    );
  }
}

class _SearchBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        final status = state.status;

        if (status == SearchStatus.success) {
          return Expanded(
            child: _RecipeList(
              recipes: state.recipes,
            ),
          );
        }
        
        if (status == SearchStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        return Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(Assets.logo),
              Text(
                status == SearchStatus.empty
                    ? l10n.recipeListInitial
                    : l10n.recipeListNotFoundQuery(state.query),
              )
            ],
          ),
        );
      },
    );
  }
}


class _RecipeList extends StatelessWidget {
  const _RecipeList({required this.recipes});

  final List<Recipe> recipes;

  @override
  Widget build(BuildContext context) {
    final page = context.read<SearchBloc>().state.page;

    return ListView.builder(
      itemCount: context.read<SearchBloc>().state.hasReachMax
          ? recipes.length
          : recipes.length + 10,
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
    return ListTile(
      contentPadding: const EdgeInsets.all(9),
      leading: Image.network(recipe.thumbnail),
      title: Text(recipe.title),
      subtitle: recipe.subcategory.isNotEmpty
          ? Text(recipe.subcategory)
          : null,
      onTap:() {}, 
      //TODO(LUSEDOU): Create RecipeOverview route
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
