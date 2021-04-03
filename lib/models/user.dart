class User {
    User({
		this.username,
        this.name,
        this.imageUrl,
		this.profile,
		this.active});
    
    final String username;
    final String name;
    final String imageUrl;
	final UserProfile profile;
	bool active;
}

enum UserLanguage {
	english, spanish, chinese, french,
	tagalog, vietnamese, korean, german,
	arabic, russian
}

enum UserPronoun {
	he, him, his, himself,
	she, her, hers, herself,
	they, them, their, themself,
	sie, hir, hirself,
	zie, zir, zirself
}

enum UserIdentity {
	agender, androgynous, bigender,
	cis, genderfluid, genderqueer,
	nonconforming, hijra, intersex,
	man, nonbinary, pangender, transfeminine,
	transgender, transsexual, transman, 
	transwoman, twospirit, woman
}

enum UserOrientiation {
	asexual, bisexual, gay, homoflexible, 
	heteroflexible, lesbian, pansexual,
	queer, questioning, straight
}

enum UserSocialMedia {
	facebook, instagram, snapchat,
	twitter
}

class UserProfile {
	UserProfile({
		this.biography,
		this.birthdate,
		this.pronouns,
		this.identity,
		this.orientation,
		this.location,
		this.language,
		this.school,
		this.profession});

	final String biography;
	final DateTime birthdate;
	final List<UserPronoun> pronouns;
	final UserIdentity identity;
	final UserOrientiation orientation;
	final UserLanguage language;
	final String location;
	final String school;
	final String profession;
}

class UserMessage {
    UserMessage({
		this.sender,
		this.recipient,
        this.content,
		this.timestamp,
		this.unread});
    
    final String sender;
    final String recipient;
    final String content;
	final DateTime timestamp;
	final bool unread;
}

class UserSession {
	UserSession({
		this.user,
		this.timestamp,
		this.latestMessage});

	final User user;
	final DateTime timestamp;
	final UserMessage latestMessage;
}