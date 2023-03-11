// ignore_for_file: non_constant_identifier_names, unnecessary_this, curly_braces_in_flow_control_structures

import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';

final supabase = Supabase.instance.client;

class Listing {
  final String title;
  final String desc;
  final DateTime created_at;
  final String owner_id;
  final String id;
  List<Uint8List> images;

  Listing({
    required this.title,
    required this.desc,
    required this.created_at,
    required this.owner_id,
    required this.id,
    this.images = const [],
  });

  Listing.fromJSON(Map<String, dynamic> d)
      : this.title = d["title"],
        this.desc = d["description"],
        this.created_at = DateTime.parse(d["created_at"]),
        this.owner_id = d["owner_id"],
        this.id = d["id"],
        this.images = const [];

  Map<String, dynamic> toJSON(bool includeId) {
    if (includeId)
      return {
        "title": title,
        "description": desc,
        "created_at": created_at.toString(),
        "owner_id": owner_id,
        "id": id,
      };
    else
      return {
        "title": title,
        "description": desc,
        "created_at": created_at.toString(),
        "owner_id": owner_id,
      };
  }

  Future<List<Uint8List>> getImages() async {
    String path = "${this.id}/";
    List<FileObject> listing =
        await supabase.storage.from("images").list(path: path);

    List<Uint8List> images = [];
    for (FileObject f in listing) {
      path = "${this.id}/${f.name}";
      images.add(await supabase.storage.from("images").download(path));
    }
    return images;
  }
}

Future<Listing> getListing(String id) async {
  var data = await supabase
      .from("listings")
      .select<List<Map<String, dynamic>>>()
      .eq("id", id);
  print("Data:");
  print(data);
  var listing = Listing.fromJSON(data[0]);
  listing.images = await listing.getImages();
  return listing;
}

Future<Listing> addListing(
    String title, String desc, String owner, List<XFile> images) async {
  var data = await supabase.from("listings").insert(
      {"title": title, "description": desc, "owner_id": owner}).select();
  Listing l = Listing.fromJSON(data[0]);
  int counter = 0;
  for (XFile img in images) {
    final data = await img.readAsBytes();
    String img_path = "${l.id}/${counter}.png";
    String p = await supabase.storage.from("images").uploadBinary(
        img_path, data,
        fileOptions: FileOptions(contentType: img.mimeType));
    counter++;
  }
  return l;
}

Future<List<Listing>> getAllListings() async {
  var _data =
      await supabase.from("listings").select<List<Map<String, dynamic>>>();
  var data = _data.map((x) => Listing.fromJSON(x)).toList();
  for (Listing l in data) {
    l.images = await l.getImages();
  }
  return data;
}
