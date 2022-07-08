import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_recipes/l10n/l10n.dart';
import 'package:my_recipes/recipe_searcher/recipe_searcher.dart';

class RecipeSearcherPage extends StatelessWidget {
  const RecipeSearcherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RecipeSearcherCubit(),
      child: _RecipeSearcherView(),
    );
  }
}

class _RecipeSearcherView extends StatelessWidget {
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
            _RecipeSearcherForm(),
            const SizedBox(height: 10),
            _RecipeSearcherBody(),
          ],
        ),
      ),
    );
  }
}

class _RecipeSearcherForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final _textController = TextEditingController();

    return TextField(
      controller: _textController,
      onChanged: (text) => 
        context.read<RecipeSearcherCubit>().queryChanged(text),
      decoration: InputDecoration(
        filled: true,
        labelText: l10n.recipeSearcherTextLabel,
        prefixIcon: IconButton(
          onPressed: () => 
              context.read<RecipeSearcherCubit>().search(), 
          icon: const Icon(Icons.search_rounded),
        ),
        border: InputBorder.none,
        suffixIcon: IconButton(
          onPressed: () => {
            context.read<RecipeSearcherCubit>().queryChanged(''), 
            _textController.clear(),
          },
          icon: const Icon(Icons.delete_sweep_rounded),
        ),
      ),
    );
  }
}

class _RecipeSearcherBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocBuilder<RecipeSearcherCubit, RecipeSearcherState>(
      buildWhen: (previous, current) => 
          previous.status != current.status,
      builder: (context, state) {
        final status = state.status;

        return status == RecipeSearcherStatus.success
            ? _RecipeList()
            : Center(
              child: status == RecipeSearcherStatus.loading
                  ? const CircularProgressIndicator()
                  : Column(
                    children: <Widget>[
                      const Icon(
                        Icons.food_bank,
                        size: 150,
                      ),
                      const SizedBox(height: 8),
                      Text( status == RecipeSearcherStatus.initial
                          ? l10n.recipeListInitial
                          : l10n.recipeListNotFoundQuery(state.query),
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
