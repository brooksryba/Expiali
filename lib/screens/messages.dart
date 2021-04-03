import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'package:expiali/models/user.dart';
import 'package:expiali/fixtures/session.dart';


class MessagesLayout extends StatelessWidget {
	MessagesLayout();

	@override
	Widget build(BuildContext context) {
		return Container(
			child: ListView.builder(
				itemCount: sessionMessageUsers.length,
				itemBuilder: (context, index) {
					UserSession _session = sessionMessageUsers[index];
					UserMessage _latest = _session.latestMessage;
					User _model = _session.user;

					String _timestamp = timeago.format(_latest?.timestamp ?? _session.timestamp);

					return Column(
						children: <Widget>[
							ListTile(
								leading: Container(
									decoration: BoxDecoration(
										borderRadius: BorderRadius.circular(30),
										border: Border.all(color: _model.active ? Theme.of(context).accentColor : Colors.transparent, width: 3)),
									child: CircleAvatar(radius: 24.0, backgroundImage: NetworkImage(_model.imageUrl)),
								),
								title: Row(
									children: <Widget>[
										Text(_model.name),
										SizedBox(width: 10.0),
										Text(_timestamp, style: TextStyle(fontSize: 12.0, color: Colors.grey)),
									],
								),
								subtitle: Text(_latest?.content ?? "No messages."),
								trailing: Icon(Icons.arrow_forward_ios, size: 14.0),
							),
							Divider(height: 12.0),
						],
					);
				},
			),
      	);
	}
}
