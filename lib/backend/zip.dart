import 'package:http/http.dart' as http;
import 'dart:convert';

Future<String> getNameFromZip(int zip) async {
	var uri = Uri.https("ziptasticapi.com", zip.toString());
	var resp = await http.get(uri);
	Map<String, dynamic> data = json.decode(resp.body);
	var city = data["city"].toLowerCase();
	var state = data["state"];
	return city + ", " + state;
}
