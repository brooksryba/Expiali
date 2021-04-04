import 'package:matrix_api_lite/matrix_api_lite.dart';

String homeserver = "matrix.org";
String cdnserver = "matrix-client.matrix.org";
String resourceUrl = "https://$cdnserver/_matrix/media/r0/thumbnail/$homeserver";
MatrixApi api = MatrixApi(homeserver: Uri.parse("https://$homeserver"));

class Matrix {
  /// Provide a set of utilies around the matrix api
  /// that can be used to complete any operations
  /// within the rest of the application.

  static Future login(username, password) async {
    try {
      final ident = AuthenticationUserIdentifier(user: username);
      final response = await api.login(identifier: ident, password: password);

      /// Update the api with the working token
      api.accessToken = response.accessToken;
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future getServerInfo() async {
    return await api.requestServerCapabilities();
  }

  static Future getUserProfile(username) async {
    return await api.requestProfile("@$username:matrix.org");
  }

  static String getUserAvatar(uri, {height = 32, width = 32}) {
    final resource = uri.toString().split("/")[3];
    return "$resourceUrl/$resource?width=$width&height=$height";
  }
}
