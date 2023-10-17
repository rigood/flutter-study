import 'dart:async';
import 'package:animation/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:animation/constants/gaps.dart';
import 'package:animation/screens/final_screen.dart';

class FinalSplashScreen extends StatefulWidget {
  const FinalSplashScreen({super.key});

  @override
  State<FinalSplashScreen> createState() => _FinalSplashScreenState();
}

class _FinalSplashScreenState extends State<FinalSplashScreen>
    with TickerProviderStateMixin {
  bool _isScaleAnimating = false;

  late final AnimationController _decorationController = AnimationController(
    vsync: this,
    duration: const Duration(
      milliseconds: 300,
    ),
  );

  late final AnimationController _scaleController = AnimationController(
    vsync: this,
    duration: const Duration(
      milliseconds: 500,
    ),
  );

  late final Animation<Decoration> _decorationAnimation = DecorationTween(
    begin: BoxDecoration(
      borderRadius: BorderRadius.circular(0),
      gradient: const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          ColorThemes.primary1,
          ColorThemes.primary2,
        ],
      ),
    ),
    end: BoxDecoration(
      borderRadius: BorderRadius.circular(50),
      gradient: const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          ColorThemes.primary1,
          ColorThemes.primary2,
        ],
      ),
    ),
  ).animate(_decorationController);

  late final Animation<double> _scaleAnimation =
      Tween(begin: 1.0, end: 10.0).animate(_scaleController)
        ..addListener(
          () {
            if (_scaleController.isCompleted) {
              Navigator.of(context).push(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return const FinalScreen();
                  },
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                ),
              );

              Timer(
                const Duration(milliseconds: 500),
                () {
                  _decorationController.reset();
                  _scaleController.reset();
                  setState(
                    () {
                      _isScaleAnimating = false;
                    },
                  );
                },
              );
            }
          },
        );

  void _onTap() async {
    _decorationController.forward();

    await Future.delayed(
      const Duration(seconds: 1),
    );

    setState(() {
      _isScaleAnimating = true;
    });

    _scaleController.forward();
  }

  @override
  void dispose() {
    _decorationController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: GestureDetector(
              onTap: _onTap,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: DecoratedBoxTransition(
                  decoration: _decorationAnimation,
                  child: const SizedBox(
                    width: 100,
                    height: 100,
                  ),
                ),
              ),
            ),
          ),
          Gaps.v20,
          AnimatedOpacity(
            opacity: _isScaleAnimating ? 0 : 1,
            duration: const Duration(milliseconds: 300),
            child: Text(
              "CINEBOX",
              style: TextStyle(
                fontSize: 24,
                fontFamily: "OA",
                fontWeight: FontWeight.w900,
                foreground: Paint()
                  ..shader = const LinearGradient(
                    colors: [
                      ColorThemes.primary1,
                      ColorThemes.primary2,
                    ],
                  ).createShader(
                    const Rect.fromLTWH(0.0, 0.0, 100, 24),
                  ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
