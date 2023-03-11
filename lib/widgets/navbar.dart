import 'package:flutter/widgets.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: SizedBox(
        height: 80.0,
        width: double.infinity,
        child: Stack(
          children: [
            Text('hi'),
          ],
        ),
      ),
    );
  }
}
