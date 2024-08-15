import 'package:flutter/material.dart';
import 'dart:math' as math ;

class SpaceBackGround extends StatefulWidget {
  const SpaceBackGround({super.key});

  @override
  State<SpaceBackGround> createState() => _SpaceBackGroundState();
}

class _SpaceBackGroundState extends State<SpaceBackGround> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: CustomPaint(
        painter: SpacePainter(),
      ),
    );
  }
}



class SpacePainter extends CustomPainter {
  SpacePainter() : super();

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;

    // Create a gradient background for the sky
    final gradient = RadialGradient(
      colors: [Colors.black, Colors.blueGrey.shade900],
      center: Alignment.center,
      radius: 1.0,
    );

    final paint = Paint()..shader = gradient.createShader(rect);

    // Fill the background with the gradient
    canvas.drawRect(rect, paint);

    // Draw animated stars
    _drawStars(canvas, size);

    // Draw a celestial sphere or another animated element
    _drawCelestialSphere(canvas, size);
  }

  void _drawStars(Canvas canvas, Size size) {
    final starPaint = Paint()
      ..color = Colors.white.withOpacity(0.8)
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1.0;

    const starCount = 100;
    final random = math.Random();

    for (int i = 0; i < starCount; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      final radius = random.nextDouble() * 2.0;

      canvas.drawCircle(Offset(x, y), radius, starPaint);
    }
  }

  void _drawCelestialSphere(Canvas canvas, Size size) {
    final spherePaint = Paint()
      ..color = Colors.blue.withOpacity(0.5)
      ..style = PaintingStyle.fill;

    const radius = 100.0;
    final center = Offset(size.width / 2, size.height / 2);

    canvas.drawCircle(center, radius, spherePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

