// lib/src/toast_widget.dart

import 'package:flutter/material.dart';
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
  });

  final OverlayEntry overlayEntry;
  final String message;
  final String title;
  final ToastType type;
  final VoidCallback onTap;
  final ToastGravity gravity;

  @override
  _ToastWidgetState createState() => _ToastWidgetState();
}

class _ToastWidgetState extends State<ToastWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _opacityAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      // top: MediaQuery.of(context).size.height * 0.06,
      // left: MediaQuery.of(context).size.width * 0.05,
      // right: MediaQuery.of(context).size.width * 0.05,
      top: widget.gravity == ToastGravity.top ||
              widget.gravity == ToastGravity.topleft ||
              widget.gravity == ToastGravity.topright
          ? MediaQuery.of(context).size.height * 0.06
          : null,
      bottom: widget.gravity == ToastGravity.bottom ||
              widget.gravity == ToastGravity.bottomleft ||
              widget.gravity == ToastGravity.bottomright
          ? MediaQuery.of(context).size.height * 0.06
          : null,
      left: widget.gravity == ToastGravity.topleft ||
              widget.gravity == ToastGravity.bottomleft
          ? MediaQuery.of(context).size.width * 0.05
          : null,
      right: widget.gravity == ToastGravity.topright ||
              widget.gravity == ToastGravity.bottomright
          ? MediaQuery.of(context).size.width * 0.05
          : null,
      child: Center(
        child: FadeTransition(
          opacity: _opacityAnimation,
          child: GestureDetector(
            onTap: () {
              widget.onTap();
              _controller.reverse().then((_) => widget.overlayEntry.remove());
            },
            child: Material(
              color: Colors.transparent,
              child: buildToastContent(
                widget.message,
                widget.title,
                widget.type,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildToastContent(
    String message,
    String title,
    ToastType type,
  ) {
    // Implement your buildToastContent logic here, like showing icons, colors, etc.
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _getToastColor(type),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title.isNotEmpty)
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          const SizedBox(height: 4),
          Text(
            message,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Color _getToastColor(ToastType type) {
    switch (type) {
      case ToastType.SUCCESS:
        return Colors.green;
      case ToastType.ERROR:
        return Colors.red;
      case ToastType.WARNING:
        return Colors.orange;
      default:
        return Colors.black87;
    }
  }
}
