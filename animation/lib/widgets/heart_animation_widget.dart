import 'package:flutter/material.dart';

class HeartAnimationWidget extends StatefulWidget {
  final Widget child;
  final bool isAnimationg;
  final bool alwaysAnimate;
  final Duration duration;
  final VoidCallback? onEnd;

  const HeartAnimationWidget({
    super.key,
    required this.child,
    required this.isAnimationg,
    this.alwaysAnimate = false,
    this.duration = const Duration(milliseconds: 150),
    this.onEnd,
  });

  @override
  State<HeartAnimationWidget> createState() => _HeartAnimationWidgetState();
}

class _HeartAnimationWidgetState extends State<HeartAnimationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    final halfDuration = widget.duration.inMilliseconds ~/ 2;

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: halfDuration),
    );

    _scaleAnimation =
        Tween<double>(begin: 1, end: 1.2).animate(_animationController);
  }

  @override
  void didUpdateWidget(covariant HeartAnimationWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.isAnimationg != oldWidget.isAnimationg) {
      doAnimation();
    }
  }

  Future doAnimation() async {
    if (widget.isAnimationg || widget.alwaysAnimate) {
      await _animationController.forward();
      await _animationController.reverse();

      if (widget.onEnd != null) {
        widget.onEnd!();
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: widget.child,
    );
  }
}
