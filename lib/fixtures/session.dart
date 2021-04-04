import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:expiali/models/user.dart';
import 'package:expiali/models/group.dart';
import 'package:expiali/plugins/matrix.dart';

// Create storage
final storage = new FlutterSecureStorage();

deleteSession() async {
  await storage.deleteAll();
  Session.authenticated = false;
  Session.key = null;
  Session.self = null;
  Session.profile = null;
}

initializeSession() async {
  Session.key = await storage.read(key: "apiKey");
  final username = await storage.read(key: "username");

  if (Session.key != null && username != null) {
    Session.authenticated = true;
    await populateSession(username);
  } else {
    Session.authenticated = false;
  }
}

serializeSession() async {
  await storage.write(key: "apiKey", value: Session.key);
  await storage.write(key: "username", value: Session.self.username);
}

populateSession(username) async {
  await Matrix.getUserProfile(username).then(((profile) {
    Session.profile = UserProfile(
        biography:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam fermentum nec metus id eleifend. Aenean viverra lacus nisl, mattis vehicula nisl iaculis at. Vivamus euismod placerat ultrices. In sit amet felis at libero euismod varius. Fusce a leo erat. Donec sodales leo eget elit faucibus, egestas consectetur elit vehicula. Fusce ut egestas urna, ac dictum tellus. Nulla ante sapien, scelerisque et molestie quis, tincidunt vitae diam. Aliquam aliquam lorem ipsum. Ut lectus nisl, scelerisque vitae ante quis, rhoncus luctus mi.\n\nMorbi varius nisl id dapibus luctus. Etiam condimentum dolor quam, eget blandit augue dignissim et. Phasellus at mattis risus. Maecenas laoreet blandit turpis, et elementum purus bibendum et. Sed vel nisl sollicitudin, molestie mi ac, malesuada ante. Sed efficitur lacinia ligula at ullamcorper. Nunc vulputate nec magna ut finibus. Vivamus tincidunt lorem nec arcu dapibus posuere. Curabitur enim turpis, maximus quis nunc quis, eleifend convallis elit. Fusce consectetur massa luctus, tempor lorem ac, ornare sapien.",
        birthdate: DateTime.parse("1980-01-01 00:00:00"),
        pronouns: [UserPronoun.he, UserPronoun.him],
        identity: UserIdentity.man,
        orientation: UserOrientiation.straight,
        language: UserLanguage.english);

    Session.self = User(
        username: username,
        name: profile.displayname,
        imageUrl: Matrix.getUserAvatar(profile.avatarUrl),
        profile: Session.profile);

    print("Populated");
    serializeSession();
  }));
}

abstract class Session {
  static bool authenticated = false;
  static String key;

  static UserProfile profile;
  static User self;

  static List<User> users = _users;
  static List<UserMessage> messages = _messages;
  static List<UserSession> sessions = _sessions;
}

List<User> _users = [
  User(
      username: "testUser1",
      name: "Joeseph",
      imageUrl: "https://randomuser.me/api/portraits/men/85.jpg",
      active: false),
  User(
      username: "testUser2",
      name: "Karen",
      imageUrl: "https://randomuser.me/api/portraits/women/77.jpg",
      active: false),
  User(
      username: "testUser3",
      name: "Andrew",
      imageUrl: "https://randomuser.me/api/portraits/men/81.jpg",
      active: true),
  User(
      username: "testUser4",
      name: "Kate",
      imageUrl: "https://randomuser.me/api/portraits/women/49.jpg",
      active: true),
  User(
      username: "testUser5",
      name: "Richard",
      imageUrl: "https://randomuser.me/api/portraits/men/87.jpg",
      active: false),
];

List<UserMessage> _messages = [
  UserMessage(
      sender: "deisumus",
      recipient: "testUser2",
      content: "Hello World!",
      timestamp: DateTime.parse("2021-04-01 12:00"),
      unread: false),
  UserMessage(
      sender: "deisumus",
      recipient: "testUser1",
      content: "Hello World!",
      timestamp: DateTime.parse("2021-04-01 12:00"),
      unread: false),
  UserMessage(
      sender: "testUser1",
      recipient: "deisumus",
      content: "It Worked!",
      timestamp: DateTime.parse("2021-04-01 12:01"),
      unread: false),
  UserMessage(
      sender: "deisumus",
      recipient: "testUser1",
      content: "Expiali.",
      timestamp: DateTime.now().subtract(new Duration(minutes: 15)),
      unread: true),
];

List<UserSession> _sessions = [
  UserSession(
      user: _users[0],
      latestMessage: _messages[3],
      messages: [_messages[1], _messages[2], _messages[3]]),
  UserSession(
      user: _users[1], latestMessage: _messages[0], messages: [_messages[0]]),
  UserSession(
      user: _users[2],
      timestamp: DateTime.parse("2021-03-01 12:00"),
      messages: []),
  UserSession(
      user: _users[3],
      timestamp: DateTime.parse("2021-02-01 12:00"),
      messages: []),
];

List<Group> groups = [
  Group(title: "Test Group 1", description: "This is a test group")
];
