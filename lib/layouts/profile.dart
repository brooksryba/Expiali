import 'package:Expiali/models/matrix.dart';
import 'package:flutter/material.dart';

class ProfileLayout extends StatefulWidget {
  @override
  _ProfileLayoutState createState() => _ProfileLayoutState();
}

class _ProfileLayoutState extends State<ProfileLayout> {
  String _profileURL = "";
  String _profileName = "Loading User...";

  _ProfileLayoutState() {
    MatrixHelper.getServerInfo().then((val) => setState(() {
          _profileURL = val[0];
          _profileName = val[1];
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      CircleAvatar(backgroundImage: NetworkImage(_profileURL)),
      Text(_profileName)
    ]));
  }
}
