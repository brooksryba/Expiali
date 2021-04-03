import 'package:matrix_api_lite/matrix_api_lite.dart';

MatrixApi api = MatrixApi(homeserver: Uri.parse('https://matrix.org'));


class Matrix {
	/// Provide a set of utilies around the matrix api
	/// that can be used to complete any operations 
	/// within the rest of the application.

	static Future<bool> login(username, password) async {
		final ident = AuthenticationUserIdentifier(user: username);
		final response = await api.login(identifier: ident, password: password);

		/// Update the api with the working token
		api.accessToken = response.accessToken;
		return true;
	}

	static Future getServerInfo() async {
		return await api.requestServerCapabilities();
	}

	static Future getUserProfile() async {
		return await api.requestProfile("@deisumus:matrix.org");
	}

	static Future getUserAvatar() async {
		final response = await api.requestAvatarUrl("@deisumus:matrix.org");
		return "https://matrix-client.matrix.org/_matrix/media/r0/thumbnail/matrix.org/" +
				response.toString().split("/")[3] +
				"?width=32&height=32";
	}
}
