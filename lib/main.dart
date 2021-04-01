import 'package:flutter/material.dart';
import 'package:Expiali/styles/main.dart';
import 'package:Expiali/skeleton.dart';
import 'package:Expiali/models/matrix.dart';

class ExpialiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Expiali',
        theme: Themes.lightTheme,
        darkTheme: Themes.darkTheme,
        themeMode: ThemeMode.dark,
        home: Skeleton(title: 'Expiali'),
        debugShowCheckedModeBanner: false);
  }
}

void main() {
  runApp(ExpialiApp());
}
