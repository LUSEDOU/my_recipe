// coverage: ignore_for_file
// ignore_for_file: prefer_if_elements_to_conditionals_expressions

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_recipes/recipe_overview/recipe_overview.dart';
import 'package:my_recipes/recipe_overview/view/view.dart';
import 'package:my_recipes/utils/mock_recipe.dart';
import 'package:recipes_repository/recipes_repository.dart';

class RecipeOverviewPage extends StatelessWidget {
  const RecipeOverviewPage({super.key});

  static Route<void> route({
    required Recipe recipe,
    required int recipeIndex,
  }) {
    return MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => BlocProvider(
        create: (context) => RecipeOverviewCubit(
          recipe: recipe,
          recipeIndex: recipeIndex,
        )..init(),
        child: _RecipeOverviewView(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => RecipeOverviewCubit(
          recipe: Mocks.recipeNoSubCategoryNoUser,
          recipeIndex: 1,
        ),
        child: _RecipeOverviewView(),
      );
  }
}

class _RecipeOverviewView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final recipeIndex 
      = context.select((RecipeOverviewCubit cubit) => cubit.state.recipeIndex);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(), 
          icon: const Icon(Icons.arrow_back_rounded),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(size.width * 0.05),
        child: BlocBuilder<RecipeOverviewCubit, RecipeOverviewState>(
          builder: (context, state) {
            if (state.status == RecipeOverviewStatus.initial) {
              Navigator.of(context).pop();
            }

            if(state.status == RecipeOverviewStatus.loading) {
              context.read<RecipeOverviewCubit>().init();
              return  Hero(
                tag: recipeIndex,
                child: const RecipeOverviewViewLoading(),
              );
            }

            return const RecipeOverviewViewSuccess();
          },
        ),
      ),
    );
  }
}
