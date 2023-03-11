import 'package:flutter/material.dart';

class ProfilePicture extends StatelessWidget {
  final String name;
  final String? pictureId;
  final double? radius;

  const ProfilePicture({
    super.key,
    required this.name,
    this.pictureId,
    this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      child: pictureId == null
          ? Text(
              name.split(' ').map((e) => e[0].toUpperCase()).join(''),
            )
          : null,
    );
  }
}
