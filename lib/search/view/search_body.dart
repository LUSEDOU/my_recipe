import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_recipes/l10n/l10n.dart';
import 'package:my_recipes/search/search.dart';
import 'package:my_recipes/utils/utils.dart';

class SearchBody extends StatelessWidget {
  const SearchBody({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final size = MediaQuery.of(context).size;

    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        final status = state.status;

        if (status == SearchStatus.success) {
          return RecipeList(
            recipes: state.recipes,
          );
        }

        if (status == SearchStatus.loading) {
          return Center(
            child: SingleChildScrollView(
              child: CircularProgressIndicator(
                color: theme.shadowColor,
              ),
            ),
          );
        }

        return Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(Assets.logo),
                SizedBox(height: size.width * 0.06),
                Text(
                  status == SearchStatus.empty
                      ? l10n.recipeListInitial
                      : l10n.recipeListNotFoundQuery(state.query),
                  style: textTheme.headline2,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
