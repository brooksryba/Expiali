import 'package:matrix_api_lite/matrix_api_lite.dart';

class MatrixHelper {
  static Future<List> getServerInfo() async {
    final api = MatrixApi(homeserver: Uri.parse('https://matrix.org'));
    final auth = await api.login(
        identifier: AuthenticationUserIdentifier(user: 'deisumus'),
        password: 'Robotics890*');
    api.accessToken = auth.accessToken;

    final capabilities = await api.requestServerCapabilities();
    print(capabilities.toJson());

    final profile = await api.requestProfile("@deisumus:matrix.org");
    print(profile.toJson());

    final avatar = await api.requestAvatarUrl("@deisumus:matrix.org");
    print(avatar);

    final avatar_url =
        "https://matrix-client.matrix.org/_matrix/media/r0/thumbnail/matrix.org/" +
            avatar.toString().split("/")[3] +
            "?width=32&height=32";
    print(avatar_url);

    return [avatar_url, profile.displayname];
  }
}
