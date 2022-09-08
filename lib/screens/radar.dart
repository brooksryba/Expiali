import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

final String readIntents = """
    query readIntents() {
		interests {
			id
			title
			description
		}
    }
""";

class RadarLayout extends StatelessWidget {
  RadarLayout();

  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(
        document: gql(readIntents),
      ),
      builder: (QueryResult result, {VoidCallback refetch, FetchMore fetchMore}) {
        if (result.hasException) {
          return Text(result.exception.toString());
        }

        if (result.isLoading) {
          return Text('Loading');
        }

        // it can be either Map or List
        List interests = result.data['interests'];

        return ListView.builder(
            itemCount: interests.length,
            itemBuilder: (context, index) {
              return Text(interests[index]['title']);
            });
      },
    );
  }
}
