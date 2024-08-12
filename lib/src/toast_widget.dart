// lib/src/toast_widget.dart

import 'package:flutter/material.dart';
import 'package:sandesh/utils/shake_animation.dart';
import 'package:sandesh/utils/swipable.dart';
import 'package:sandesh/utils/tap_animation.dart';
import 'toast_enum.dart';

class ToastWidget extends StatefulWidget {
  const ToastWidget({
    super.key,
    required this.overlayEntry,
    required this.message,
    required this.type,
    required this.title,
    required this.onTap,
    required this.gravity,
    this.titleStyle,
    this.messageStyle,
  });

  final OverlayEntry overlayEntry;
  final String message;
  final String title;
  final ToastType type;
  final VoidCallback onTap;
  final ToastGravity gravity;
  final TextStyle? titleStyle;
  final TextStyle? messageStyle;

  @override
  _ToastWidgetState createState() => _ToastWidgetState();
}

class _ToastWidgetState extends State<ToastWidget>
    with SingleTickerProviderStateMixin {
  // late AnimationController _controller;
  // late Animation<double> _opacityAnimation;
  // late Animation<double> _scaleAnimation;

  // @override
  // void initState() {
  //   super.initState();
  //   _controller = AnimationController(
  //     duration: const Duration(milliseconds: 300),
  //     vsync: this,
  //   );
  //   _opacityAnimation = CurvedAnimation(
  //     parent: _controller,
  //     curve: Curves.easeInOut,
  //   );

  //   _controller.forward();
  // }

  // @override
  // void dispose() {
  //   _controller.dispose();
  //   super.dispose();
  // }

  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    )..forward();

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _scaleAnimation = Tween<double>(begin: 0.9, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.06,
      left: MediaQuery.of(context).size.width * 0.05,
      right: MediaQuery.of(context).size.width * 0.05,
      // child: Center(
      //   child: FadeTransition(
      //     opacity: _opacityAnimation,
      //     child: GestureDetector(
      //       onTap: () {
      //         widget.onTap();
      //         _controller.reverse().then((_) => widget.overlayEntry.remove());
      //       },
      //       child: Material(
      //         color: Colors.transparent,
      //         child: buildToastContent(
      //           widget.message,
      //           widget.title,
      //           widget.type,
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
      child: Center(
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: FadeTransition(
            opacity: _opacityAnimation,
            child: TapAnimationWidget(
              onTap: () {
                widget.onTap();
                _controller.reverse().then((_) => widget.overlayEntry.remove());
                // _controller.reverse(); // Reverse animation on tap
              },
              child: GestureDetector(
                onHorizontalDragEnd: (details) {
                  // if (details.primaryVelocity! < 0) {
                  //   log('left');
                  //   // _offsetAnimation =
                  //   //     Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0))
                  //   //         .animate(_controller);
                  //   // _controller.forward().then((_) {

                  //   _offsetAnimation = Tween<Offset>(
                  //     begin: const Offset(0, 1),
                  //     end: const Offset(-1, 0),
                  //   ).animate(_controller);
                  //   // _controller.reset();
                  //   _controller.reverse().then((_) {
                  //     widget.overlayEntry.remove();
                  //     mainToast = null;
                  //   });
                  // } else if (details.primaryVelocity! > 0) {
                  //   log('right');

                  //   _offsetAnimation = Tween<Offset>(
                  //     begin: const Offset(1, 0),
                  //     end: const Offset(1, 0),
                  //   ).animate(_controller);
                  //   // _controller.reset();
                  //   _controller.forward().then((_) {
                  //     widget.overlayEntry.remove();
                  //     mainToast = null;
                  //   });
                  // }
                  // if (details.primaryVelocity! < 0) {
                  //   _offsetAnimation = Tween<Offset>(
                  //           begin: const Offset(-1, 0), end: const Offset(0, 0))
                  //       .animate(_controller);
                  //   _controller.forward().then((_) {
                  //     widget.overlayEntry.remove();
                  //     _currentToast = null;
                  //   });
                  // } else if (details.primaryVelocity! > 0) {
                  //   _offsetAnimation = Tween<Offset>(
                  //           begin: const Offset(1, 0), end: const Offset(0, 0))
                  //       .animate(_controller);
                  //   _controller.forward().then((_) {
                  //     widget.overlayEntry.remove();
                  //     _currentToast = null;
                  //   });
                  // }
                },
                onVerticalDragEnd: (_) {
                  widget.overlayEntry.remove();
                  // _controller.reverse().then((_) {
                  //   widget.overlayEntry.remove();
                  //   _currentToast = null;
                  // });
                },
                onTap: () {
                  widget.onTap();
                  // widget.timer.cancel();
                  // _controller.reverse().then((_) {
                  //   widget.overlayEntry.remove();
                  //   _currentToast = null;
                  // });
                },
                child: Material(
                  color: Colors.transparent,
                  type: MaterialType.transparency,
                  // shape: RoundedRectangleBorder(
                  // borderRadius: BorderRadius.circular(12.r),
                  // ),
                  elevation: 100,
                  // clipBehavior: Clip.hardEdge,
                  child: SwipeableWidget(
                    child: _buildToastContent(
                      widget.message,
                      widget.type,
                    ),
                    onSwipeLeft: () {
                      widget.overlayEntry.remove();
                    },
                    onSwipeRight: () {
                      widget.overlayEntry.remove();
                      // overlayEntry = null;
                    },
                    onSwipeUp: () {
                      widget.overlayEntry.remove();
                    },
                    // threshold: 4,
                  ),
                  // child: FadeTransition(
                  //   opacity: _opacityAnimation,
                  //   child: SlideTransition(
                  //     position: _offsetAnimation,
                  //     child: _buildToastContent(widget.message, widget.type),
                  //   ),
                  // ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildToastContent(String message, ToastType type) {
    Color backgroundColor;
    IconData iconvalue;
    switch (type) {
      case ToastType.SUCCESS:
        backgroundColor = Colors.green.shade400.withOpacity(.9);
        iconvalue = Icons.check_circle; // checkcircle

        break;
      case ToastType.ERROR:
        iconvalue = Icons.error_outline;
        backgroundColor = Colors.red.withOpacity(.9);
        break;
      case ToastType.WARNING:
        backgroundColor = Colors.orange.withAlpha(1000);
        iconvalue = Icons.warning_amber_rounded;

        break;
      case ToastType.INFO:
        backgroundColor = Colors.blue.withAlpha(1000);
        iconvalue = Icons.info_outline;

        break;
      case ToastType.DEFAULT:
        backgroundColor = Colors.grey.shade900.withOpacity(.95);
        iconvalue = Icons.notifications_on_outlined;

        break;
    }

    return type == ToastType.ERROR
        ? ShakeAnimationWidget(
            duration: const Duration(milliseconds: 50),
            child: buildToastWidget(
              context,
              message,
              widget.title,
              type,
              iconvalue,
              backgroundColor,
              widget.messageStyle,
              widget.titleStyle,
            ),
          )
        : buildToastWidget(
            context,
            message,
            widget.title,
            type,
            iconvalue,
            backgroundColor,
            widget.messageStyle,
            widget.titleStyle,
          );
  }

  Widget buildToastWidget(
    BuildContext context,
    String message,
    String title,
    ToastType type,
    IconData iconvalue,
    Color backgroundColor,
    TextStyle? messageStyle,
    TextStyle? titleStyle,
  ) {
    return Container(
      // alignment: Alignment.center,
      margin: const EdgeInsets.only(
        right: 8,
      ),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: backgroundColor,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              iconvalue,
              color: Colors.white,
              size: 20,
            ),
          ),
          // 5.horizontalSpace,
          const SizedBox(width: 5),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title.isNotEmpty) ...[
                  Text(title,
                      softWrap: true,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: titleStyle),
                  // 3.verticalSpace,
                  const SizedBox(height: 3),
                ],
                Text(message,
                    softWrap: true,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    // style: TextStyleClass.normalTextStyle(
                    //   color: Colors.white,
                    //   size: title.isNotEmpty ? 12.sp : 13.sp,
                    //   width: FontWeight.w400,
                    // ),
                    style: messageStyle
                    // style: const TextStyle(
                    //   color: Colors.white,
                    //   fontSize: 14,
                    //   fontWeight: FontWeight.w400,
                    // ),
                    ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
