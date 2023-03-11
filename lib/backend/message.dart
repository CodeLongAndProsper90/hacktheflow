class Message {
	final String id;
	final String sender_id;
	final String content;
	final DateTime created_at;
	final bool mine;

	Message({
		required this.id,
		required this.sender_id,
		required this.content,
		required this.created_at,
		required this.mine,
	});
	
	Message.fromJSON(Map<String, dynamic> d, String myId) :
		id = d["id"],
		sender_id = d["profile_id"],
		content = d["content"],
		created_at = DateTime.parse(d["created_at"]),
		mine = sender_id == myId;

}
