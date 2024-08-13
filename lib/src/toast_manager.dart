// lib/src/toast_manager.dart

import 'package:flutter/material.dart';
import 'package:sandesh/utils/vibration.dart';
import 'toast_widget.dart';
import 'toast_enum.dart';

// OverlayEntry? _mainToast;
// final isToastActive = _mainToast != null;

class Sandesh {
  static OverlayEntry? _mainToast;

  static void showToast(
    BuildContext context, {
    required String message,
    String title = '',
    void Function(OverlayEntry)? onTap,
    Duration duration = const Duration(seconds: 5),
    ToastType type = ToastType.DEFAULT,
    bool vibrate = true,
    TextStyle? titleStyle = const TextStyle(
      color: Colors.white,
      fontSize: 14,
      fontWeight: FontWeight.w600,
    ),
    TextStyle? messageStyle = const TextStyle(
      color: Colors.white,
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
    // ToastGravity gravity = ToastGravity.topcenter,
  }) {
    _clearToast();

    final overlay = Overlay.of(context);
    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => ToastWidget(
        overlayEntry: overlayEntry,
        message: message,
        onTap: onTap != null ? () => onTap(overlayEntry) : _clearToast,
        title: title,
        type: type,
        // Implement in future version
        gravity: ToastGravity.topcenter,
        titleStyle: titleStyle,
        messageStyle: messageStyle,
        //   messageStyle: const TextStyle(
        //       color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400),
      ),
    );

    ToastVibrator.provideHapticFeedback(
      type: type,
      vibrate: vibrate,
    );

    overlay.insert(overlayEntry);
    _mainToast = overlayEntry;

    if (onTap == null) {
      Future.delayed(duration, () {
        if (overlayEntry.mounted) {
          overlayEntry.remove();
          _mainToast = null;
        }
      });
    }
  }

  static void _clearToast() {
    if (_mainToast != null && _mainToast!.mounted) {
      _mainToast?.remove();
      _mainToast = null;
    }
  }
}
