import 'dart:math';

import 'package:flutter/material.dart';

class FlashCardsScreen extends StatefulWidget {
  const FlashCardsScreen({super.key});

  @override
  State<FlashCardsScreen> createState() => _FlashCardsScreenState();
}

class _FlashCardsScreenState extends State<FlashCardsScreen>
    with TickerProviderStateMixin {
  late final size = MediaQuery.of(context).size;

  int _index = 1;
  bool _isTextVisible = false;
  bool _isFliped = false;

  late final AnimationController _position = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 1),
    lowerBound: (size.width + 100) * -1,
    upperBound: (size.width + 100),
    value: 0.0,
  );

  late final Tween<double> _rotation = Tween(
    begin: -15,
    end: 15,
  );

  late final Tween<double> _scale = Tween(
    begin: 0.8,
    end: 1.0,
  );

  late final _color = ColorTween(
    begin: const Color(0xffFA243B),
    end: const Color(0xff4153F4),
  );

  late final AnimationController _progress = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 3),
  );

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    setState(() {
      _position.value += details.delta.dx;
    });

    if (_position.value.abs() >= 30) {
      setState(() {
        _isTextVisible = true;
      });
    } else {
      setState(() {
        _isTextVisible = false;
      });
    }
  }

  void _whenComplete() {
    _position.value = 0;
    setState(() {
      _index = _index == 8 ? 1 : _index + 1;
    });
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    final bound = size.width - 200;
    final dropZone = size.width + 100;

    if (_position.value.abs() >= bound) {
      final factor = _position.value.isNegative ? -1 : 1;
      _position
          .animateTo(dropZone * factor, curve: Curves.easeOut)
          .whenComplete(_whenComplete);
      _progress.animateTo(_index / 8, curve: Curves.easeOut);
    } else {
      _position.animateTo(0, curve: Curves.easeOut);
    }
  }

  void _onTap() {
    setState(() {
      _isFliped = !_isFliped;
    });
  }

  @override
  void dispose() {
    _position.dispose();
    _progress.dispose();
    super.dispose();
  }

  List<String> answers = [
    "웰컴 투 동막골",
    "클래식",
    "왕의 남자",
    "범죄도시",
    "건축학개론",
    "엑시트",
    "타짜: 원 아이드 잭",
    "기생충"
  ];

  Widget transitionBuilder(Widget widget, Animation<double> animation) {
    final rotate = Tween(
      begin: pi,
      end: 0.0,
    ).animate(animation);
    return AnimatedBuilder(
        animation: rotate,
        child: widget,
        builder: (_, widget) {
          final isBack = !_isFliped
              ? widget!.key == const Key("back")
              : widget!.key == const Key("front");
          final value = isBack ? min(rotate.value, pi / 2) : rotate.value;

          double tilt = ((animation.value - 0.5).abs() - 0.5) * 0.002;
          tilt = isBack ? tilt * -1 : tilt;

          return Transform(
            transform: Matrix4.rotationY(value)..setEntry(3, 0, tilt),
            alignment: Alignment.center,
            child: widget,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AnimatedBuilder(
      animation: _position,
      builder: (context, child) {
        final scale = _scale.transform(_position.value.abs() / size.width);
        final angle = _rotation
                .transform((_position.value + size.width / 2) / size.width) *
            pi /
            180;
        final color =
            _color.transform((_position.value + size.width / 2) / size.width);
        return Scaffold(
          backgroundColor: color,
          body: Stack(
            alignment: Alignment.topCenter,
            children: [
              const Positioned(
                top: 110,
                child: Text(
                  "그림 보고 영화 이름 맞추기",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Positioned(
                top: 140,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 15,
                  ),
                  child: AnimatedOpacity(
                    opacity: _isTextVisible ? 1 : 0,
                    duration: const Duration(seconds: 1),
                    child: Text(
                      _position.value.abs() < 30
                          ? ""
                          : _position.value.isNegative
                              ? "오답입니다!"
                              : "정답입니다!",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 200,
                child: Transform.scale(
                  scale: min(scale, 1.0),
                  child: Card(
                    index: _index == 8 ? 1 : _index + 1,
                    isFliped: false,
                  ),
                ),
              ),
              Positioned(
                top: 200,
                child: GestureDetector(
                  onHorizontalDragUpdate: _onHorizontalDragUpdate,
                  onHorizontalDragEnd: _onHorizontalDragEnd,
                  onTap: _onTap,
                  child: Transform.translate(
                    offset: Offset(_position.value, 0),
                    child: Transform.rotate(
                      angle: angle,
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 800),
                        transitionBuilder: transitionBuilder,
                        layoutBuilder: (widget, list) {
                          return Stack(
                            children: [
                              widget!,
                              ...list,
                            ],
                          );
                        },
                        child: Card(
                          key: Key(_isFliped ? "back" : "front"),
                          index: _index,
                          isFliped: _isFliped,
                          answer: answers[_index - 1],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              AnimatedBuilder(
                animation: _progress,
                builder: (context, child) {
                  return Positioned(
                    bottom: 100,
                    child: CustomPaint(
                      size: Size(size.width - 80, 10),
                      painter: ProgressBar(
                        percentage: _progress.value,
                      ),
                    ),
                  );
                },
              ),
              const Positioned(
                bottom: 50,
                child: Text(
                  "그림 출처: 뿜작가",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class ProgressBar extends CustomPainter {
  final double percentage;

  ProgressBar({
    required this.percentage,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // track
    final trackPaint = Paint()
      ..color = Colors.grey.shade300
      ..style = PaintingStyle.fill;

    final trackRRect = RRect.fromLTRBR(
      0,
      0,
      size.width,
      size.height,
      const Radius.circular(10),
    );

    canvas.drawRRect(trackRRect, trackPaint);

    // progress
    final progressPaint = Paint()
      ..color = Colors.amber
      ..style = PaintingStyle.fill;

    final progressRRect = RRect.fromLTRBR(
      0,
      0,
      size.width * percentage,
      size.height,
      const Radius.circular(10),
    );

    canvas.drawRRect(progressRRect, progressPaint);
  }

  @override
  bool shouldRepaint(covariant ProgressBar oldDelegate) {
    return oldDelegate.percentage != percentage;
  }
}

class Card extends StatelessWidget {
  final int index;
  final bool isFliped;
  final String? answer;

  const Card({
    super.key,
    required this.index,
    required this.isFliped,
    this.answer,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.8,
      height: size.width * 0.8,
      decoration: BoxDecoration(
        color: Colors.white,
        border: isFliped
            ? Border.all(
                color: Colors.black,
                width: 4.0,
                strokeAlign: BorderSide.strokeAlignInside,
              )
            : null,
      ),
      child: isFliped
          ? Center(
              child: Text(
                answer!,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : Image.asset(
              "assets/quiz/$index.jpg",
              fit: BoxFit.cover,
            ),
    );
  }
}
