import 'package:flutter/material.dart';

class AnimationLogo extends StatefulWidget {
  final double width;
  final double height;

  const AnimationLogo({Key? key, required this.width, required this.height})
      : super(key: key);

  @override
  _AnimationLogoState createState() => _AnimationLogoState();
}

class _AnimationLogoState extends State<AnimationLogo>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 1),
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeIn,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: Image.asset(
        'assets/logo-transparent.png',
        width: widget.width,
        height: widget.height,
      ),
    );
  }
}
