import 'dart:math';

import 'package:flutter/material.dart';

// class Clipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     final path = Path();
//     path.lineTo(0.0, size.height);
//     var firstStart = Offset(size.width / 5, size.height);
//     var firstEnd = Offset(size.width / 2.25, size.height - 50.0);

//     path.quadraticBezierTo(
//       firstStart.dx,
//       firstStart.dy,
//       firstEnd.dx,
//       firstEnd.dy,
//     );
//     var secondStart = Offset(size.width - (size.width / 3.23), size.height - 105);
//     var secondEnd = Offset(size.width, size.height - 10.0);

//     path
//       ..quadraticBezierTo(
//         secondStart.dx,
//         secondStart.dy,
//         secondEnd.dx,
//         secondEnd.dy,
//       )
//       ..lineTo(size.width, 0.0)
//       ..close();
//     return path;
//   }

//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) {
//     return true;
//   }
// }

// class Clipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     final path = Path();
//     path.lineTo(0.0, size.height * 0.8);

//     var firstControlPoint = Offset(size.width * 0.2, size.height);
//     var firstEndPoint = Offset(size.width * 0.5, size.height * 0.7);
//     path.quadraticBezierTo(
//       firstControlPoint.dx,
//       firstControlPoint.dy,
//       firstEndPoint.dx,
//       firstEndPoint.dy,
//     );

//     var secondControlPoint = Offset(size.width * 0.8, size.height * 0.5);
//     var secondEndPoint = Offset(size.width, size.height * 0.8);
//     path.quadraticBezierTo(
//       secondControlPoint.dx,
//       secondControlPoint.dy,
//       secondEndPoint.dx,
//       secondEndPoint.dy,
//     );

//     path.lineTo(size.width, 0.0);
//     path.close();

//     return path;
//   }

//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) {
//     return false; // Return true if clipper needs to be reconfigured, otherwise, return false.
//   }
// }

// class SpikeClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     final path = Path();
//     path.lineTo(0.0, size.height * 0.7);

//     for (var i = 0; i < size.width; i += 10) {
//       final x = i.toDouble();
//       final y1 = size.height * 0.7 + 20 * sin((i / 10) * pi);
//       final y2 = size.height * 0.7 + 20 * sin(((i + 5) / 10) * pi);
//       path.quadraticBezierTo(x, y1, x + 5, y2);
//     }

//     path.lineTo(size.width, size.height * 0.7);
//     path.lineTo(size.width, 0.0);
//     path.close();

//     return path;
//   }

//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) {
//     return true;
//   }
// }

// // class SpikeClipper extends CustomClipper<Path> {
// //   @override
// //   Path getClip(Size size) {
// //     final path = Path();
// //     path.moveTo(0.0, size.height);
// //     double spikeWidth = size.width / 5;

// //     for (int i = 0; i < 5; i++) {
// //       path.lineTo((i + 0.5) * spikeWidth, size.height);
// //       path.lineTo((i + 1) * spikeWidth, size.height - size.height / 4);
// //     }

// //     path.lineTo(size.width, size.height);
// //     path.lineTo(size.width, 0.0);
// //     path.lineTo(0.0, 0.0);
// //     path.close();

// //     return path;
// //   }

// //   @override
// //   bool shouldReclip(CustomClipper<Path> oldClipper) {
// //     return false;
// //   }
// // }

// class Clipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     final path = Path();
//     path.lineTo(0.0, size.height);

//     path.quadraticBezierTo(
//       size.width / 4,
//       size.height,
//       size.width / 2,
//       size.height - 60.0,
//     );

//     path.cubicTo(
//       size.width * 3 / 4,
//       size.height - 120.0,
//       size.width,
//       size.height - 60.0,
//       size.width,
//       size.height - 120.0,
//     );

//     path.lineTo(size.width, 0.0);
//     path.close();

//     return path;
//   }

//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) {
//     return true;
//   }
// }

class Clipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.lineTo(0.0, size.height * 0.8);

    final double waveAmplitude = 35.0; // Increase the wave amplitude for a taller wave
    final double waveFrequency = 2.0 * pi / size.width;

    for (double i = 0.0; i <= size.width; i += 10.0) {
      final double x = i;
      final double y = sin(i * waveFrequency) * waveAmplitude + size.height * 0.9;
      path.lineTo(x, y);
    }

    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
