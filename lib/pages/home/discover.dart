import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hacktheflow/colors.dart';
import 'package:hacktheflow/pages/add_listing.dart';
import 'package:hacktheflow/widgets/listing.dart';
import 'package:hacktheflow/widgets/profile_picture.dart';
import 'package:hacktheflow/widgets/styled_text.dart';

class HomeDiscoverPage extends StatefulWidget {
  const HomeDiscoverPage({super.key});

  @override
  State<HomeDiscoverPage> createState() => _HomeDiscoverPageState();
}

class _HomeDiscoverPageState extends State<HomeDiscoverPage> {
  final searchCon = TextEditingController();
  final name = 'John Doe';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        children: [
          // Wynzo and profile picture
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const LogoText('Wynzo'),
              // ProfilePicture(name: name, radius: 40.0),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const AddListingPage(),
                    ),
                  );
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    const StadiumBorder(),
                  ),
                  backgroundColor: MaterialStateProperty.all(
                    colorForeground,
                  ),
                  padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(
                      vertical: 12.0,
                      horizontal: 24.0,
                    ),
                  ),
                ),
                child: const BodyText(
                  'Add a listing',
                  style: TextStyle(color: colorBackground),
                ),
              ),
            ],
          ),

          // Search bar
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: TextField(
              onChanged: (value) {
                // TODO: filter
              },
              controller: searchCon,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                labelText: 'What do you seek?',
                border: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: colorHint,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
          ),

          // The listings... soon:tm:
          ListingCard(id: "2fa01d64-8b12-4bce-9981-b8521ae23482"),
        ],
      ),
    );
  }
}
