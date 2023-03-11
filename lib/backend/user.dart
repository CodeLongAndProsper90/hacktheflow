import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class AppUser {
  String id;
  String username;
  int zip;
	String name;

  AppUser({required this.id, required this.username, required this.zip, required this.name});

  AppUser.fromJSON(Map<String, dynamic> d)
      : id = d["id"],
        username = d["username"],
				name = d["name"],
        zip = d["zip"];

  Map<String, dynamic> toJSON() {
    return {"id": id, "username": username, "zip": zip, "name": name};
  }

  Future<Uint8List> getAvatar() async {
    return await supabase.storage.from("avatar").download("$id/avatar.png");
  }

  Future<void> setAvatar(XFile img) async {
    final data = await img.readAsBytes();
    String path = "$id/avatar.png";
    await supabase.storage.from("avatar").uploadBinary(
          path,
          data,
          fileOptions: FileOptions(contentType: img.mimeType),
        );
  }
}

Future<AppUser> getUser(String id) async {
	var data = await supabase.from("profiles").select<List<Map<String, dynamic>>>().eq("id", id);
	return AppUser.fromJSON(data[0]);
}

Future<List<AppUser>> getAllUsers() async {
	var data = await supabase.from("profiles").select<List<Map<String, dynamic>>>();
	return data.map((d) => AppUser.fromJSON(d)).toList();
}
