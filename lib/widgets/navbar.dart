import 'package:flutter/widgets.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Text('hi'),
        ],
      ),
    );
  }
}
