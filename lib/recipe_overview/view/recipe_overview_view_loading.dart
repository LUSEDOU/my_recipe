import 'package:flutter/material.dart';

class RecipeOverviewViewLoading extends StatelessWidget {
  const RecipeOverviewViewLoading({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    Widget fakeBox({
      double width = 1,
      double height = 0.04,
      double border = 15,
    }) {
      return Container(
        decoration: BoxDecoration(
          color: theme.hintColor,
          borderRadius: BorderRadius.circular(border),
        ),
        width: size.width * width,
        height: size.height * height,
      );
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          fakeBox(height: 0.3),
          SizedBox(height: size.height * 0.01),
          fakeBox(width: 0.3, height: 0.03),
          SizedBox(height: size.height * 0.03),
          fakeBox(width: 0.7),
          SizedBox(height: size.height * 0.02),
          fakeBox(height: 0.2),
          SizedBox(height: size.height * 0.01),
          Container(
            alignment: Alignment.centerRight,
            child: fakeBox(width: 0.3, height: 0.03),
          ),
          SizedBox(height: size.height * 0.02),
          fakeBox(width: 0.25),
          SizedBox(height: size.height * 0.02),
          Row(
            children: [
              CircleAvatar(
                backgroundColor: theme.colorScheme.onPrimary,
                radius: 30,
              ),
              SizedBox(width: size.width * 0.04),
              fakeBox(width: 0.5),
            ],
          )
        ],
      ),
    );
  }
}
