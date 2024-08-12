import 'package:flutter/material.dart';

class ShakeAnimationWidget extends StatefulWidget {
  const ShakeAnimationWidget({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 500),
    this.shakeSpeed = 6.0,
    this.shakeThreshold = 10.0,
    this.shakeCount = 4, // Number of shakes
  });

  final Widget child;
  final Duration duration;
  final double shakeSpeed;
  final double shakeThreshold;
  final int shakeCount;

  @override
  _ShakeAnimationWidgetState createState() => _ShakeAnimationWidgetState();
}

class _ShakeAnimationWidgetState extends State<ShakeAnimationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  int _shakeCount = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _animation = Tween<double>(
      begin: -widget.shakeSpeed,
      end: widget.shakeSpeed,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (_shakeCount < widget.shakeCount - 1) {
          _controller.reverse();
          _shakeCount++;
        } else {
          _controller.stop();
        }
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void shake() {
    _shakeCount = 0;
    _controller.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(_animation.value, 0),
          child: widget.child,
        );
      },
    );
  }
}
