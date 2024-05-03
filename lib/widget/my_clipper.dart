import 'package:flutter/cupertino.dart';

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..moveTo(30, 30)
      ..lineTo(size.width - 30, 30)
      ..lineTo(size.width - 30, size.height - 30)
      ..lineTo(30, size.height - 30);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
