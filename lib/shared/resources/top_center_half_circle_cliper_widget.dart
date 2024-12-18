import 'package:flutter/material.dart';

class TopCenterHalfCircleClipper extends CustomClipper<Path> {
  final double radius;

  TopCenterHalfCircleClipper({required this.radius});

  @override
  Path getClip(Size size) {
    Path path = Path();

    // Start from top-left
    path.lineTo(0, 0);

    // Move to top-center
    path.lineTo(size.width / 2 - radius, 0);

    // Draw a half-circle from top-center
    path.arcToPoint(
      Offset(size.width / 2 + radius, 0),
      radius: Radius.circular(radius),
      clockwise: false,
    );

    // Move to the top-right
    path.lineTo(size.width, 0);

    // Draw the remaining sides of the rectangle
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}