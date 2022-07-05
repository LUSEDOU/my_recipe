import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          Text(
            'My Recipes',
            style: TextStyle(
              
            ),
          ) // TODO(LUSEDOU): add l10n

        ],
      ),
    );
  }
}
