import 'package:flutter/material.dart';
import 'package:hacktheflow/colors.dart';
import 'package:hacktheflow/widgets/styled_text.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  final _pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: SizedBox(
        height: 160.0,
        width: double.infinity,
        child: Stack(
          children: [
            Container(
              color: Colors.white,
            ),
            SizedBox(
              height: 80,
              width: double.infinity,
              child: Row(
                children: [
                  Column(
                    children: [
                      Icon(
                        Icons.category_outlined,
                        color:
                            (_pageIndex == 0) ? colorBackground : colorAccent,
                      ),
                      if (_pageIndex == 0)
                        const LabelText(
                          'Discover',
                          style: TextStyle(color: colorBackground),
                        ),
                    ],
                  ),
                  Column(
                    children: [
                      Icon(
                        Icons.chat_outlined,
                        color:
                            (_pageIndex == 0) ? colorBackground : colorAccent,
                      ),
                      if (_pageIndex == 0)
                        const LabelText(
                          'Messages',
                          style: TextStyle(color: colorBackground),
                        ),
                    ],
                  ),
                  Column(
                    children: [
                      Icon(
                        Icons.person_outlined,
                        color:
                            (_pageIndex == 0) ? colorBackground : colorAccent,
                      ),
                      if (_pageIndex == 0)
                        const LabelText(
                          'Profile',
                          style: TextStyle(color: colorBackground),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
