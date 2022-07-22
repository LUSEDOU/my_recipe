import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_recipes/l10n/l10n.dart';
import 'package:my_recipes/search/search.dart';

class SearchForm extends StatelessWidget {
  const SearchForm({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final _textController = TextEditingController();

    return TextField(
      controller: _textController,
      onChanged: (text) {
        text.isEmpty
          ? context.read<SearchBloc>().add(const DeleteQuery())
          : context.read<SearchBloc>().add(QueryChanged(query: text));
      },
      autocorrect: false,
      textAlignVertical: TextAlignVertical.center,
      cursorColor: theme.colorScheme.secondary,
      decoration: InputDecoration(
        hintText: l10n.recipeSearcherTextLabel,
        prefixIcon: const Icon(Icons.search_rounded),
        suffixIcon: BlocBuilder<SearchBloc, SearchState>(
          builder: (context, state) {
            if (state.status == SearchStatus.empty) {
              return const SizedBox();
            }

            return IconButton(
              onPressed: () {
                _textController.clear();
                context.read<SearchBloc>().add(const DeleteQuery());
              },
              icon: const Icon(Icons.cancel_rounded),
            );
          },
        ),
      ),
    );
  }
}
