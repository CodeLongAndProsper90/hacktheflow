import 'package:supabase_flutter/supabase_flutter.dart';
final supabase = Supabase.instance.client;

class Message {
	final String id;
	final String sender_id;
	final String rec_id;
	final String content;
	final DateTime created_at;
	final bool mine;

	Message({
		required this.id,
		required this.sender_id,
		required this.rec_id,
		required this.content,
		required this.created_at,
		required this.mine,
	});
	
	Message.fromJSON(Map<String, dynamic> d, String myId) :
		id = d["id"],
		sender_id = d["sender_id"],
		rec_id = d["rec_id"],
		content = d["content"],
		created_at = DateTime.parse(d["created_at"]),
		mine = d["sender_id"] == myId;

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

Future<Message?> getSentMessage(String user_id) async {
	var data = await supabase.from("messages").select<List<Map<String, dynamic>>>();
	print(data);
}

Future<List<Message>?> getMessagesTo(String user_id) async {
	var data = await supabase.from("messages").select<List<Map<String, dynamic>>>().eq("rec_id", user_id);
	List<Message> msgs = [];
	for (Map<String, dynamic> json in data)
		msgs.add(Message.fromJSON(json, supabase.auth.currentUser!.id));
	return msgs;
}
