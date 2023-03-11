import 'package:flutter/material.dart';
import 'package:hacktheflow/pages/home/discover.dart';
import 'dart:typed_data';
import 'package:hacktheflow/widgets/navbar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hacktheflow/backend/user.dart';
import 'package:hacktheflow/main.dart';
import 'package:hacktheflow/widgets/message.dart';
import 'package:hacktheflow/backend/message.dart';
import 'package:hacktheflow/backend/listing.dart';

import 'package:hacktheflow/pages/home/profile.dart';

import 'package:hacktheflow/pages/home/profile.dart';

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
	final ImagePicker _p = ImagePicker();
	List<XFile> images = [];

  int _pageIndex = 0;

  int _pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
<<<<<<< HEAD
      body: Center(
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
							}
						),
            TextButton(
                child: Text("Add Listing"),
                onPressed: () async {
									print(images.runtimeType.toString());
									await addListing("Test", "This is a test", "b7891604-2cff-48bb-ad00-bc9097af1086", images);
								}
						),
            TextButton(
=======
      body: SafeArea(
        child: [
          HomeDiscoverPage(),
          Mainpage(msgCon: msgCon),
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

class Mainpage extends StatelessWidget {
  const Mainpage({
    Key? key,
    required this.msgCon,
  }) : super(key: key);

  final TextEditingController msgCon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text("Main page"),
          TextField(
            decoration: InputDecoration(labelText: "message"),
            controller: msgCon,
          ),
          TextButton(
            child: Text("Send"),
            onPressed: () async {
              await send(
                to: "b7891604-2cff-48bb-ad00-bc9097af1086",
                contents: msgCon.text,
              );
            },
          ),
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
          )
        ],
      ),
    );
  }
}
