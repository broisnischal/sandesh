// lib/src/toast_manager.dart

import 'package:flutter/material.dart';
import 'toast_widget.dart';
import 'toast_enum.dart';

class ToastManager {
  static OverlayEntry? _mainToast;

  static void showToast(
    BuildContext context, {
    required String message,
    String title = '',
    void Function()? onTap,
    removeonTap = false,
    Duration duration = const Duration(seconds: 5),
    ToastType type = ToastType.DEFAULT,
    ToastGravity gravity = ToastGravity.topcenter,
  }) {
    _clearToast();

    final overlay = Overlay.of(context);
    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => ToastWidget(
        overlayEntry: overlayEntry,
        message: message,
        onTap: onTap ?? (removeonTap ? _clearToast : () {}),
        title: title,
        type: type,
        gravity: gravity,
      ),
    );

    overlay.insert(overlayEntry);
    _mainToast = overlayEntry;

    if (onTap == null) {
      Future.delayed(duration, () {
        _clearToast();
      });
    }
  }

  static void _clearToast() {
    // Null check and safe removal of the current toast
    if (_mainToast != null && _mainToast!.mounted) {
      _mainToast?.remove();
      _mainToast = null;
    }
  }
}
