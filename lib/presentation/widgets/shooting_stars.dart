// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'dart:math'as math;
class ShootingStare extends StatefulWidget {
  const ShootingStare({Key? key}) : super(key: key);

  @override
  State<ShootingStare> createState() => _ShootingStareState();
}

class _ShootingStareState extends State<ShootingStare>
    with SingleTickerProviderStateMixin {
  late Animation _animation;
  late AnimationController _controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: 50,
      child: CustomPaint(
        painter: ShootingStarPaint(
          animation: const SizedBox() as Animation,
        ),
      ),
    );
  }
}

class ShootingStarPaint extends CustomPainter {
  final Animation animation;

  ShootingStarPaint({required this.animation}) : super(repaint: animation);
  @override
  void paint(Canvas canvas, Size size) {
    final bx = size.width / 2;
    final by = size.height;

    final starPaint = Paint()
      ..strokeCap = StrokeCap.round
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    final points = calcStarPoints(bx, by, 5, 10, 20);

    final path = Path()
      ..moveTo(points[0]['x'] as double, points[0]['y'] as double);

    for (int i = 1; i < points.length; i++) {
      path.lineTo(points[i]['x'] as double, points[i]['y'] as double);
    }

    path.close();

    // Draw the star
    canvas.drawPath(path, starPaint);

    // Draw the tail of the shooting star
    _drawTail(canvas, size);
  }

  void _drawTail(Canvas canvas, Size size) {
    final tailPaint = Paint()
      ..color = Colors.white.withOpacity(0.6)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1.0;

    final tailLength =
        50.0 * animation.value; // Tail length changes with animation
    final tailStart = Offset(size.width / 2, size.height / 2);
    final tailEnd = Offset(
      tailStart.dx + tailLength * math.cos(animation.value * 2 * math.pi),
      tailStart.dy + tailLength * math.sin(animation.value * 2 * math.pi),
    );

    canvas.drawLine(tailStart, tailEnd, tailPaint);

    // draw the star with 5 points and the animation in the tail ,
  }

  // use this function to calculate the points of the star

  List<Map> calcStarPoints(
      centerX, centerY, innerCirclePoints, innerRadius, outerRadius) {
    final angle = ((math.pi) / innerCirclePoints);
    var angleOffsetToCenterStar = 0;

    var totalPoints = innerCirclePoints * 2;
    List<Map> points = [];
    for (int i = 0; i < totalPoints; i++) {
      bool isEvenIndex = i % 2 == 0;
      var r = isEvenIndex ? outerRadius : innerRadius;

      var currY =
          centerY + math.cos(i * angle + angleOffsetToCenterStar - 0.6) * r;
      var currX =
          centerX + math.sin(i * angle + angleOffsetToCenterStar - 0.6) * r;
      points.add({'x': currX, 'y': currY});
    }
    return points;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
