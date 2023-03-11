import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';
final supabase = Supabase.instance.client;

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
	Future<Uint8List> getAvatar() async {
		return await supabase.storage.from("avatar").download("${this.id}/avatar.png");
	}
	Future<void> setAvatar(XFile img) async {
		final data = await img.readAsBytes();
		String path = "${this.id}/avatar.png";
		await supabase.storage.from("avatar")
				.uploadBinary(
					path,
					data,
					fileOptions: FileOptions(
						contentType: img.mimeType
					)
				);
	}
	
}
