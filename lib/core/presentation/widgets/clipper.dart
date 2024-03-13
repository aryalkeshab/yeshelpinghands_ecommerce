import 'dart:math';
import 'package:flutter/material.dart';

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
