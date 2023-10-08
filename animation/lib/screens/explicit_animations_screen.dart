import 'package:flutter/material.dart';

class ExplicitAnimationsScreen extends StatefulWidget {
  const ExplicitAnimationsScreen({super.key});

  @override
  State<ExplicitAnimationsScreen> createState() =>
      _ExplicitAnimationsScreenState();
}

class _ExplicitAnimationsScreenState extends State<ExplicitAnimationsScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(
      seconds: 2,
    ),
    reverseDuration: const Duration(
      seconds: 1,
    ),
    // lowerBound: 50.0,
    // upperBound: 100.0,
  )..addListener(() {
      _range.value = _animationController.value;
    });

  // late final Animation<Color?> _color = ColorTween(
  //   begin: Colors.pink,
  //   end: Colors.lightBlue,
  // ).animate(_curved);

  late final Animation<Decoration> _decoration = DecorationTween(
      begin: BoxDecoration(
        color: Colors.pink,
        borderRadius: BorderRadius.circular(20),
      ),
      end: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(100),
      )).animate(_curved);

  late final Animation<double> _roation = Tween(
    begin: 0.0,
    end: 2.0,
  ).animate(_curved);

  late final Animation<double> _scale = Tween(
    begin: 1.0,
    end: 1.1,
  ).animate(_curved);

  late final Animation<Offset> _position = Tween(
    begin: Offset.zero,
    end: const Offset(0, -0.3),
  ).animate(_curved);

  late final CurvedAnimation _curved = CurvedAnimation(
    parent: _animationController,
    curve: Curves.elasticOut,
    reverseCurve: Curves.bounceIn,
  );

  final ValueNotifier<double> _range = ValueNotifier(0.0);

  void _onChanged(double value) {
    _range.value = 0;
    _animationController.value = value;
  }

  bool _looping = false;

  void _toggleLooping() {
    if (_looping) {
      _animationController.stop();
    } else {
      _animationController.repeat(reverse: true);
    }

    setState(() {
      _looping = !_looping;
    });
  }

  void _play() {
    _animationController.forward();
  }

  void _pause() {
    _animationController.stop();
  }

  void _rewind() {
    _animationController.reverse();
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
          "Explicit Animations",
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(30),
            child: SlideTransition(
              position: _position,
              child: ScaleTransition(
                scale: _scale,
                child: RotationTransition(
                  turns: _roation,
                  child: DecoratedBoxTransition(
                    decoration: _decoration,
                    child: const SizedBox(
                      width: 300,
                      height: 300,
                    ),
                  ),
                ),
              ),
            ),
          ),
          // AnimatedBuilder(
          //   animation: _color,
          //   builder: (context, child) {
          //     return Container(
          //       color: _color.value,
          //       width: 300,
          //       height: 300,
          //     );
          //   },
          // ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: _play,
                  child: const Text("Play"),
                ),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: _pause,
                  child: const Text("Pause"),
                ),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: _rewind,
                  child: const Text("Rewind"),
                ),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: _toggleLooping,
                  child: Text(_looping ? "Stop looping" : "Start looping"),
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          ValueListenableBuilder(
            valueListenable: _range,
            builder: (context, value, child) {
              return Slider(
                value: value,
                onChanged: _onChanged,
              );
            },
          ),
        ],
      ),
    );
  }
}
