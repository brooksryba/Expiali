import 'package:flutter/material.dart';

import 'package:expiali/plugins/matrix.dart';
import 'package:expiali/models/user.dart';
import 'package:expiali/fixtures/session.dart';

class HomeLayout extends StatefulWidget {
  @override
  _HomeLayoutState createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  final kUserNameController = TextEditingController();
  final kPasswordController = TextEditingController();

  _HomeLayoutState() {
    Session.initialize().then((val) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    if (Session.initialized == false) {
      return Text("Loading...");
    } else if (Session.authenticated == false) {
      return ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: kUserNameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'User Name',
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: kPasswordController,
              obscureText: true,
              decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'Password'),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Container(
              height: 50,
              decoration: BoxDecoration(color: Theme.of(context).accentColor, borderRadius: BorderRadius.circular(5)),
              child: TextButton(
                onPressed: () {
                  Matrix.login(kUserNameController.text, kPasswordController.text).then((value) => setState(() {
                        if (value == true) {
                          Session.key = api.accessToken;
                          Session.populate(kUserNameController.text).then((value) => setState(() {
                                Session.authenticated = true;
                              }));
                        }
                      }));
                },
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Text(
              'Forgot Password',
              style: TextStyle(color: Theme.of(context).accentColor, fontSize: 15),
            ),
          ),
        ],
      );
    } else {
      return ListView(children: <Widget>[
        Text(
          "Welcome back, ${Session.self.name}!",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text("\nSession information:"),
        Text("\t\t${Session.key}", style: TextStyle(fontSize: 10.0)),
        TextButton(
          onPressed: () {
            Session.delete().then((value) => setState(() {}));
          },
          child: Text(
            'Logout',
            style: TextStyle(color: Colors.blue, fontSize: 18),
          ),
        ),
      ]);
    }
  }
}
