import 'package:flutter/material.dart';
import 'package:my_recipes/utils/utils.dart';

final kMyRecipeTheme = _buildMyRecipeTheme();

ThemeData _buildMyRecipeTheme() {
  final base = ThemeData.light();

  return base.copyWith(
    primaryColor: color.primary.tone1,
    backgroundColor: color.primary.tone2,
    hintColor: color.primary.tone4,

    colorScheme: base.colorScheme.copyWith(
      primary: color.primary.tone1,
      onPrimary: color.primary.tone5,
      secondary: color.secondary.tone4,
      onSecondary: color.secondary.tone2,
      tertiary: color.tertiary.tone2,
      onTertiary: color.tertiary.tone1,
    ),
    appBarTheme: base.appBarTheme.copyWith(
      centerTitle: true,
      color: color.primary.tone2,
    ),
    iconTheme: base.iconTheme.copyWith(
      color: color.secondary.tone4,
    ),
    inputDecorationTheme: base.inputDecorationTheme.copyWith(
      iconColor: color.secondary.tone4,
      hintStyle: TextStyle(
        fontSize: textSize.subtitle1,
      ),
      fillColor: color.primary.tone6,
    ),
    textTheme: base.textTheme.copyWith(
      headline1: TextStyle(
        color: color.secondary.tone2,
        fontSize: textSize.headline1,
        fontWeight: FontWeight.w600,
      ),
      headline2: TextStyle(
        color: color.secondary.tone3,
        fontSize: textSize.headline2,
        fontWeight: FontWeight.w600,
      ),
      headline3: TextStyle(
        color: color.secondary.tone4,
        fontSize: textSize.headline3,
        fontWeight: FontWeight.w500,
      ),
      headline4: TextStyle(
        color: color.secondary.tone4,
        fontSize: textSize.headline4,
        fontWeight: FontWeight.w600,
      ),
      subtitle1: TextStyle(
        color: color.primary.tone5,
        fontWeight: FontWeight.w400,  
      ),
      subtitle2: TextStyle(
        color: color.tertiary.tone1,
        fontWeight: FontWeight.w500,
      ),
      bodyText1: TextStyle(
        color: color.primary.tone5,
        fontWeight: FontWeight.bold,
        fontSize: textSize.body1,
      ),
      bodyText2: TextStyle(
        color: color.secondary.tone4,
        fontSize: textSize.body1,
      ),
    ),
  );
}

Scheme get color 
  => const Scheme(
    primary: SchemeColor(
      tone1: Color(0xFFFFFFFF), 
      tone2: Color(0xE5FAFAFA), 
      tone3: Color(0xC8E7E8E9),
      tone4: Color(0xFFCFD1D4),
      tone5: Color(0xFF6F757E),
      tone6: Color(0xFFF3F3F4), 
    ),
    secondary: SchemeColor(
      tone1: Color(0xFF0D0D0D), 
      tone2: Color(0xFF27303E), 
      tone3: Color(0xFF3E3E3E), 
      tone4: Color(0xFF3F4753),
    ),
    tertiary: SchemeColor(
      tone1: Color(0xFFEA9204), 
      tone2: Color(0xFFFFF3CF),
      tone3: Color(0x00000000),
    ),
  );

  TextSize get textSize => 
    const TextSize(
      headline1: 30, 
      headline2: 20,
      headline3: 30,
      headline4: 18,
      title1: 15, 
      subtitle1: 15, 
      subtitle2: 18,
      subtitle3: 10,
      body1: 17,
    );
