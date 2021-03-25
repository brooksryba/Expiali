import 'package:flutter/material.dart';
import 'package:Expiali/layouts/home.dart';
import 'package:Expiali/layouts/radar.dart';
import 'package:Expiali/layouts/intents.dart';
import 'package:Expiali/layouts/messages.dart';
import 'package:Expiali/layouts/profile.dart';


class Skeleton extends StatefulWidget {
  Skeleton({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SkeletonState createState() => _SkeletonState();
}


class _SkeletonState extends State<Skeleton> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    HomeLayout(),
    RadarLayout(),
    IntentsLayout(),
    MessagesLayout(),
    ProfileLayout()
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.public), label: "Radar"),
          BottomNavigationBarItem(icon: Icon(Icons.color_lens_outlined), label: "Intents"),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Messages"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile")
        ],
      ),
    );
  }
}