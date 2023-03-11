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
  final name = 'John Doe';
	String search = "";

	List<Listing> listings = [];
  @override
  Widget build(BuildContext context) {
		return FutureBuilder(
			future: Future.wait([
				getUser(supabase.auth.currentUser!.id),
				getAllListings()
			]),
			builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
				if (!snapshot.hasData)
					return Center(
						child: SizedBox(
							width: 100,
							height: 100,
							child: CircularProgressIndicator()
						)
					);
				AppUser user = snapshot.data![0];
				listings = snapshot.data![1];
				print(listings);
				return Padding(
					padding: const EdgeInsets.all(30.0),
					child: Column(
						mainAxisSize: MainAxisSize.min,
						children: [
							// Wyzno and profile picture
							Row(
								mainAxisAlignment: MainAxisAlignment.spaceBetween,
								children: [
									const LogoText('Wyzno'),
									ProfilePicture(name: user.name, radius: 40.0),
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
								child: ListView(
										children: listings.where((list) => (list.desc+list.title).contains(search))
										.map((list) => ListingCard(id: list.id)).toList(),
								),
							)
						],
					),
				);
			}
		);
  }
}
