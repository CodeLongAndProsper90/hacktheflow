import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hacktheflow/widgets/styled_text.dart';

import '../colors.dart';

class Messagepreveiw extends StatelessWidget {
  Messagepreveiw({super.key});
  final messagepreview =
      "hellothis is a thing from joe of the most recent message";
  final List<Color> colors = [Color(0xFFE1DE93), Color(0xFF8A8A8A)];
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructorse
    return Padding(
      padding: const EdgeInsets.all(double.minPositive), 
      child: Container(
        decoration: const BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: colorForegroundAlt,
                      blurRadius: 10.0,
                      offset: Offset(5, 5),
                      spreadRadius: 2.0,
                    ), //BoxShadow
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(0.0, 0.0),
                      blurRadius: 0.0,
                      spreadRadius: 0.0,
                    ), //BoxShadow
                  ],),
        child: SizedBox(
          width: double.infinity,
          child: Center(
            child: Column(
              children: [Container(
          width: 300,
          height: 300,
          // ignore: prefer_const_constructors
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            // ignore: prefer_const_constructors
            image: DecorationImage(
              // ignore: prefer_const_constructors
              image: AssetImage(
                  '../assets/images/aaaaaaaaaaaa.webp'),
              fit: BoxFit.cover,
            ),
          ),
          // ignore: prefer_const_constructors
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: const Text(
              'MyUserName',
              textAlign: TextAlign.justify,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                    ),
                  ),
                ),
              ),
              const Spacer(),
                const LogoText("jennica's recent message"), 
                SmallText(messagepreview)],
              ),
            )
          ),
        )
      );
  }
}
