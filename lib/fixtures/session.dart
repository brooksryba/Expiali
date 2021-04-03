import 'package:expiali/models/user.dart';
import 'package:expiali/models/group.dart';


final sessionSelf = User(username: "deisumus", name: "Brooks Ryba");
final sessionSelfProfile = UserProfile(
	biography: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam fermentum nec metus id eleifend. Aenean viverra lacus nisl, mattis vehicula nisl iaculis at. Vivamus euismod placerat ultrices.",
	birthdate: DateTime.parse("1994-05-03 05:00:00"),
	pronouns: [UserPronoun.he, UserPronoun.him],
	identity: UserIdentity.man,
	orientation: UserOrientiation.straight,
	language: UserLanguage.english,
	school: "",
	profession: "");

final List<User> sessionUsers = [
	User(username: "testUser1", name: "Joeseph", imageUrl: "https://randomuser.me/api/portraits/men/85.jpg", active: true),
	User(username: "testUser2", name: "Karen", imageUrl: "https://randomuser.me/api/portraits/women/77.jpg", active: false),
	User(username: "testUser3", name: "Andrew", imageUrl: "https://randomuser.me/api/portraits/men/81.jpg", active: false),
	User(username: "testUser4", name: "Kate", imageUrl: "https://randomuser.me/api/portraits/women/49.jpg", active: false),
	User(username: "testUser5", name: "Richard", imageUrl: "https://randomuser.me/api/portraits/men/87.jpg", active: false),
];


final List<UserMessage> sessionMessages = [
	UserMessage(sender: "deisumus", recipient: "testUser2", content: "Hello World!", timestamp: DateTime.parse("2021-04-01 12:00"), unread: false),
	UserMessage(sender: "deisumus", recipient: "testUser1", content: "Hello World!", timestamp: DateTime.parse("2021-04-01 12:00"), unread: false),
	UserMessage(sender: "testUser1", recipient: "deisumus", content: "It Worked!", timestamp: DateTime.parse("2021-04-01 12:01"), unread: false),
	UserMessage(sender: "deisumus", recipient: "testUser1", content: "Expiali.", timestamp: DateTime.now().subtract(new Duration(minutes: 15)), unread: true),
];


final List<UserSession> sessionMessageUsers = [
	UserSession(user: sessionUsers[0], latestMessage: sessionMessages[3]),
	UserSession(user: sessionUsers[1], latestMessage: sessionMessages[0]),
	UserSession(user: sessionUsers[2], timestamp: DateTime.parse("2021-03-01 12:00")),
	UserSession(user: sessionUsers[3], timestamp: DateTime.parse("2021-02-01 12:00")),
];


final List<Group> sessionGroups = [
	Group(title: "Test Group 1", description: "This is a test group")
];
