class Group {
	Group({
		this.title,
		this.geolocation,
		this.description,
		this.intents,
		this.createdAt});

	final String title;
	final String geolocation;
	final String description;
	final List intents;
	final DateTime createdAt;
}