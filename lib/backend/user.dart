import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class AppUser {
  String id;
  int zip;
	String name;

  AppUser({required this.id, required this.zip, required this.name});

  AppUser.fromJSON(Map<String, dynamic> d)
      : id = d["id"],
				name = d["name"],
        zip = d["zip"];

  Map<String, dynamic> toJSON() {
    return {"id": id, "zip": zip, "name": name};
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
	print("Calling supabase");
	var data = await supabase.from("profiles").select<List<Map<String, dynamic>>>().eq("id", id);
	print("Supabase called");
	print(data);
	return AppUser(
		id: data[0]["id"],
		zip: int.parse(data[0]["zip"]),
		name: data[0]["name"]);
}

Future<List<AppUser>> getAllUsers() async {
	print("Supabasing users");
	var data = await supabase.from("profiles").select<List<Map<String, dynamic>>>();
	print("Users are: $data");
	return data.map((d) => AppUser(id: d["id"], zip: int.parse(d["zip"]), name: d["name"])).toList();
}
