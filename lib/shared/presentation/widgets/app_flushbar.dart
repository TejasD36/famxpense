import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

import '../../../app/theme/app_color.dart';

enum AppFlushbarType { success, error, general }

/// The shared in-app feedback message used across the app.
class AppFlushbar {
  const AppFlushbar._();

  static Flushbar<void>? _activeFlushbar;

  static Future<void> show({
    required BuildContext context,
    String? title,
    required String message,
    AppFlushbarType type = AppFlushbarType.general,
  }) async {
    // Keep one feedback route active. This avoids a previous timer trying to
    // dismiss a Flushbar while a newer one is being presented.
    await _activeFlushbar?.dismiss();
    if (!context.mounted) return;

    final color = _colorFor(type);
    final icon = _iconFor(type);

    final flushbar = Flushbar<void>(
      title: title ?? _titleFor(type),
      message: message,
      titleColor: Colors.white,
      messageColor: Colors.white,
      titleSize: 15,
      messageSize: 13,
      backgroundColor: color,
      // leftBarIndicatorColor: Colors.white.withValues(alpha: .75),
      icon: Icon(icon, color: Colors.white, size: 24),
      shouldIconPulse: false,
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      borderRadius: BorderRadius.circular(14),
      boxShadows: const [
        BoxShadow(
          color: Color(0x26000000),
          blurRadius: 12,
          offset: Offset(0, 4),
        ),
      ],
      duration: const Duration(seconds: 3),
      animationDuration: const Duration(milliseconds: 280),
      forwardAnimationCurve: Curves.easeOutCubic,
      reverseAnimationCurve: Curves.easeInCubic,
    );
    _activeFlushbar = flushbar;
    try {
      await flushbar.show(context);
    } finally {
      if (identical(_activeFlushbar, flushbar)) {
        _activeFlushbar = null;
      }
    }
  }

  static String _titleFor(AppFlushbarType type) => switch (type) {
    AppFlushbarType.success => 'Success',
    AppFlushbarType.error => 'Error',
    AppFlushbarType.general => 'Notice',
  };

  static Color _colorFor(AppFlushbarType type) {
    switch (type) {
      case AppFlushbarType.success:
        return AppColor.green;
      case AppFlushbarType.error:
        return AppColor.red;
      case AppFlushbarType.general:
        return AppColor.primary;
    }
  }

  static IconData _iconFor(AppFlushbarType type) {
    switch (type) {
      case AppFlushbarType.success:
        return Icons.check_circle_outline;
      case AppFlushbarType.error:
        return Icons.error_outline;
      case AppFlushbarType.general:
        return Icons.info_outline;
    }
  }
}
