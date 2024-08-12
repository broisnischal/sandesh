import 'package:flutter/material.dart';

class SwipeableWidget extends StatefulWidget {
  const SwipeableWidget({
    super.key,
    required this.child,
    this.threshold = 50.0,
    this.onSwipeLeft,
    this.onSwipeRight,
  });
  final Widget child;
  final double threshold;
  final VoidCallback? onSwipeLeft;
  final VoidCallback? onSwipeRight;

  @override
  _SwipeableWidgetState createState() => _SwipeableWidgetState();
}

class _SwipeableWidgetState extends State<SwipeableWidget> {
  double _offset = 0;

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    setState(() {
      _offset += details.primaryDelta!;
    });
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    if (_offset.abs() > widget.threshold) {
      if (_offset > 0) {
        // Swiped to the right
        if (widget.onSwipeRight != null) {
          widget.onSwipeRight!();
        }
      } else {
        // Swiped to the left
        if (widget.onSwipeLeft != null) {
          widget.onSwipeLeft!();
        }
      }
    }
    setState(() {
      _offset = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: _onHorizontalDragUpdate,
      onHorizontalDragEnd: _onHorizontalDragEnd,
      child: Transform.translate(
        offset: Offset(_offset, 0),
        child: widget.child,
      ),
    );
  }
}
