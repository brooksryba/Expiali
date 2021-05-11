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
    if (_user != null) {
      return ListView(
        children: <Widget>[
          Container(
              width: MediaQuery.of(context).size.width,
              height: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fitWidth,
                  image: NetworkImage(_user.imageUrl),
                ),
                boxShadow: <BoxShadow>[BoxShadow(blurRadius: 30, spreadRadius: 7, color: Colors.black38)],
              )),
          Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.start, children: [
                Text("${_user.name}", style: TextStyle(fontSize: 32)),
                Text("${DateFormat('MM-dd-yyyy').format(_profile.birthdate)}", style: TextStyle(fontSize: 16)),
                SizedBox(height: 10),
                Wrap(
                  spacing: 5,
                  runSpacing: 5,
                  alignment: WrapAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(7),
                      child: Wrap(children: [
                        Text(
                          "Pronouns: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                            "${EnumToString.convertToString(_profile.pronouns[0], camelCase: true)} / ${EnumToString.convertToString(_profile.pronouns[1], camelCase: true)}")
                      ]),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            stops: [0.0, 0.5],
                            colors: [Theme.of(context).primaryColor, Theme.of(context).accentColor],
                          ),
                          borderRadius: const BorderRadius.all(const Radius.circular(5))),
                    ),
                    Container(
                      padding: EdgeInsets.all(7),
                      child: Wrap(children: [
                        Text(
                          "Identity: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(EnumToString.convertToString(_profile.identity, camelCase: true))
                      ]),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            stops: [0.0, 0.5],
                            colors: [Theme.of(context).primaryColor, Theme.of(context).accentColor],
                          ),
                          borderRadius: const BorderRadius.all(const Radius.circular(5))),
                    ),
                    Container(
                      padding: EdgeInsets.all(7),
                      child: Wrap(children: [
                        Text(
                          "Language: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(EnumToString.convertToString(_profile.language, camelCase: true))
                      ]),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            stops: [0.0, 0.5],
                            colors: [Theme.of(context).primaryColor, Theme.of(context).accentColor],
                          ),
                          borderRadius: const BorderRadius.all(const Radius.circular(5))),
                    ),
                    Container(
                      padding: EdgeInsets.all(7),
                      child: Wrap(children: [
                        Text(
                          "Orientation: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          EnumToString.convertToString(_profile.orientation, camelCase: true),
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
                    ),
                  ],
                ),

                //Text("${_profile.school ?? "No School"} - ${_profile.profession ?? "No Profession"}"),
                SizedBox(height: 32.0),
                Text(
                  _profile.biography,
                  style: TextStyle(color: Theme.of(context).backgroundColor, fontSize: 15),
                )
              ])),
        ],
      );
    } else {
      return ListView(children: [Text("Not logged in")]);
    }
  }
}
