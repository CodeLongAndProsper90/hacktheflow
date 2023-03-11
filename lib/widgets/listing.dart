import 'package:flutter/material.dart';
import 'package:hacktheflow/colors.dart';
import 'package:hacktheflow/pages/product_view.dart';
import 'package:hacktheflow/widgets/styled_text.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:hacktheflow/backend/listing.dart';

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
      future: getListing(widget.id),
      builder: (BuildContext context, AsyncSnapshot<Listing> snapshot) {
        if (!snapshot.hasData) return const CircularProgressIndicator();
        print(snapshot.data);

        Listing l = snapshot.data!;
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (BuildContext context) => ProductViewPage(
                  id: l.id,
                  listing: l,
                ),
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
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    SizedBox(
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
                    Container(
                      height: 16,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: colorBackground,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(16.0),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100.0),
                        color: colorForeground,
                      ),
                      margin: const EdgeInsets.only(left: 16.0),
                      padding: const EdgeInsets.symmetric(
                        vertical: 6.0,
                        horizontal: 12.0,
                      ),
                      child: Text(
                        '\$${l.price}',
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
                Padding(
                  padding: const EdgeInsets.only(
                    left: 16.0,
                    bottom: 16.0,
                    top: 8.0,
                  ),
                  child: BodyText(l.desc),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
