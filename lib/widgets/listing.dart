import 'package:flutter/material.dart';
import 'package:hacktheflow/colors.dart';
import 'package:hacktheflow/pages/product_view.dart';
import 'package:hacktheflow/widgets/styled_text.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:hacktheflow/backend/listing.dart';
import 'package:hacktheflow/backend/user.dart';

final supabase = Supabase.instance.client;

class ListingCard extends StatefulWidget {
  final String id;
  const ListingCard({super.key, required this.id});

  @override
  State<ListingCard> createState() => ListingCardState();
}

class ListingCardState extends State<ListingCard> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait(
          [getUser(supabase.auth.currentUser!.id), getListing(widget.id)]),
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        print(snapshot.data);
        AppUser user = snapshot.data![0];
        Listing l = snapshot.data![1];
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (BuildContext context) =>
                    ProductViewPage(id: l.id, listing: l, name: user.name),
              ),
            );
          },
          child: Card(
            clipBehavior: Clip.antiAlias,
            elevation: 4.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  clipBehavior: Clip.antiAlias,
                  height: 250,
                  width: double.infinity,
                  child: Hero(
                    tag: l.id,
                    child: Image.memory(
                      l.images[0],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100.0),
                              color: colorForeground,
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: 6.0,
                              horizontal: 12.0,
                            ),
                            child: Text(
                              '\$${l.price.toStringAsFixed(2)}',
                              style: const TextStyle(
                                color: colorBackground,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          LargeText(l.title),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      BodyText(l.desc),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
