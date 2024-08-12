import 'package:flutter/services.dart';
import 'package:sandesh/src/toast_enum.dart';

class ToastVibrator {
  static void provideHapticFeedback(
      {ToastType type = ToastType.DEFAULT,
      Function()? successCustomVibration,
      Function()? errorVibration,
      bool? vibrate}) {
    if (vibrate != null && !vibrate) return;
    switch (type) {
      case ToastType.SUCCESS:
        if (successCustomVibration == null) {
          HapticFeedback.selectionClick();
        } else {
          successCustomVibration();
        }
        break;
      case ToastType.ERROR:
        errorVibration ?? HapticFeedback.heavyImpact();
        break;
      case ToastType.INFO:
        HapticFeedback.mediumImpact();
        break;
      case ToastType.DEFAULT:
        HapticFeedback.vibrate();
        break;
      default:
        HapticFeedback.lightImpact();
        break;
    }
  }
}
