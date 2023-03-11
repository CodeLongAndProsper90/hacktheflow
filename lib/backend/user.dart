class User {
	String id;
	String username;
	int zip;

	User({
		required this.id,
		required this.username,
		required this.zip
	});

	User.fromJSON(Map<String, dynamic> d) :
		id = d["id"],
		username = d["username"],
		zip = d["zip"];
	
	Map<String, dynamic> toJSON() {
		return {
			"id" : id,
			"username" : username,
			"zip" : zip
		};
	}
}
