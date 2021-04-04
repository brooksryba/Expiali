import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:enum_to_string/enum_to_string.dart';

import 'package:expiali/plugins/matrix.dart';
import 'package:expiali/models/user.dart';
import 'package:expiali/fixtures/session.dart';

class ProfileLayout extends StatefulWidget {
  @override
  _ProfileLayoutState createState() => _ProfileLayoutState();
}

class _ProfileLayoutState extends State<ProfileLayout> {
  User _user = Session.self;
  UserProfile _profile = Session.profile;

  _ProfileLayoutState() {}

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.start, children: [
              CircleAvatar(backgroundImage: NetworkImage(_user.imageUrl), radius: 60.0),
              Text(
                  "${_user.name} (${EnumToString.convertToString(_profile.pronouns[0], camelCase: true)} / ${EnumToString.convertToString(_profile.pronouns[1], camelCase: true)})"),
              Text("Birthday: ${DateFormat('MM-dd-yyyy').format(_profile.birthdate)}"),
              Text(EnumToString.convertToString(_profile.language, camelCase: true)),
              Text(EnumToString.convertToString(_profile.identity, camelCase: true)),
              Text(EnumToString.convertToString(_profile.orientation, camelCase: true)),
              Text("${_profile.school ?? "No School"} - ${_profile.profession ?? "No Profession"}"),
              SizedBox(height: 16.0),
              Text(_profile.biography)
            ])),
      ],
    );
  }
}
