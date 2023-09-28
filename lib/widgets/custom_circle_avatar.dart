import 'package:flutter/material.dart';

class CustomCircleAvatar extends StatelessWidget {
  const CustomCircleAvatar({
    super.key,
    required this.width,
    required this.height,
    required this.backgroundImage,
  });
  final double width;
  final double height;
  final ImageProvider backgroundImage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: CircleAvatar(
        backgroundImage: backgroundImage,
      ),
    );
  }
}
