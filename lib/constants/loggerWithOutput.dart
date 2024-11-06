import 'dart:io';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class FileLogOutput extends LogOutput {
  late File logFile;
  bool _isInitialized = false;

  FileLogOutput() {
    _initialize();
  }

  Future<void> _initialize() async {
    try {
      final directory = await getExternalStorageDirectory();
      final logDir = Directory(p.join(directory!.path, 'logs'));

      if (!logDir.existsSync()) {
        logDir.createSync(recursive: true);
      }

      logFile = File(p.join(logDir.path, 'logger.txt'));
      print('Log file path: ${logFile.path}');
      _isInitialized = true;
    } catch (e) {
      print("Error initializing log file: $e");
    }
  }

  @override
  void output(OutputEvent event) async {
    if (!_isInitialized) {
      await _initialize();
    }
    try {
      for (var line in event.lines) {
        await logFile.writeAsString('$line\n', mode: FileMode.append);
      }
    } catch (e) {
      print("Error writing to log file: $e");
    }
  }
}

final logger = Logger(
  output: FileLogOutput(),
  printer: PrettyPrinter(),
);
