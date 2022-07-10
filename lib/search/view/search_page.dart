import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_recipes/l10n/l10n.dart';
import 'package:my_recipes/search/search.dart';
import 'package:recipe_repository/recipe_repository.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

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
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 80),
            Text(
              l10n.recipeSearcherTitle,
              style: textTheme.headline2,
            ),
            const SizedBox(height: 10),
            Text(l10n.recipeSearcherSubtitle),
            const SizedBox(height: 10),
            _SearchForm(),
            const SizedBox(height: 10),
            _SearchBody(),
          ],
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
      decoration: InputDecoration(
        filled: true,
        labelText: l10n.recipeSearcherTextLabel,
        prefixIcon: const Icon(Icons.search_rounded),
        border: InputBorder.none,
        suffixIcon: const Icon(Icons.delete_sweep_rounded),
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
        return state is SearchStateSuccess
            ? _RecipeList()
            : Center(
              child: state is SearchStateLoading
                  ? const CircularProgressIndicator()
                  : Column(
                    children: <Widget>[
                      const Icon(
                        Icons.food_bank,
                        size: 150,
                      ),
                      const SizedBox(height: 8),
                      Text( state is SearchStateEmpty
                          ? l10n.recipeListInitial
                          : l10n.recipeListNotFoundQuery('query'),
                      ),
                    ],
                  ),
            );
      },
    );
  }
}

class _RecipeList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
