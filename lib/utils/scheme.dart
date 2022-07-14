import 'package:flutter/cupertino.dart';

class Scheme {
  const Scheme({
    required this.primary,
    required this.secondary,
    required this.tertiary,
  });

  final SchemeColor primary;
  final SchemeColor secondary;
  final SchemeColor tertiary;
}

class SchemeColor {
  const SchemeColor({
    required this.tone1,
    required this.tone2,
    this.tone3,
    this.tone4,
    this.tone5,
    this.tone6,
  });

  final Color tone1;
  final Color tone2;
  final Color? tone3;
  final Color? tone4;
  final Color? tone5;
  final Color? tone6;
}
