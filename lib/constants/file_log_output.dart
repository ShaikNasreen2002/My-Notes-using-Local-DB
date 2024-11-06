// // // // // import 'dart:io';
// // // // // import 'package:logger/logger.dart';
// // // // // import 'package:path_provider/path_provider.dart';

// // // // // class FileLogOutput extends LogOutput {
// // // // //   late File logFile;

// // // // //   FileLogOutput() {
// // // // //     _initLogFile();
// // // // //   }

// // // // //   Future<void> _initLogFile() async {
// // // // //     final directory = await getApplicationDocumentsDirectory();
// // // // //     logFile = File('${directory.path}/app_logs.txt');
// // // // //   }

// // // // //   @override
// // // // //   void output(OutputEvent event) async {
// // // // //     final logMessages = event.lines.join('\n');
// // // // //     await logFile.writeAsString('${logMessages}\n', mode: FileMode.append);
// // // // //   }
// // // // // }

// // // // import 'dart:async';
// // // // import 'dart:io';
// // // // import 'package:logger/logger.dart';
// // // // import 'package:path_provider/path_provider.dart';

// // // // class FileLogOutput extends LogOutput {
// // // //   late File logFile;
// // // //   late Completer<void> _initialized;

// // // //   FileLogOutput() {
// // // //     _initialized = Completer<void>();
// // // //     _initLogFile();
// // // //   }

// // // //   Future<void> _initLogFile() async {
// // // //     final directory = await getApplicationDocumentsDirectory();
// // // //     print('${directory.path}/app_logs.txt' + 'is here');
// // // //     logFile = File('${directory.path}/app_logs.txt');
// // // //     await logFile.create(recursive: true);
// // // //     _initialized.complete();
// // // //   }

// // // //   @override
// // // //   void output(OutputEvent event) async {
// // // //     await _initialized.future;
// // // //     final logMessages = event.lines.join('\n');
// // // //     await logFile.writeAsString('${logMessages}\n', mode: FileMode.append);
// // // //   }
// // // // }

// // // import 'dart:async';
// // // import 'dart:io';
// // // import 'package:logger/logger.dart';
// // // import 'package:path_provider/path_provider.dart';

// // // class FileLogOutput extends LogOutput {
// // //   static late File _logFile;

// // //   FileLogOutput() {
// // //     _initLogFile();
// // //   }

// // //   void _initLogFile() async {
// // //     final path = await _localPath;
// // //     _logFile = File('$path/app_log.txt');
// // //     await _logFile.create();
// // //   }

// // //   // @override
// // //   // void output(OutputEvent event) async {
// // //   //   final logMessage = event.lines.join('\n');
// // //   //   await Logger.log(logMessage); // Use your custom logger's log method
// // //   // }

// // //   @override
// // //   void output(OutputEvent event) {
// // //     final logMessage = event.lines.join('\n');
// // //     _writeToLogFile(logMessage);
// // //   }

// // //   void _writeToLogFile(String message) {
// // //     _logFile.writeAsStringSync('$message\n', mode: FileMode.append);
// // //   }

// // //   Future<String> get _localPath async {
// // //     final directory = await getExternalStorageDirectory();
// // //     return directory?.path ??
// // //         await getApplicationDocumentsDirectory().then((value) => value.path);
// // //   }
// // // }

// // import 'dart:io';
// // import 'package:logger/logger.dart';
// // import 'package:path_provider/path_provider.dart';

// // class FileLogOutput extends LogOutput {
// //   late File _logFile;
// //   bool _initialized = false;

// //   FileLogOutput() {
// //     _initLogFile();
// //   }

// //   void _initLogFile() async {
// //     final path = await _localPath;
// //     _logFile = File('$path/app_log.txt');
// //     await _logFile.create();
// //     _initialized = true;
// //   }

// //   @override
// //   void output(OutputEvent event) {
// //     if (!_initialized) {
// //       // Handle initialization not complete scenario if needed
// //       print('Initialization not complete');
// //       return;
// //     }
// //     final logMessage = event.lines.join('\n');
// //     _writeToLogFile(logMessage);
// //   }

// //   void _writeToLogFile(String message) {
// //     _logFile.writeAsStringSync('$message\n files', mode: FileMode.append);
// //   }

// //   Future<String> get _localPath async {
// //     final directory = await getExternalStorageDirectory();
// //     return directory?.path ??
// //         await getApplicationDocumentsDirectory().then((value) => value.path);
// //   }
// // }

// import 'dart:io';
// import 'package:logger/logger.dart';
// import 'package:path_provider/path_provider.dart';

// // class FileLogOutput extends LogOutput {
// //   late File _logFile;
// //   bool _initialized = false;

// //   FileLogOutput() {
// //     _initLogFile();
// //   }

// //   void _initLogFile() async {
// //     final path = await _localPath;
// //     _logFile = File('$path/app_logs.txt');
// //     await _logFile.create();
// //     _initialized = true;
// //   }

// //   @override
// //   void output(OutputEvent event) {
// //     if (!_initialized) {
// //       // Handle initialization not complete scenario if needed
// //       return;
// //     }
// //     final logMessage = event.lines.join('\n');
// //     _writeToLogFile(logMessage);
// //   }

// //   void _writeToLogFile(String message) {
// //     _logFile.writeAsStringSync('$message\n', mode: FileMode.append);
// //   }

// //   Future<String> get _localPath async {
// //     final directory = await getExternalStorageDirectory();
// //     return directory?.path ??
// //         await getApplicationDocumentsDirectory().then((value) => value.path);
// //   }
// // }

// class FileOutput extends LogOutput {
//   FileOutput();

//   late File file;

//   @override
//   Future<void> init() async {
//     super.init();
//     file = new File('log.txt');
//   }

//   @override
//   void output(OutputEvent event) async {
//     if (file != null) {
//       for (var line in event.lines) {
//         await file.writeAsString("${line.toString()}\n",
//             mode: FileMode.writeOnlyAppend);
//       }
//     } else {
//       for (var line in event.lines) {
//         print(line);
//       }
//     }
//   }
// }
