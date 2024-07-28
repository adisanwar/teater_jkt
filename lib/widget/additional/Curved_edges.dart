import 'package:flutter/material.dart';

class TcustomCurvedEdges extends CustomClipper<Path> {
// Suggested code may be subject to a license. Learn more: ~LicenseLog:2110257840.
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);

    final firstCurve = Offset(0, size.height - 20);
    final lastCurved = Offset(30, size.height - 20);
    path.quadraticBezierTo(firstCurve.dx, firstCurve.dy, lastCurved.dx, lastCurved.dy);

    final secondFirstCurve = Offset(0, size.height - 20);
    final SecondLastCurved = Offset(size.width - 30, size.height - 20);
    path.quadraticBezierTo(secondFirstCurve.dx, secondFirstCurve.dy, SecondLastCurved.dx, SecondLastCurved.dy);

    final thirdFirstCurve = Offset(size.width, size.height - 20);
    final thirdLastCurved = Offset(size.width, size.height);
    path.quadraticBezierTo(thirdFirstCurve.dx, thirdFirstCurve.dy, thirdLastCurved.dx, thirdLastCurved.dy);


    
    

    path.lineTo(size.width, 0);
    path.close();

    return path;
  }
  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
  
