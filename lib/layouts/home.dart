import 'package:flutter/material.dart';

class HomeLayout extends StatelessWidget {
  final Color color;

  HomeLayout(this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
    );
  }
}
