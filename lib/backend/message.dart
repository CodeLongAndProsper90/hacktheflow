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
		"rec_id":	to,
		"content": contents,
	});
}

Future<List<Message>> getAllMessages() async {
	print("Supabasing messages");
	var data = await supabase.from("messages").select<List<Map<String, dynamic>>>();
	print("Messages are: $data");
	List<Message> msgs = [];
	for (Map<String, dynamic> json in data)
		msgs.add(Message.fromJSON(json, supabase.auth.currentUser!.id));
	return msgs;
}

Future<List<Message>> getMessagesTo(String user_id, String my_id) async {
	List<Message> data = await getAllMessages();
	List<Message> msgs = [];
	for (Message m in data)
		if (m.sender_id == my_id || m.sender_id == user_id || m.rec_id == user_id || m.rec_id == my_id)
		msgs.add(m);
	return msgs;
}
