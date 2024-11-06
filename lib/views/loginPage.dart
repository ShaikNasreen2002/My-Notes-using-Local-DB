import 'package:flutter/material.dart';
import 'package:flutter_application/constants/routes.dart';
import 'package:flutter_application/services/auth/auth_exceptions.dart';
import 'package:flutter_application/services/auth/auth_service.dart';
// import 'package:flutter_application/utilities/show_error_dialog.dart';
// import 'package:logger/logger.dart';
// import 'dart:developer' as devtools show log;
import '../constants/loggerWithOutput.dart';
import '../utilities/dialogs/error_dialog.dart';

// var logger = Logger();
class LoginView extends StatefulWidget {
  const LoginView({super.key, required this.title});
  final String title;

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  // int _counter = 0;
  late TextEditingController _email = TextEditingController();
  late TextEditingController _password = TextEditingController();

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Color.fromARGB(255, 7, 114, 245),
      ),
      body: Column(
        children: [
          TextField(
            controller: _email,
            enableSuggestions: false,
            autocorrect: true,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(hintText: 'Enter Email'),
          ),
          TextField(
            controller: _password,
            obscureText: true,
            enableSuggestions: false,
            decoration: InputDecoration(hintText: 'Enter Password'),
          ),
          TextButton(
              onPressed: () async {
                // await Firebase.initializeApp(
                //   options: DefaultFirebaseOptions.currentPlatform,
                // );
                final email = _email.text.trim();
                final password = _password.text;

                try {
                  final userCredential = await AuthService.firebase()
                      .logIn(email: email, password: password);
                  // print(userCredential);
                  logger.i(userCredential.toString(),
                      time: DateTime.timestamp());
                  // LoggerData.logging(
                  //     userCredential.toString(), LoggerData.info);
                  final user = AuthService.firebase().currentUser;
                  if (user?.isEmailVerified ?? false) {
                    // user email verified
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      // homeRoute,
                      notesRoute,
                      (route) => false,
                    );
                  } else {
                    // user email Not verified
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      notesRoute,
                      (route) => false,
                    );
                  }
                } on UserNotFoundAuthException {
                  // LoggerData.logging(
                  //     'No user found for that email.', LoggerData.error);
                  logger.e('No user found for that email.',
                      time: DateTime.now(), stackTrace: StackTrace.current);
                  await showErrorDialog(context, 'User not found');
                } on WrongPasswordAuthException {
                  // LoggerData.logging(
                  //     'Wrong password provided for that user.',
                  //     LoggerData.error);
                  logger.e('Wrong password provided for that user.',
                      time: DateTime.now(), stackTrace: StackTrace.current);
                  // ignore: use_build_context_synchronously
                  await showErrorDialog(context, 'Wrong password');
                } on InvalidEmailAuthException {
                  // LoggerData.logging('Tracked error', LoggerData.error);
                  logger.e('Tracked error',
                      time: DateTime.now(), stackTrace: StackTrace.current);
                  await showErrorDialog(context, 'Invalid credential');
                } on GenericAuthException {
                  await showErrorDialog(context, 'Authentication Error');
                }
              },
              child: Text('Login')),
          TextButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, registerRoute, (route) => false);
              },
              child: const Text('Not registered yet? Register here!'))
        ],
      ),
    );
  }
}
