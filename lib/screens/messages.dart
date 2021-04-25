import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'package:expiali/models/user.dart';
import 'package:expiali/fixtures/session.dart';

class MessagesLayout extends StatefulWidget {
  @override
  _MessagesLayoutState createState() => _MessagesLayoutState();
}

class _MessagesLayoutState extends State<MessagesLayout> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: Session.sessions.length,
        itemBuilder: (context, index) {
          UserSession _session = Session.sessions[index];
          UserMessage _latest = _session.latestMessage;
          User _model = _session.user;

          String _timestamp =
              timeago.format(_latest?.timestamp ?? _session.timestamp);

          return Column(
            children: <Widget>[
              ListTile(
                onTap: () async {
                  final value = await Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                    return MessagesSession(session: _session);
                  }));
                  setState(() {});
                },
                leading: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                          color: _model.active
                              ? Theme.of(context).accentColor
                              : Colors.transparent,
                          width: 3)),
                  child: CircleAvatar(
                      radius: 24.0,
                      backgroundImage: NetworkImage(_model.imageUrl)),
                ),
                title: Row(
                  children: <Widget>[
                    Text(_model.name,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: (_latest?.unread ?? false)
                                ? Colors.white
                                : Colors.grey)),
                    SizedBox(width: 10.0),
                    Text(_timestamp,
                        style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.grey,
                            fontWeight: (_latest?.unread ?? false)
                                ? FontWeight.bold
                                : FontWeight.normal)),
                  ],
                ),
                subtitle: Text(_latest?.content ?? "No messages",
                    style: TextStyle(
                        fontWeight: (_latest?.unread ?? false)
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: (_latest?.unread ?? false)
                            ? Colors.white
                            : Colors.grey)),
                trailing: Wrap(
                  spacing: 12,
                  alignment: WrapAlignment.start,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.notification_important,
                      size: 24.0,
                      color: Theme.of(context)
                          .accentColor
                          .withOpacity((_latest?.unread ?? false) ? 1 : 0),
                    ),
                    Icon(Icons.arrow_forward_ios, size: 14.0), // icon-2
                  ],
                ),
              ),
              Divider(height: 12.0),
            ],
          );
        },
      ),
    );
  }
}

class MessagesSession extends StatelessWidget {
  final UserSession session;

  MessagesSession({Key key, @required this.session}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    session.latestMessage?.unread = false;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: SafeArea(
          child: Container(
            padding: EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  width: 2,
                ),
                CircleAvatar(
                  backgroundImage: NetworkImage(session.user.imageUrl),
                  maxRadius: 20,
                ),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        session.user.name,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        (session.user.active ? "Online" : "Offline"),
                        style: TextStyle(
                            color: (session.user.active
                                ? Colors.white
                                : Colors.black),
                            fontSize: 13),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.settings,
                  color: Colors.black54,
                ),
              ],
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: session.messages.length,
        shrinkWrap: true,
        padding: EdgeInsets.only(top: 10, bottom: 10),
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
            child: Align(
              alignment:
                  (session.messages[index].sender != Session.self.username
                      ? Alignment.topLeft
                      : Alignment.topRight),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color:
                      (session.messages[index].sender != Session.self.username
                          ? Theme.of(context).accentColor
                          : Theme.of(context).primaryColor),
                ),
                padding: EdgeInsets.all(12),
                child: Text(
                  session.messages[index].content,
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Code for on action when pressed
            // This should be used to send message to db and display on screen
            // Only sends text if there is some text
          },
          child: const Icon(Icons.add_comment_rounded),
          backgroundColor: Theme.of(context).accentColor,
          elevation: 100),
      bottomSheet: TextFormField(
          decoration: new InputDecoration(
              hintText: "Send a message",
              contentPadding: EdgeInsets.only(left: 10))),
    );
  }
}
