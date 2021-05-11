import 'package:flutter/material.dart';

class TitledTag extends StatelessWidget {
  TitledTag(this.title, this.value);

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(7),
      child: Wrap(children: [
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(
          value,
        )
      ]),
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [0.0, 0.5],
            colors: [Theme.of(context).primaryColor, Theme.of(context).accentColor],
          ),
          borderRadius: const BorderRadius.all(const Radius.circular(5))),
    );
  }
}
