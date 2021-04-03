class User {
    User({
		this.username,
        this.name,
        this.imageUrl,
        this.biography});
    
    final String username;
    final String name;
    final String imageUrl;
    final String biography;
}

class UserMessage {
    UserMessage({
		this.sender,
		this.recipient,
        this.content});
    
    final String sender;
    final String recipient;
    final String content;
}