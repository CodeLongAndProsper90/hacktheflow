import 'package:flutter/material.dart';
import 'package:hacktheflow/backend/zip.dart';
import 'package:hacktheflow/colors.dart';
import 'package:hacktheflow/widgets/styled_text.dart';
import 'package:hacktheflow/backend/zip.dart';
import 'package:hacktheflow/backend/user.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class HomeProfilePage extends StatefulWidget {
  const HomeProfilePage({super.key});

  @override
  State<HomeProfilePage> createState() => _HomeProfilePageState();
}

class _HomeProfilePageState extends State<HomeProfilePage> {
  final name = "John Doe";
  final profilePicture = "idk_what_to_put_here";
  final zipCode = 12345;

  Future<List<dynamic>> getData() async {
    var user = await getUser(supabase.auth.currentUser!.id);
    var zipStr = await getNameFromZip(user.zip);
    return [user, zipStr];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getData(),
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        AppUser user = snapshot.data![0];
        String cityName = snapshot.data![1];
        final name = user.name;
        final zipCode = user.zip;
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 96.0,
                child: Text(
                  name.split(' ').map((e) {
                    if (e == '') return '';
                    return e[0].toUpperCase();
                  }).join(''),
                  style: const TextStyle(
                    fontSize: 48.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 40.0,
                ),
                decoration: BoxDecoration(
                  color: colorForeground,
                  borderRadius: BorderRadius.circular(100.0),
                ),
                child: HeaderText(
                  text: name,
                  style: const TextStyle(color: colorBackground),
                ),
              ),
              const SizedBox(height: 10.0),
              SubheaderText(cityName),
            ],
          ),
        );
      },
    );
  }
}
