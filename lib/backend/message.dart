import 'package:supabase_flutter/supabase_flutter.dart';
final supabase = Supabase.instance.client;

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
		mine = d["profile_id"] == myId;

	Map<String, dynamic> toJSON() {
		return {
			"id": id,
			"profile_id": sender_id,
			"content": content,
			"created_at": created_at,
		};
	}
	
}
Future<void> send({required String to, required String contents}) async {
	await supabase.from("messages").insert({
		"profile_id":	to,
		"content": contents,
	});
}
