
import 'package:flutter/material.dart';

//light/primary
ThemeData themeData(BuildContext context){
  return ThemeData(
    brightness: Brightness.light,
    primaryColor: Color(0xFF1F3A93),
    scaffoldBackgroundColor: Color(0xFFF8F9FB),
    colorScheme: ColorScheme.light(
      primary: Color(0xFF1F3A93),
      secondary: Color(0xFF2ECC71),
    ),
    cardColor: Colors.white,
  );
}

ThemeData darkThemeData(BuildContext context){
  return ThemeData(
    brightness: Brightness.dark,
    primaryColor: Color(0xFF3B5EDB),
    scaffoldBackgroundColor: Color(0xFF0F172A),
    colorScheme: ColorScheme.dark(
      primary: Color(0xFF3B5EDB),
      secondary: Color(0xFF2ECC71),
    ),
    cardColor: Color(0xFF1E293B),
  );
}

AppBarTheme appBarTheme = AppBarTheme(backgroundColor: Colors.transparent, elevation: 0,);