import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';

class NoisePainter extends CustomPainter {
  final Random _random = Random();
  final double noiseIntensity;

  NoisePainter({this.noiseIntensity = 0.05}); // Adjust intensity

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    for (int i = 0; i < size.width * size.height * noiseIntensity; i++) {
      final x = _random.nextDouble() * size.width;
      final y = _random.nextDouble() * size.height;
      paint.color = Colors.red.withAlpha(
        (_random.nextDouble() * 1 * 255).toInt(),
      ); // Random opacity for noise;
      paint.strokeWidth = 1;
      canvas.drawPoints(PointMode.points, [Offset(x, y)], paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false; // Only repaint if noiseIntensity changes, for example
  }
}

class NoiseContainerWithPainter extends StatelessWidget {
  const NoiseContainerWithPainter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 350,
      color: Colors.white,
      child: CustomPaint(
        painter: NoisePainter(noiseIntensity: 0.5), // Adjust intensity
        child: Center(
          child: Text('Hello', style: TextStyle(color: Colors.white, fontSize: 30)),
        ),
      ),
    );
  }
}
