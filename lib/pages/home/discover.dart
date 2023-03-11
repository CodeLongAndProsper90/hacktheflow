import 'package:flutter/cupertino.dart';
import 'package:hacktheflow/widgets/listing.dart';

class HomeDiscoverPage extends StatefulWidget {
  const HomeDiscoverPage({super.key});

  @override
  State<HomeDiscoverPage> createState() => _HomeDiscoverPageState();
}

class _HomeDiscoverPageState extends State<HomeDiscoverPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
							ListingCard(id: "2fa01d64-8b12-4bce-9981-b8521ae23482")
            ],
          ),
        ),
      ),
    );
  }
}
