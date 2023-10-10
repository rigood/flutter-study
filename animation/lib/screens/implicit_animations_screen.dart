import 'package:flutter/material.dart';

class ImplicitAnimationsScreen extends StatefulWidget {
  const ImplicitAnimationsScreen({super.key});

  @override
  State<ImplicitAnimationsScreen> createState() =>
      _ImplicitAnimationsScreenState();
}

class _ImplicitAnimationsScreenState extends State<ImplicitAnimationsScreen> {
  bool _visible = true;

  void _trigger() {
    setState(() {
      _visible = !_visible;
    });
  }

  double _end = 15.0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Implicit Animations"),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            AnimatedAlign(
              alignment: _visible ? Alignment.topCenter : Alignment.topRight,
              duration: const Duration(seconds: 1),
              child: AnimatedOpacity(
                opacity: _visible ? 1 : 0.2,
                duration: const Duration(seconds: 1),
                child: AnimatedContainer(
                  duration: const Duration(seconds: 1),
                  curve: Curves.easeOut,
                  transform: Matrix4.rotationZ(_visible ? 0.5 : 0),
                  transformAlignment: Alignment.center,
                  width: _visible ? size.width * 0.1 : size.width * 0.2,
                  height: _visible ? size.height * 0.1 : size.height * 0.2,
                  color: _visible ? Colors.amber : Colors.pink,
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: _trigger,
              child: const Text("Start"),
            ),
            const SizedBox(
              height: 50,
            ),
            TweenAnimationBuilder(
              tween: Tween(begin: 10.0, end: 20.0),
              curve: Curves.bounceInOut,
              duration: const Duration(seconds: 2),
              builder: (context, value, child) {
                return Text(
                  "$value",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                );
              },
            ),
            const SizedBox(
              height: 50,
            ),
            TweenAnimationBuilder(
              tween: ColorTween(
                begin: Colors.red,
                end: Colors.blue,
              ),
              curve: Curves.bounceInOut,
              duration: const Duration(seconds: 2),
              builder: (context, value, child) {
                return Text(
                  "Color Changes",
                  style: TextStyle(
                    color: value,
                    fontSize: 40,
                  ),
                );
              },
            ),
            const SizedBox(
              height: 50,
            ),
            TweenAnimationBuilder(
              tween: Tween(begin: 0.0, end: _end),
              curve: Curves.easeIn,
              duration: const Duration(seconds: 1),
              onEnd: () {
                setState(() {
                  _end = _end == 15.0 ? -15.0 : 15.0;
                });
              },
              builder: (context, value, child) {
                return Transform.translate(
                  offset: Offset(value, value),
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
