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
    initializeSession().then((val) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    if (Session.authenticated == false) {
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
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Password'),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(5)),
              child: TextButton(
                onPressed: () {
                  Matrix.login(
                          kUserNameController.text, kPasswordController.text)
                      .then((value) => setState(() {
                            if (value == true) {
                              Session.key = api.accessToken;
                              populateSession(kUserNameController.text)
                                  .then((value) => setState(() {
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
              style: TextStyle(color: Colors.blue, fontSize: 15),
            ),
          ),
        ],
      );
    } else {
      return ListView(children: <Widget>[
        Text("Welcome back, ${Session.self.name}!"),
        Text("\nSession information:"),
        Text("\t\tusername: ${Session.self.username}"),
        Text("\t\tapikey: ${Session.key}"),
        TextButton(
          onPressed: () {
            deleteSession().then((value) => setState(() {}));
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
