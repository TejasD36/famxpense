import 'package:logger/logger.dart';

abstract final class AppLogger {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 5,
      lineLength: 100,
      colors: true,
      printEmojis: true,
      dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
    ),
  );

  /// GENERAL

  static void info(String message) {
    _logger.i(message);
  }

  static void warning(String message) {
    _logger.w(message);
  }

  static void error(String message, [Object? error, StackTrace? stackTrace]) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }

  static void debug(String message) {
    _logger.d(message);
  }

  static void success(String message) {
    _logger.f(message);
  }

  /// HIVE

  static void hive(String message) {
    _logger.i('📦 HIVE → $message');
  }

  /// FIREBASE

  static void firebase(String message) {
    _logger.t('🔥 FIREBASE → $message');
  }

  /// SYNC

  static void sync(String message) {
    _logger.w('🔄 SYNC → $message');
  }

  /// AUTH

  static void auth(String message) {
    _logger.d('🔐 AUTH → $message');
  }
}
