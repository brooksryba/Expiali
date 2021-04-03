import 'package:expiali/models/user.dart';
import 'package:expiali/models/group.dart';


final sessionSelf = User(username: "deisumus", name: "Brooks Ryba");

List<User> sessionUsers = [
	User(username: "testUser1", name: "Test User 1", imageUrl: "https://randomuser.me/api/portraits/men/85.jpg"),
	User(username: "testUser2", name: "Test User 2", imageUrl: "https://randomuser.me/api/portraits/women/77.jpg"),
	User(username: "testUser3", name: "Test User 3", imageUrl: "https://randomuser.me/api/portraits/men/81.jpg"),
	User(username: "testUser4", name: "Test User 4", imageUrl: "https://randomuser.me/api/portraits/women/49.jpg"),
	User(username: "testUser5", name: "Test User 5", imageUrl: "https://randomuser.me/api/portraits/men/87.jpg"),
];


List<UserMessage> sessionMessages = [
	UserMessage(sender: "deisumus", recipient: "testUser1", content: "Hello World!"),
	UserMessage(sender: "testUser1", recipient: "deisumus", content: "It Worked!"),
	UserMessage(sender: "deisumus", recipient: "testUser1", content: "Expiali."),
];


List<Group> sessionGroups = [
	Group(title: "Test Group 1", description: "This is a test group")
];
