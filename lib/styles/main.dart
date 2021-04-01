import 'package:flutter/material.dart';

ThemeData lightThemeBase = ThemeData.light().copyWith();
ThemeData darkThemeBase = ThemeData.dark().copyWith();

TextTheme _expialiTextTheme(TextTheme base) {
  return base.apply(fontFamily: "Nunito");
}

abstract class Themes {
  static ThemeData lightTheme = lightThemeBase.copyWith(
      brightness: Brightness.light,
      primaryColor: Colors.indigo,
      accentColor: Colors.indigoAccent,
      backgroundColor: Colors.grey,
      textTheme: _expialiTextTheme(lightThemeBase.textTheme),
      primaryTextTheme: _expialiTextTheme(lightThemeBase.textTheme),
      accentTextTheme: _expialiTextTheme(lightThemeBase.textTheme));

  static ThemeData darkTheme = darkThemeBase.copyWith(
      brightness: Brightness.dark,
      primaryColor: Colors.indigo,
      accentColor: Colors.indigoAccent,
      backgroundColor: Colors.grey,
      textTheme: _expialiTextTheme(darkThemeBase.textTheme),
      primaryTextTheme: _expialiTextTheme(darkThemeBase.textTheme),
      accentTextTheme: _expialiTextTheme(darkThemeBase.textTheme));
}
