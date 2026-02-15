import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const white = Colors.white;
  static const black = Color(0xFF000000);
  static const green = Color(0xFF2ecc71);
  static const gray = Color(0xFFF5F5F5);
  static const blue = Color(0xFF1f3a93);

  static const appColor = MaterialColor(0xFF1f3a93, {
    50: Color.fromRGBO(31, 58, 147, .1),
    100: Color.fromRGBO(31, 58, 147, 0.2),
    200: Color.fromRGBO(31, 58, 147, .3),
    300: Color.fromRGBO(31, 58, 147, .4),
    400: Color.fromRGBO(31, 58, 147, .5),
    500: Color.fromRGBO(31, 58, 147, .6),
    600: Color.fromRGBO(31, 58, 147, .7),
    700: Color.fromRGBO(31, 58, 147, .8),
    800: Color.fromRGBO(31, 58, 147, .9),
    900: Color.fromRGBO(31, 58, 147, 1),
  });
}
