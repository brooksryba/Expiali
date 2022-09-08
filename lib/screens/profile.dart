import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'package:expiali/models/user.dart';
import 'package:expiali/widgets/image_box.dart';
import 'package:expiali/widgets/titled_tag.dart';

final String readViewer = """
    query readViewer() {
      viewer {
        id
          firstName
          lastName
          birthdate
          profile{
            biography
            nickname
          }
          preference {
            maxAge
            minAge
            maxDistance
          }
          pingedAt
      }
    }
""";

class ProfileLayout extends StatefulWidget {
  @override
  _ProfileLayoutState createState() => _ProfileLayoutState();
}

class _ProfileLayoutState extends State<ProfileLayout> {
  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(
        document: gql(readViewer),
      ),
      builder: (QueryResult result, {VoidCallback refetch, FetchMore fetchMore}) {
        if (result.hasException) {
          return Text(result.exception.toString());
        }

        if (result.isLoading) {
          return Text('Loading');
        }

        // it can be either Map or List
        Map viewer = result.data['viewer'];

        return ListView(
          children: <Widget>[
            ImageBox(NetworkImage(""), 300),
            Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.start, children: [
              SizedBox(height: 32.0),
              Text("${viewer['firstName']}", style: TextStyle(fontSize: 32)),
              Text("${DateFormat('MM-dd-yyyy').format(DateTime.parse(viewer['birthdate']))}", style: TextStyle(fontSize: 16)),
              SizedBox(height: 10),
              Wrap(
                spacing: 5,
                runSpacing: 5,
                alignment: WrapAlignment.center,
                children: [
                  TitledTag("Pronouns", ""),
                  TitledTag("Identity", ""),
                  TitledTag("Language", ""),
                  TitledTag("Orientation", ""),
                  TitledTag("School", "${null ?? "None"}"),
                  TitledTag("Work", "${null ?? "None"}"),
                ],
              ),
              Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Text(
                    viewer["profile"]["biography"],
                    style: TextStyle(color: Theme.of(context).backgroundColor, fontSize: 15),
                  )),
            ]),
          ],
        );
      },
    );
  }
}
