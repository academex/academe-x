import 'package:logger/logger.dart';
import 'package:flutter/foundation.dart';

class AppLogger {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 1,      // Number of method calls to be displayed
      errorMethodCount: 8, // Number of method calls if stacktrace is provided
      lineLength: 120,     // Width of the output
      colors: true,        // Colorful log messages
      printEmojis: true,   // Print an emoji for each log message
      printTime: true,     // Should each log print contain a timestamp
      stackTraceBeginIndex: 0
    ),
    level: kDebugMode ? Level.debug : Level.nothing,
  );

  // For general debug messages
  static void d(String message) {
    _logger.d('👀 DEBUG: $message',);
  }

  // For informational messages
  static void i(String message) {
    _logger.i('ℹ️ INFO: $message');

  }

  // For warning messages
  static void w(String message) {
    _logger.w('⚠️ WARNING: $message');
  }

  // For error messages
  static void e(String message, [Object? error, StackTrace? stackTrace]) {
    _logger.e('❌ ERROR: $message', error: error, stackTrace: stackTrace);
  }

  // For critical failures
  static void wtf(String message, [Object? error, StackTrace? stackTrace]) {
    _logger.wtf('💀 CRITICAL: $message', error: error, stackTrace: stackTrace);
  }

  // For success messages
  static void success(String message) {
    _logger.i('✅ SUCCESS: $message');
  }

  // For network related logs
  static void network(String message) {
    _logger.i('🌐 NETWORK: $message');
  }

  // For authentication related logs
  static void auth(String message) {
    _logger.i('🔐 AUTH: $message');
  }

  // For database operations
  static void database(String message) {
    _logger.i('💾 DATABASE: $message');
  }
}