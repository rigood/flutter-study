import 'package:flutter/material.dart';

class ExplicitAnimationsChallenge extends StatefulWidget {
  const ExplicitAnimationsChallenge({super.key});

  @override
  State<ExplicitAnimationsChallenge> createState() =>
      _ExplicitAnimationsChallengeState();
}

List<int> _list = [1, 2, 3, 4, 5, 6, 7, 8];

class _ExplicitAnimationsChallengeState
    extends State<ExplicitAnimationsChallenge> with TickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(
      milliseconds: 500,
    ),
  )..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(
          const Duration(milliseconds: 1000),
          () {
            if (mounted) {
              _animationController.forward(from: 0.0);
            }
          },
        );
      }
    });

  late final CurvedAnimation _curved = CurvedAnimation(
    parent: _animationController,
    curve: Curves.easeOut,
  );

  late final Animation<double> _rotation = Tween(
    begin: 0.0,
    end: 0.25,
  ).animate(_curved);

  @override
  void initState() {
    super.initState();
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff2B2E2D),
      appBar: AppBar(
        title: const Text(
          "Explicit Animations Challenge",
        ),
      ),
      body: Column(
        children: [
          makeOddRow(context),
          makeEvenRow(context),
          makeOddRow(context),
          makeEvenRow(context),
          makeOddRow(context),
          makeEvenRow(context),
          makeOddRow(context),
          makeEvenRow(context),
        ],
      ),
    );
  }

  Row makeOddRow(BuildContext context) {
    return Row(
      children: [
        for (var item in _list)
          RotationTransition(
            turns: _rotation,
            child: Container(
              color: item % 2 == 1 ? const Color(0xffCDCDCD) : Colors.black,
              width: MediaQuery.of(context).size.width / 8,
              height: MediaQuery.of(context).size.width / 8,
            ),
          ),
      ],
    );
  }

  Row makeEvenRow(BuildContext context) {
    return Row(
      children: [
        for (var item in _list)
          Container(
            color: item % 2 == 0 ? const Color(0xffCDCDCD) : Colors.black,
            width: MediaQuery.of(context).size.width / 8,
            height: MediaQuery.of(context).size.width / 8,
          ),
      ],
    );
  }
}
