import 'package:flutter/material.dart';
import 'package:hacktheflow/colors.dart';
import 'package:hacktheflow/widgets/styled_text.dart';

class HomeProfilePage extends StatefulWidget {
  const HomeProfilePage({super.key});

  @override
  State<HomeProfilePage> createState() => _HomeProfilePageState();
}

class _HomeProfilePageState extends State<HomeProfilePage> {
  final name = "John Doe";
  final profilePicture = "idk_what_to_put_here";
  final zipCode = 12345;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 96.0,
            child: Text(
              name.split(' ').map((e) => e[0].toUpperCase()).join(''),
              style: const TextStyle(
                fontSize: 48.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 40.0,
            ),
            decoration: BoxDecoration(
              color: colorForeground,
              borderRadius: BorderRadius.circular(100.0),
            ),
            child: HeaderText(
              text: name,
              style: const TextStyle(color: colorBackground),
            ),
          ),
          const SizedBox(height: 10.0),
          SubheaderText('api.toCity($zipCode).toString();'),
        ],
      ),
    );
  }
}
