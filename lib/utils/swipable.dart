import 'package:flutter/material.dart';

class SwipeableWidget extends StatefulWidget {
  const SwipeableWidget({
    super.key,
    required this.child,
    this.threshold = 50.0,
    this.onSwipeLeft,
    this.onSwipeRight,
    this.onSwipeUp,
  });

  final Widget child;
  final double threshold;
  final VoidCallback? onSwipeLeft;
  final VoidCallback? onSwipeRight;
  final VoidCallback? onSwipeUp;

  @override
  _SwipeableWidgetState createState() => _SwipeableWidgetState();
}

class _SwipeableWidgetState extends State<SwipeableWidget> {
  double _offsetX = 0;
  double _offsetY = 0;

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    setState(() {
      _offsetX += details.primaryDelta!;
    });
  }

  void _onVerticalDragUpdate(DragUpdateDetails details) {
    setState(() {
      // Update only if the vertical offset is negative (upward swipe)
      if (_offsetY < 0) {
        _offsetY += details.primaryDelta!;
      }
    });
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    if (_offsetX.abs() > widget.threshold) {
      if (_offsetX > 0) {
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
      _offsetX = 0.0;
    });
  }

  void _onVerticalDragEnd(DragEndDetails details) {
    if (_offsetY < 0 && _offsetY.abs() > widget.threshold) {
      // Swiped up
      if (widget.onSwipeUp != null) {
        widget.onSwipeUp!();
      }
    }

    setState(() {
      _offsetY = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: _onHorizontalDragUpdate,
      onHorizontalDragEnd: _onHorizontalDragEnd,
      onVerticalDragUpdate: _onVerticalDragUpdate,
      onVerticalDragEnd: _onVerticalDragEnd,
      child: Transform.translate(
        offset: Offset(_offsetX, _offsetY),
        child: widget.child,
      ),
    );
  }
}

// import 'package:flutter/material.dart';

// class SwipeableWidget extends StatefulWidget {
//   const SwipeableWidget({
//     super.key,
//     required this.child,
//     this.threshold = 50.0,
//     this.onSwipeLeft,
//     this.onSwipeRight,
//     this.onSwipeUp,
//   });
//   final Widget child;
//   final double threshold;
//   final VoidCallback? onSwipeLeft;
//   final VoidCallback? onSwipeRight;
//   final VoidCallback? onSwipeUp;

//   @override
//   _SwipeableWidgetState createState() => _SwipeableWidgetState();
// }

// class _SwipeableWidgetState extends State<SwipeableWidget> {
//   double _offset = 0;
//   double _verticalOffset = 0;

//   void _onHorizontalDragUpdate(DragUpdateDetails details) {
//     setState(() {
//       _offset += details.primaryDelta!;
//     });
//   }

//   void _onVerticalDragUpdate(DragUpdateDetails details) {
//     setState(() {
//       _verticalOffset += details.primaryDelta!;
//     });
//   }

//   void _onHorizontalDragEnd(DragEndDetails details) {
//     if (_offset.abs() > widget.threshold) {
//       if (_offset > 0) {
//         // Swiped to the right
//         if (widget.onSwipeRight != null) {
//           widget.onSwipeRight!();
//         }
//       } else {
//         // Swiped to the left
//         if (widget.onSwipeLeft != null) {
//           widget.onSwipeLeft!();
//         }
//       }
//     }

//     setState(() {
//       _offset = 0.0;
//       // _verticalOffset = 0.0;
//     });
//   }

//   // void _onVerticalDragEnd(DragEndDetails details) {
//   //   if (_verticalOffset.abs() > widget.threshold) {
//   //     if (_verticalOffset > 0) {
//   //       // Swiped to the right
//   //       if (widget.onSwipeRight != null) {
//   //         widget.onSwipeRight!();
//   //       }
//   //     } else {
//   //       // Swiped to the left
//   //       if (widget.onSwipeLeft != null) {
//   //         widget.onSwipeLeft!();
//   //       }
//   //     }
//   //   }

//   //   setState(() {
//   //     // _offset = 0.0;
//   //     _verticalOffset = 0.0;
//   //   });
//   // }
//   void _onVerticalDragEnd(DragEndDetails details) {
//     if (_verticalOffset < 0 && _verticalOffset.abs() > widget.threshold) {
//       // Swiped up
//       if (widget.onSwipeUp != null) {
//         widget.onSwipeUp!();
//       }
//     }

//     setState(() {
//       _verticalOffset = 0.0;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onHorizontalDragUpdate: _onHorizontalDragUpdate,
//       onHorizontalDragEnd: _onHorizontalDragEnd,
//       onVerticalDragUpdate: _onVerticalDragUpdate,
//       onVerticalDragEnd: _onVerticalDragEnd,
//       child: Transform.translate(
//         offset: Offset(_offset, _verticalOffset),
//         child: widget.child,
//       ),
//     );
//   }
// }
