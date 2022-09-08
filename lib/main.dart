import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'package:expiali/plugins/session.dart';

import 'package:expiali/styles/theme.dart';
import 'package:expiali/screens/login.dart';
import 'package:expiali/screens/home.dart';
import 'package:expiali/screens/radar.dart';
import 'package:expiali/screens/settings.dart';
import 'package:expiali/screens/messages.dart';
import 'package:expiali/screens/profile.dart';

class ExpialiApp extends StatelessWidget {
  /// Wrapper of MaterialApp that returns the
  /// application skeleton with theme context
  /// and configures other properties.

  @override
  Widget build(BuildContext context) {
    ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(
        link: AuthLink(getToken: () => SESSION_AUTH_TOKEN).concat(HttpLink(
          "http://10.0.2.2:3000/graphql",
        )),
        cache: GraphQLCache(store: HiveStore()),
      ),
    );

    return GraphQLProvider(
        client: client,
        child: MaterialApp(
          title: 'Expiali',
          theme: Themes.light,
          darkTheme: Themes.dark,
          themeMode: ThemeMode.dark,
          debugShowCheckedModeBanner: false,
          home: ExpialiSkeleton(),
        ));
  }
}

class ExpialiSkeleton extends StatefulWidget {
  /// Provide an application skeleton using
  /// a stateful widget that is capable of
  /// displaying the individual layouts.
  ExpialiSkeleton({Key key}) : super(key: key);

  @override
  _ExpialiSkeletonState createState() => _ExpialiSkeletonState();
}

class _ExpialiSkeletonState extends State<ExpialiSkeleton> {
  /// Keep track of the current layout selection
  int _currentIndex = 0;
  bool _authorized = false;

  /// Initialize the child layouts for rendering
  final List<Widget> _children = [HomeLayout(), RadarLayout(), MessagesLayout(), ProfileLayout(), SettingsLayout()];

  /// Handle the event from the BottomNavigationBar
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void onLoginSuccess() {
    setState(() {
      _authorized = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return !_authorized
        ? Scaffold(
            body: LoginLayout(
              successCallback: onLoginSuccess,
            ),
            appBar: AppBar(title: Text("Expiali")),
          )
        : Scaffold(
            body: _children[_currentIndex],
            appBar: AppBar(title: Text("Expiali")),
            bottomNavigationBar: BottomNavigationBar(
              onTap: onTabTapped,
              currentIndex: _currentIndex,
              selectedItemColor: Theme.of(context).accentColor,
              unselectedItemColor: Theme.of(context).backgroundColor,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: "Home",
                ),
                BottomNavigationBarItem(icon: Icon(Icons.public), label: "Radar"),
                BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Messages"),
                BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
                BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings")
              ],
            ),
          );
  }
}

void main() async {
  await initHiveForFlutter();

  runApp(ExpialiApp());
}
