import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:sky_app/zerefs/direction_zeref.dart';
import 'package:sky_app/zerefs/zeref_builder.dart';

class ShootingStar extends StatefulWidget {
  const ShootingStar({super.key});

  @override
  State<ShootingStar> createState() => _ShootingStarState();
}

class _ShootingStarState extends State<ShootingStar>
    with SingleTickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);

    _controller.repeat(reverse: false);
  }

  @override
  Widget build(BuildContext context) {
    return ZerefBuilder<DirectionZeref>(
      builder: (context, directionZeref) {
        return SizedBox(
          height: MediaQuery.of(context).size.height,
          width: 100,
          child: CustomPaint(
            painter: ShootingStarPaint(
              direction: directionZeref.value,
              animation: _animation,
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    if (_controller.isAnimating) {
      _controller.stop();
    }
    _controller.dispose();
    super.dispose();
  }
}

class ShootingStarPaint extends CustomPainter {
  final Animation<double> animation;
  final Direction direction;

  ShootingStarPaint({required this.direction, required this.animation})
      : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final double bx = size.width / 2;
    final double by =
        size.height * animation.value; // Move star from top to bottom

    final Paint starPaint = Paint()
      ..strokeCap = StrokeCap.round
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final List<Map<String, double>> points = calcStarPoints(bx, by, 5, 10, 20);

    final Path path = Path()..moveTo(points[0]['x']!, points[0]['y']!);

    for (int i = 1; i < points.length; i++) {
      path.lineTo(points[i]['x']!, points[i]['y']!);
    }

    path.close();

    canvas.drawPath(path, starPaint);

    _drawTail(canvas, bx, by);
  }

  void _drawTail(Canvas canvas, double startX, double startY) {
    final Paint tailPaint = Paint()
      ..color = Colors.white.withOpacity(0.6)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1.0;

    final double tailLength = 50.0 * animation.value;

    // Adjust tail direction based on the shooting direction
    double endX, endY;
    switch (direction) {
      case Direction.left:
        endX = startX - tailLength;
        endY = startY;
        break;
      case Direction.right:
        endX = startX + tailLength;
        endY = startY;
        break;
      case Direction.up:
        endX = startX;
        endY = startY - tailLength;
        break;
      case Direction.down:
        endX = startX;
        endY = startY + tailLength;
        break;
    }

    final Offset tailStart = Offset(startX, startY);
    final Offset tailEnd = Offset(endX, endY);

    canvas.drawLine(tailStart, tailEnd, tailPaint);
  }

  List<Map<String, double>> calcStarPoints(double centerX, double centerY,
      int innerCirclePoints, double innerRadius, double outerRadius) {
    final double angle = (math.pi) / innerCirclePoints;
    final int totalPoints = innerCirclePoints * 2;
    final List<Map<String, double>> points = [];

    for (int i = 0; i < totalPoints; i++) {
      bool isEvenIndex = i % 2 == 0;
      double r = isEvenIndex ? outerRadius : innerRadius;

      double currY = centerY + math.cos(i * angle - 0.6) * r;
      double currX = centerX + math.sin(i * angle - 0.6) * r;
      points.add({'x': currX, 'y': currY});
    }
    return points;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
