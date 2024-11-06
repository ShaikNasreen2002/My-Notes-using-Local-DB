import 'package:logger/logger.dart';

class LoggerData {
  static const String info = "info";
  static const String warning = "warning";
  static const String error = "error";
  static const String debug = "debug";
  static void logging(String message, String type) {
    switch (type) {
      case info:
        logger.i(message, time: DateTime.now(), stackTrace: StackTrace.current);
        break;
      case debug:
        logger.d(message, time: DateTime.now(), stackTrace: StackTrace.current);
        break;
      case warning:
        logger.w(message, time: DateTime.now(), stackTrace: StackTrace.current);
        break;
      case error:
        logger.e(message, time: DateTime.now(), stackTrace: StackTrace.current);
        break;
      default:
        logger.e('No such type: $type');
    }
  }
}

final logger = Logger();
