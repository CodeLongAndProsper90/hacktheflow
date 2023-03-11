import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:hacktheflow/backend/listing.dart';
final supabase = Supabase.instance.client;

class ListingCard extends StatefulWidget {
	final String id;
	ListingCard({Key? key, required this.id});
	@override
	State<ListingCard> createState() => ListingCardState();
}

class ListingCardState extends State<ListingCard> {
	
	@override
	Widget build(BuildContext context) {
		return FutureBuilder(
			future: getListing(widget.id),
			builder: (BuildContext context, AsyncSnapshot<Listing> snapshot) {
				if (!snapshot.hasData)
					return CircularProgressIndicator();
				print(snapshot.data);
				Listing l = snapshot.data!;
				return 
					Image.memory(l.images[0]);
			}	
		);
	}
}
