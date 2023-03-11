import 'package:flutter/material.dart';
import 'package:hacktheflow/colors.dart';
import 'package:hacktheflow/widgets/styled_text.dart';

class Navbar extends StatefulWidget {
  final Null Function(int index) onChange;
  final Widget child;

  const Navbar({super.key, required this.onChange, required this.child});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int _pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // SingleChildScrollView(child: widget.child),
        widget.child,
        Positioned(
          bottom: 0,
          child: _innerNavbar(),
        ),
      ],
    );
  }

  SizedBox _innerNavbar() {
    return SizedBox(
      height: 200.0,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          IgnorePointer(
            ignoring: true,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white,
                    Colors.white.withOpacity(0.0),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Container(
              height: 80,
              width: double.infinity,
              decoration: BoxDecoration(
                color: colorForeground,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    navbarItem(0, 'Discover', Icons.category_outlined),
                    navbarItem(1, 'Messages', Icons.chat_outlined),
                    navbarItem(2, 'Profile', Icons.person_outlined),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget navbarItem(int targetIndex, String label, IconData icon) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _pageIndex = targetIndex;
            widget.onChange(targetIndex);
          });
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color:
                  (_pageIndex == targetIndex) ? colorAccent : colorBackground,
            ),
            TweenAnimationBuilder(
              tween: Tween<double>(
                begin: 0,
                end: _pageIndex == targetIndex ? 1.0 : 0.0,
              ),
              duration: const Duration(milliseconds: 100),
              curve: Curves.bounceInOut,
              builder: (context, double scale, child) {
                return Transform.scale(
                  scale: scale,
                  child: child,
                );
              },
              child: LabelText(
                label,
                style: const TextStyle(color: colorBackground),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
