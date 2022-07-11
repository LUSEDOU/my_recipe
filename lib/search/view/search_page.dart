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
          onPressed: () => 
              context.read<SearchBloc>().add(const QueryChanged(query: '')), 
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
        if (state is SearchStateSuccess) {
          return Expanded(child: _RecipeList());
        }

        if (state is SearchStateLoading) {
          return const CircularProgressIndicator();
        }

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(Icons.restaurant_rounded),
            Text(
              state is SearchStateEmpty
                  ? l10n.recipeListInitial
                  : l10n.recipeListNotFoundQuery(state.props),
            )
          ],
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
