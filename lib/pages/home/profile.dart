import 'package:flutter/material.dart';
import 'package:hacktheflow/backend/zip.dart';
import 'package:hacktheflow/colors.dart';
import 'package:hacktheflow/widgets/styled_text.dart';
import 'package:hacktheflow/backend/zip.dart';
import 'package:hacktheflow/backend/user.dart';
import 'package:hacktheflow/main.dart';
import 'package:hacktheflow/pages/add_listing.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class HomeProfilePage extends StatefulWidget {
  const HomeProfilePage({super.key});

  @override
  State<HomeProfilePage> createState() => _HomeProfilePageState();
}

class _HomeProfilePageState extends State<HomeProfilePage> {
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
        if (snapshot.hasError) print("ERROR IN PROFILE PAGE!!!");

        AppUser user = snapshot.data![0];
        String cityName = snapshot.data![1];
        final name = user.name;
        final zipCode = user.zip;
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 86.0,
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
              HeaderText(text: name),
              const SizedBox(height: 10.0),
              SubheaderText(cityName),
              const SizedBox(height: 15.0),
              SizedBox(height: 64.0),
              TextButton(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 20.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                  child: Text(
                    "Sign out",
                    style: const TextStyle(color: colorBackground),
                  ),
                ),
                onPressed: () async {
                  await supabase.auth.signOut();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => StartWidget(title: "Wynzo")));
                },
              ),
              SizedBox(height: 64.0),
              // TextButton(
              //     child: Text("Add a listing"),
              //     onPressed: () {
              //       Navigator.of(context).push(MaterialPageRoute(
              //           builder: (context) => AddListingPage()));
              //     })
            ],
          ),
        );
      },
    );
  }
}
