import 'package:flutter/material.dart';
import 'package:my_recipes/l10n/l10n.dart';

class RecipeOverviewPage extends StatelessWidget {
  const RecipeOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.046),
          child: Column(
            children: <Widget>[
              SizedBox(height: size.height * 0.032),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  l10n.recipeSearcherTitle,
                  style: textTheme.headlineMedium,
                ),
              ),
              SizedBox(height: size.height * 0.013,),
              Text(
                l10n.recipeSearcherSubtitle,
                style: textTheme.subtitle1,
              ),
              SizedBox(height: size.height * 0.018,),
              TextField(
                decoration: InputDecoration(
                  filled: true,
                  hintText: l10n.recipeSearcherTextLabel,
                  hintStyle: TextStyle(
                    color: Colors.grey.shade400,
                  ),
                  prefixIcon: IconButton(
                    onPressed: () {}, 
                    icon: const Icon(Icons.search_rounded),
                  ),
                  border: InputBorder.none,
                  suffixIcon: IconButton(
                    onPressed: () {}, 
                    icon: const Icon(Icons.cancel_rounded),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
