import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hacktheflow/pages/home/discover.dart';
import 'package:hacktheflow/widgets/navbar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hacktheflow/backend/user.dart';
import 'package:hacktheflow/main.dart';
import 'package:hacktheflow/widgets/message_bubble.dart';
import 'package:hacktheflow/backend/message.dart';
import 'package:hacktheflow/backend/listing.dart';

import 'package:hacktheflow/pages/home/profile.dart';

import 'package:hacktheflow/pages/home/profile.dart';

import 'home/messages.dart';

final supabase = Supabase.instance.client;

class HomePage extends StatefulWidget {
  static Route<void> route() {
    return MaterialPageRoute(builder: (context) => const HomePage());
  }

  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: [
          // HomeDiscoverPage(),
          Mainpage(),
          HomeMessagesPage(to_id: "b7891604-2cff-48bb-ad00-bc9097af1086"),
          HomeProfilePage(),
        ][_pageIndex],
      ),
      bottomNavigationBar: Navbar(
        onChange: (index) {
          setState(() {
            _pageIndex = index;
          });
        },
      ),
    );
  }
}

class Mainpage extends StatefulWidget {
  const Mainpage({Key? key}) : super(key: key);

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  final ImagePicker _p = ImagePicker();
  List<XFile> images = [];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text("Main page"),
          TextButton(
              child: Text("Take photo"),
              onPressed: () async {
                XFile? img = await _p.pickImage(source: ImageSource.camera);
                if (img == null) return;
                XFile image = img!;
                images.add(image);
              }),
          TextButton(
              child: Text("Add Listing"),
              onPressed: () async {
                await addListing("Test", "This is a test",
                    "2fa01d64-8b12-4bce-9981-b8521ae23482", images);
              }),
          TextButton(
            child: Text("Sign out"),
            onPressed: () async {
              await supabase.auth.signOut();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => StartPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
