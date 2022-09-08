import 'package:expiali/plugins/session.dart';
import 'package:flutter/material.dart';

import 'package:graphql_flutter/graphql_flutter.dart';

String authUser = """
  mutation AuthUser(\$email: String!, \$password: String!) {
    authUser(input: {credentials: {email: \$email, password: \$password}}) {
      token
    }
  }
""";

class LoginLayout extends StatefulWidget {
  final Function successCallback;

  LoginLayout({Key key, @required this.successCallback}) : super(key: key);

  @override
  _LoginLayoutState createState() => _LoginLayoutState();
}

class _LoginLayoutState extends State<LoginLayout> {
  final kEmailController = TextEditingController();
  final kPasswordController = TextEditingController();

  _LoginLayoutState();

  @override
  Widget build(BuildContext context) {
    return Mutation(
      options: MutationOptions(
        document: gql(authUser), // this is the mutation string you just created
        // you can update the cache based on results
        update: (GraphQLDataProxy cache, QueryResult result) {
          return cache;
        },
        // or do something with the result.data on completion
        onCompleted: (dynamic resultData) {
          if (resultData["authUser"] != null) {
            SESSION_AUTH_TOKEN = resultData["authUser"]["token"];
            widget.successCallback();
            print(SESSION_AUTH_TOKEN);
          }
        },
      ),
      builder: (
        RunMutation runMutation,
        QueryResult result,
      ) {
        return ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: kEmailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'E-Mail',
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
                    runMutation({'email': kEmailController.text, 'password': kPasswordController.text});
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
      },
    );
  }
}
