import 'package:flutter/material.dart';

class CircleImage extends StatelessWidget {
  // 1
  const CircleImage({
    Key? key,
    this.imageProvider,
    this.imageRadius = 20,
  }) : super(key: key);

  // 2
  final double imageRadius;
  final String? imageProvider;

  @override
  Widget build(BuildContext context) {
    // 3
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(20.0), bottomRight: Radius.circular(20.0)),
      // Image border
      child: SizedBox.fromSize(
        size: Size.fromRadius(48), // Image radius
        child: Image.network('$imageProvider', fit: BoxFit.cover),
      ),
    );
  }
}
