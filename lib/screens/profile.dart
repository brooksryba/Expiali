import 'package:flutter/material.dart';

import 'package:expiali/plugins/matrix.dart';


class ProfileLayout extends StatefulWidget {
	@override
	_ProfileLayoutState createState() => _ProfileLayoutState();
}

class _ProfileLayoutState extends State<ProfileLayout> {
	String _profileURL = "";
	String _profileName = "Loading User...";

	_ProfileLayoutState() {
		Matrix.getUserProfile().then((val) => setState(() { _profileName = val.displayname; }));
		Matrix.getUserAvatar().then((val) => setState(() { _profileURL = val; }));			
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			body: Column(
				children: [
					CircleAvatar(backgroundImage: NetworkImage(_profileURL)),
					Text(_profileName)
				]
			)
		);
	}
}
