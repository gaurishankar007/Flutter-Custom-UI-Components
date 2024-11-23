
import 'package:flutter/material.dart';

/// Differentiating left and right sided circle
enum CircleSide {
  left,
  right,
}

/// Extension for getting the path of UI which will be shown based on the circle side
extension on CircleSide {
  Path toPath(Size size) {
    final path = Path();
    late Offset endOffset;
    late bool clockwise;

    switch (this) {
      case CircleSide.left:
        path.moveTo(size.width, 0);
        endOffset = Offset(size.width, size.height);
        clockwise = false;
        break;
      case CircleSide.right:
        endOffset = Offset(0, size.height);
        clockwise = true;
        break;
    }

    path.arcToPoint(
      endOffset,
      radius: Radius.elliptical(size.width / 2, size.height / 2),
      clockwise: clockwise,
    );
    path.close();

    return path;
  }
}

/// Defining clipper for clip path
class HalfCircleClipper extends CustomClipper<Path> {
  final CircleSide side;
  const HalfCircleClipper({required this.side});

  @override
  Path getClip(Size size) => side.toPath(size);

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
