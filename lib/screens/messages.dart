import 'package:flutter/material.dart';

import 'package:expiali/models/user.dart';
import 'package:expiali/fixtures/session.dart';


class MessagesLayout extends StatelessWidget {
	MessagesLayout();

	@override
	Widget build(BuildContext context) {
		return Container(
			child: ListView.builder(
				itemCount: sessionUsers.length,
				itemBuilder: (context, index) {
					User _model = sessionUsers[index];
					return Column(
						children: <Widget>[
							Divider(height: 12.0),
							ListTile(
								leading: CircleAvatar(
									radius: 24.0,
									backgroundImage: NetworkImage(_model.imageUrl),
								),
								title: Row(
									children: <Widget>[
										Text(_model.name),
										SizedBox(width: 16.0),
										Text("12:00", style: TextStyle(fontSize: 12.0)),
									],
								),
								subtitle: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit."),
								trailing: Icon(
									Icons.arrow_forward_ios,
									size: 14.0,
								),
							),
						],
					);
				},
			),
      	);
	}
}
