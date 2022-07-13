import 'package:flutter/cupertino.dart';

class _Size {
  const _Size({required this.size});

  final Size size;

  double get width => size.width;
  double get height => size.height;

  double get hug => height * 0.6;
  double get fill => width * 0.9;
}

class TextSize {
  const TextSize({
    required this.headline1,
    this.headline2,
    this.headline3,
    required this.title1,
    this.title2,
    this.title3,
    required this.subtitle1,
    this.subtitle2,
    this.subtitle3,
    required this.body1,
    this.body2,

  });

  final double headline1;
  final double? headline2;
  final double? headline3;
  
  final double title1;
  final double? title2;
  final double? title3;

  final double subtitle1;
  final double? subtitle2;
  final double? subtitle3;

  final double body1;
  final double? body2;
}
