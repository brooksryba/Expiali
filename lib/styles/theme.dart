import 'package:flutter/material.dart';

/// Define theme bases to extend below
ThemeData _lightThemeBase = ThemeData.light().copyWith();
ThemeData _darkThemeBase = ThemeData.dark().copyWith();

/// Define text bases to use below
TextTheme _lightTextBase = _lightThemeBase.textTheme.apply(fontFamily: "Nunito");
TextTheme _darkTextBase = _darkThemeBase.textTheme.apply(fontFamily: "Nunito");


abstract class Themes {
	/// Extend the base Material Application themes
	/// with the Expiali brand style information. 
	/// This includes the brand colors and font
	/// information. 

	static ThemeData light = _lightThemeBase.copyWith(
		brightness: Brightness.light,
		primaryColor: Colors.indigo,
		accentColor: Colors.indigoAccent,
		backgroundColor: Colors.grey,
		textTheme: _lightTextBase,
		primaryTextTheme: _lightTextBase,
		accentTextTheme: _lightTextBase
	);

	static ThemeData dark = _darkThemeBase.copyWith(
		brightness: Brightness.dark,
		primaryColor: Colors.indigo,
		accentColor: Colors.indigoAccent,
		backgroundColor: Colors.grey,
		textTheme: _darkTextBase,
		primaryTextTheme: _darkTextBase,
		accentTextTheme: _darkTextBase
	);
}
