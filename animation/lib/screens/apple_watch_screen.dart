import 'dart:math';

import 'package:flutter/material.dart';

class AppleWatchScreen extends StatefulWidget {
  const AppleWatchScreen({super.key});

  @override
  State<AppleWatchScreen> createState() => _AppleWatchScreenState();
}

class _AppleWatchScreenState extends State<AppleWatchScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 2),
    // lowerBound: 0.005,
    // upperBound: 2.0,
  )..forward();

  late final CurvedAnimation _curve = CurvedAnimation(
    parent: _animationController,
    curve: Curves.bounceOut,
  );

  late Animation<double> _progress = Tween(
    begin: 0.05,
    end: 1.5,
  ).animate(_curve);

  void _animateValues() {
    final newBegin = _progress.value;
    final random = Random();
    final newEnd = random.nextDouble() * 2.0;

    setState(() {
      _progress = Tween(begin: newBegin, end: newEnd).animate(_curve);
    });

    _animationController.forward(from: 0);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Apple Watch",
        ),
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: _progress,
          builder: (context, child) {
            return CustomPaint(
              painter: AppleWatchPainter(
                progress: _progress.value,
              ),
              size: const Size(300, 300),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _animateValues,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}

class AppleWatchPainter extends CustomPainter {
  final double progress;

  AppleWatchPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    // final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    // final rectPaint = Paint()..color = Colors.pink;
    // canvas.drawRect(rect, rectPaint);

    // final circlePaint = Paint()
    //   ..color = Colors.white
    //   ..style = PaintingStyle.stroke
    //   ..strokeWidth = 15;
    // canvas.drawCircle(
    //     Offset(size.width / 2, size.height / 2), size.width / 2, circlePaint);

    final center = Offset(size.width / 2, size.height / 2);
    const startAngle = -0.5 * pi;

    // draw red circle
    final redCircleRadius = (size.width / 2);

    final redCirclePaint = Paint()
      ..color = const Color(0xffF11851).withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 25;

    canvas.drawCircle(center, redCircleRadius, redCirclePaint);

    // draw green circle
    final greenCircleRadius = (size.width / 2) * 0.8;

    final greenCirclePaint = Paint()
      ..color = const Color(0xff9FF704).withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 25;

    canvas.drawCircle(center, greenCircleRadius, greenCirclePaint);

    // draw blue circle
    final blueCircleRadius = (size.width / 2) * 0.6;

    final blueCirclePaint = Paint()
      ..color = const Color(0xff05ECE5).withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 25;

    canvas.drawCircle(center, blueCircleRadius, blueCirclePaint);

    // draw red arc
    final redArcRect = Rect.fromCircle(center: center, radius: redCircleRadius);

    final redArcPaint = Paint()
      ..color = const Color(0xffF11851)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 25
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      redArcRect,
      startAngle,
      progress * pi,
      false,
      redArcPaint,
    );

    // draw green arc
    final greenArcRect =
        Rect.fromCircle(center: center, radius: greenCircleRadius);

    final greenArcPaint = Paint()
      ..color = const Color(0xff9FF704)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 25
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      greenArcRect,
      startAngle,
      progress * pi,
      false,
      greenArcPaint,
    );

    // draw blue arc
    final blueArcRect =
        Rect.fromCircle(center: center, radius: blueCircleRadius);

    final blueArcPaint = Paint()
      ..color = const Color(0xff05ECE5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 25
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      blueArcRect,
      startAngle,
      progress * pi,
      false,
      blueArcPaint,
    );
  }

  @override
  bool shouldRepaint(covariant AppleWatchPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
