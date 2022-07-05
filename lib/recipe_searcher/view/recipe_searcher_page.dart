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
      child: const _RecipeSearcherView(),
    );
  }
}

class _RecipeSearcherView extends StatelessWidget {
  const _RecipeSearcherView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12),
            child: Column(
              children: <Widget>[
                Text(
                  l10n.recipeSearcherTitle,
                  style: textTheme.headline2,
                ),
                const SizedBox(height: 10),
                Text(l10n.recipeSearcherSubtitle),
                const SizedBox(height: 10),
                _RecipeSearcherForm(),
              ],
            ),
          ),
        );
      
  }
}

class _RecipeSearcherForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _textController = TextEditingController();

    return TextField(
      controller: _textController,
      onChanged: (text) => 
        context.read<RecipeSearcherCubit>().queryChanged(text),
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search_rounded),
        border: InputBorder.none,
        suffixIcon: GestureDetector(
          onTap: (){},
          child: const Icon(Icons.delete),
        ),
      ),
    );
  }
}
