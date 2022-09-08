import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'package:graphql_flutter/graphql_flutter.dart';

final String readConversations = """
    query readConversations() {
		conversations {
			id
				authorId
				recipientId
				messages {
					id
					authorId
					content
					createdAt
				}
		}
    }
""";

class MessagesLayout extends StatefulWidget {
  @override
  _MessagesLayoutState createState() => _MessagesLayoutState();
}

class _MessagesLayoutState extends State<MessagesLayout> {
  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(
        document: gql(readConversations),
        fetchPolicy: FetchPolicy.noCache,
      ),
      builder: (QueryResult result, {VoidCallback refetch, FetchMore fetchMore}) {
        if (result.hasException) {
          return Text(result.exception.toString());
        }

        if (result.isLoading) {
          return Text('Loading');
        }

        // it can be either Map or List
        List conversations = result.data['conversations'];

        return Container(
          child: ListView.builder(
            itemCount: conversations.length,
            itemBuilder: (context, index) {
              var _model = conversations[index];
              var _latest = _model["messages"][_model["messages"].length - 1];
              String _timestamp = timeago.format(DateTime.parse(_latest["createdAt"]));

              return Column(
                children: <Widget>[
                  ListTile(
                    onTap: () async {
                      final value = await Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return MessagesSession(model: _model);
                      }));
                      setState(() {});
                    },
                    leading: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: false ? Theme.of(context).accentColor : Colors.transparent, width: 3)),
                      child: CircleAvatar(radius: 24.0, backgroundImage: NetworkImage("")),
                    ),
                    title: Row(
                      children: <Widget>[
                        Text(_model["recipientId"].toString(),
                            style: TextStyle(fontWeight: FontWeight.bold, color: (false) ? Colors.white : Colors.grey)),
                        SizedBox(width: 10.0),
                        Text(_timestamp,
                            style: TextStyle(fontSize: 12.0, color: Colors.grey, fontWeight: (false) ? FontWeight.bold : FontWeight.normal)),
                      ],
                    ),
                    subtitle: Text(_latest["content"] ?? "No messages",
                        style: TextStyle(fontWeight: (false) ? FontWeight.bold : FontWeight.normal, color: (false) ? Colors.white : Colors.grey)),
                    trailing: Wrap(
                      spacing: 12,
                      alignment: WrapAlignment.start,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.notification_important,
                          size: 24.0,
                          color: Theme.of(context).accentColor.withOpacity((false) ? 1 : 0),
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
      },
    );
  }
}

class MessagesSession extends StatelessWidget {
  final model;

  MessagesSession({Key key, @required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  backgroundImage: NetworkImage(""),
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
                        model["recipientId"].toString(),
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        (false ? "Online" : "Offline"),
                        style: TextStyle(color: (false ? Colors.white : Colors.black), fontSize: 13),
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
        itemCount: model["messages"].length,
        shrinkWrap: true,
        padding: EdgeInsets.only(top: 10, bottom: 10),
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
            child: Align(
              alignment: (model["messages"][index]["authorId"] != model["authorId"] ? Alignment.topLeft : Alignment.topRight),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: (model["messages"][index]["authorId"] != model["authorId"] ? Theme.of(context).accentColor : Theme.of(context).primaryColor),
                ),
                padding: EdgeInsets.all(12),
                child: Text(
                  model["messages"][index]["content"],
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
