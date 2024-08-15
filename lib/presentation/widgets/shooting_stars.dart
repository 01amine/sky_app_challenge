import 'package:flutter/material.dart';
import 'dart:math' as math;

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
    return SizedBox(
      height: MediaQuery.of(context)
          .size
          .height, // Adjust the height to cover the screen
      width: 100,
      child: CustomPaint(
        painter: ShootingStarPaint(animation: _animation),
      ),
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

  ShootingStarPaint({required this.animation}) : super(repaint: animation);

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

    // Move the tail with the star
    final double endX = startX - tailLength * math.cos(math.pi / 4);
    final double endY = startY - tailLength * math.sin(math.pi / 4);

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
