import 'package:flutter/material.dart';
import 'package:my_recipes/utils/utils.dart';

final theme = ThemeData(
  primaryColor: color.primary.tone2,
  backgroundColor: color.primary.tone1,
  appBarTheme: AppBarTheme(
    color: color.primary.tone1,
  ),
  iconTheme: IconThemeData(
    color: color.secondary.tone4,
  ),
);

const color = Scheme(
  primary: SchemeColor(
    tone1: Color(0xFFFFFFFF), 
    tone2: Color(0xE5FAFAFA), 
    tone3: Color(0xC8E7E8E9),
    tone4: Color(0xFF6F757E), 
  ),
  secondary: SchemeColor(
    tone1: Color(0xFF0D0D0D), 
    tone2: Color(0xFF27303E), 
    tone3: Color(0xFF3E3E3E), 
    tone4: Color(0xFF3F4753),
  ),
  thirty: SchemeColor(
    tone1: Color(0xFFEA9204), 
    tone2: Color(0xFFFFF3CF),
  ),
);