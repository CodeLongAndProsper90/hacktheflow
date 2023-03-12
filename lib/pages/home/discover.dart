import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hacktheflow/colors.dart';
import 'package:hacktheflow/pages/add_listing.dart';
import 'package:hacktheflow/widgets/listing.dart';
import 'package:hacktheflow/widgets/profile_picture.dart';
import 'package:hacktheflow/widgets/styled_text.dart';
import 'package:hacktheflow/backend/listing.dart';
import 'package:hacktheflow/backend/user.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class HomeDiscoverPage extends StatefulWidget {
  const HomeDiscoverPage({super.key});

  @override
  State<HomeDiscoverPage> createState() => _HomeDiscoverPageState();
}

class _HomeDiscoverPageState extends State<HomeDiscoverPage> {
  final searchCon = TextEditingController();
  String search = "";

  List<Listing> listings = [];
  List<Widget> search_for() {
    List<Listing> lists = listings
        .where((list) => (list.desc + list.title).contains(search))
        .toList();
    List<Widget> output = [];
    for (Listing l in lists) {
      output.add(ListingCard(id: l.id));
      output.add(SizedBox(height: 20));
    }
    output.add(SizedBox(height: 75));
    return output;
  }

	Future<List<dynamic>> getData() async {
		print("I got called");
		String id = supabase.auth.currentUser!.id;
		print("Id is $id");
		AppUser user = await getUser(id);
		print("Got the user!");
		var listing = await getAllListings();
		return [user, listing];
	}
  @override
  Widget build(BuildContext context) {
		print("waiting on discover");
    return FutureBuilder(
      future: getData(),
			builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (!snapshot.hasData) {
					print("No data");
					print(snapshot.data);
          return const Center(child: CircularProgressIndicator());
        }
				if (snapshot.hasError)
					print("ERROR IN LISTINGPAGE!!!");
        AppUser user = snapshot.data![0];
        listings = snapshot.data![1];
        print(listings);
        return Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Wynzo and profile picture
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const LogoText('Wynzo'),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const AddListingPage(),
                          ),
                        );
                      });
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
                      'Add Listing',
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
                    setState(() {
                      search = value;
                    });
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

              Expanded(
                child: ListView(children: search_for()),
              ),
            ],
          ),
        );
      },
    );
  }
}
