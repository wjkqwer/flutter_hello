import 'package:flutter/cupertino.dart';

class MyClipper2 extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return Rect.fromLTRB(30, 30, size.width - 30, size.height - 3);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) {
    return false;
  }
}
