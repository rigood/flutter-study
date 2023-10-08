import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class PomodoroScreen extends StatefulWidget {
  const PomodoroScreen({super.key});

  @override
  State<PomodoroScreen> createState() => _PomodoroScreenState();
}

class _PomodoroScreenState extends State<PomodoroScreen>
    with SingleTickerProviderStateMixin {
  Timer? _focusTimer;
  Timer? _restTimer;

  static const _defaultFocustTime = 10;
  static const _defaultRestTime = 3;

  int _focusTime = _defaultFocustTime;
  int _restTime = _defaultRestTime;

  bool _isRunning = false;

  static const _focus = "focus";
  static const _rest = "rest";
  String _current = _focus;

  int round = 0;

  void _startTimer() {
    if (_current == _focus) {
      _focusTimer = Timer.periodic(
        const Duration(seconds: 1),
        _onFocusTick,
      );

      _animationController.forward(
          from: (_defaultFocustTime - _focusTime) / _defaultFocustTime);
    } else {
      _restTimer = Timer.periodic(
        const Duration(seconds: 1),
        _onRestTick,
      );

      _animationController.forward(
          from: (_defaultRestTime - _restTime) / _defaultRestTime);
    }

    setState(() {
      _isRunning = true;
    });
  }

  void _pauseTimer() {
    if (_current == _focus) {
      _focusTimer?.cancel();
    } else {
      _restTimer?.cancel();
    }

    _animationController.stop();

    setState(() {
      _isRunning = false;
    });
  }

  void _resetTimer() {
    if (_current == _focus) {
      _focusTimer?.cancel();
    } else {
      _restTimer?.cancel();
    }

    setState(() {
      _isRunning = false;
      _focusTime = _defaultFocustTime;
      _restTime = _defaultRestTime;
      round = 0;
    });

    _animationController.stop();
    _animationController.value = 0;
    _animationController.duration = const Duration(seconds: _defaultFocustTime);
  }

  void _stopTimer() {
    if (_current == _focus) {
      _focusTimer?.cancel();
      setState(() {
        _isRunning = false;
        _focusTime = _defaultFocustTime;
      });
    } else {
      _restTimer?.cancel();
      setState(() {
        _isRunning = false;
        _restTime = _defaultRestTime;
      });
    }

    _animationController.stop();
    _animationController.value = 0;
  }

  void _onFocusTick(Timer timer) {
    if (_focusTime == 0) {
      _focusTimer?.cancel();
      _restTimer = Timer.periodic(const Duration(seconds: 1), _onRestTick);

      setState(() {
        _focusTime = _defaultFocustTime;
        _current = _rest;
      });

      _animationController.duration = const Duration(seconds: _defaultRestTime);
      _animationController.forward(from: 0);
    } else {
      setState(() {
        _focusTime = _focusTime - 1;
      });
    }
  }

  void _onRestTick(Timer timer) {
    if (_restTime == 0) {
      _restTimer?.cancel();
      _focusTimer = Timer.periodic(const Duration(seconds: 1), _onFocusTick);

      setState(() {
        round = round + 1;
        _restTime = _defaultRestTime;
        _current = _focus;
      });

      _animationController.duration =
          const Duration(seconds: _defaultFocustTime);
      _animationController.forward(from: 0);
    } else {
      setState(() {
        _restTime = _restTime - 1;
      });
    }
  }

  String format(int seconds) {
    var duration = Duration(seconds: seconds);
    return duration.toString().split(".").first.substring(2).toString();
  }

  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(seconds: _defaultFocustTime),
  );

  late final Animation<double> _progress = Tween(
    begin: 0.0,
    end: 1.0,
  ).animate(_animationController);

  @override
  void dispose() {
    _animationController.dispose();
    _focusTimer?.cancel();
    _restTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Pomodoro",
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 100,
          ),
          Center(
            child: AnimatedBuilder(
              animation: _progress,
              builder: (context, child) {
                return CustomPaint(
                  painter: RingPainter(
                    progress: _progress.value,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(60),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _current == _focus ? "Focus" : "Rest",
                          style: const TextStyle(
                            color: Color(0xffF1F1F1),
                          ),
                        ),
                        Text(
                          format(_current == _focus ? _focusTime : _restTime),
                          style: const TextStyle(
                            fontSize: 60,
                            color: Color(0xffF1F1F1),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            for (int i = 0; i < 3; i++)
                              Icon(
                                Icons.diamond,
                                color: i < round
                                    ? const Color(0xffEF4F89)
                                    : Colors.grey,
                              )
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(
            height: 100,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: const Color(0xff1D1D1D),
                child: IconButton(
                  onPressed: _resetTimer,
                  icon: const Icon(
                    Icons.refresh_rounded,
                    color: Color(0xffEF4F89),
                    size: 22,
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              CircleAvatar(
                radius: 40,
                backgroundColor: const Color(0xffEF4F89),
                child: IconButton(
                  onPressed: _isRunning ? _pauseTimer : _startTimer,
                  icon: Icon(
                    _isRunning ? Icons.pause_rounded : Icons.play_arrow_rounded,
                    size: 50,
                    color: const Color(0xff1D1D1D),
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              CircleAvatar(
                radius: 25,
                backgroundColor: const Color(0xff1D1D1D),
                child: IconButton(
                  onPressed: _stopTimer,
                  icon: const Icon(
                    Icons.stop_rounded,
                    color: Color(0xffEF4F89),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class RingPainter extends CustomPainter {
  final double progress;

  RingPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

// draw bgCircle
    final bgCircleRadius = size.width / 2;
    final bgCirclePaint = Paint()
      ..color = const Color(0xff1D1D1D)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 30;

    canvas.drawCircle(center, bgCircleRadius, bgCirclePaint);

    // draw ringArc

    final ringArcRect = Rect.fromCircle(center: center, radius: bgCircleRadius);
    final ringArcPaint = Paint()
      ..color = const Color(0xffEF4F89)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 30
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      ringArcRect,
      -pi / 2,
      2 * pi * progress,
      false,
      ringArcPaint,
    );
  }

  @override
  bool shouldRepaint(covariant RingPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
