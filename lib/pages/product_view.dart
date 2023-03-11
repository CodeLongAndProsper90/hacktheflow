import 'package:flutter/material.dart';
import 'package:hacktheflow/backend/listing.dart';
import 'package:hacktheflow/colors.dart';
import 'package:hacktheflow/widgets/profile_picture.dart';
import 'package:hacktheflow/widgets/styled_text.dart';

class ProductViewPage extends StatefulWidget {
  final String id;
  final Listing listing;
  const ProductViewPage({super.key, required this.id, required this.listing});

  @override
  State<ProductViewPage> createState() => _ProductViewPageState();
}

class _ProductViewPageState extends State<ProductViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: widget.listing.id,
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(32.0),
                ),
              ),
              clipBehavior: Clip.antiAlias,
              child: Image.memory(
                widget.listing.images[0],
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height / 2,
                width: double.infinity,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 25.0,
              horizontal: 30.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeaderText(text: widget.listing.title),
                const SizedBox(height: 10.0),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.0),
                    color: colorForeground,
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 20.0,
                  ),
                  child: Text(
                    '\$0.00',
                    style: const TextStyle(
                      color: colorBackground,
                    ),
                  ),
                ),
                const SizedBox(height: 32.0),
                Row(
                  children: [
                    ProfilePicture(name: widget.listing.owner_id),
                    const SizedBox(width: 8.0),
                    LargeText('George Orwell'),
                  ],
                ),
                const SizedBox(height: 10.0),
                SubheaderText(widget.listing.desc),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
          left: 30.0,
          right: 30.0,
          bottom: 30.0,
        ),
        child: SizedBox(
          height: 80.0,
          child: TextButton(
            onPressed: () {
              // Open chat
            },
            style: ButtonStyle(
              shape: MaterialStateProperty.all(
                const StadiumBorder(),
              ),
              backgroundColor: MaterialStateProperty.all(
                colorAccent,
              ),
            ),
            child: const BodyText(
              'Contact the seller',
              style: TextStyle(color: colorAccentAlt),
            ),
          ),
        ),
      ),
    );
  }
}
