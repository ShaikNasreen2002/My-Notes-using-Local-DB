import 'package:flutter/material.dart';
import 'package:flutter_application/constants/routes.dart';
import 'package:flutter_application/services/auth/auth_exceptions.dart';
import 'package:flutter_application/services/auth/auth_service.dart';

import '../constants/loggerWithOutput.dart';
import '../utilities/dialogs/error_dialog.dart';
// import '../utilities/show_error_dialog.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key, required this.title});
  final String title;

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  // int _counter = 0;
  late TextEditingController _email =
      TextEditingController(); // Initialize here
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

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 7, 114, 245),
        title: Text(widget.title),
      ),
      body: Center(
          child: Column(
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
                try {
                  final email = _email.text.trim();
                  final password = _password.text;
                  final userCredential = await AuthService.firebase()
                      .createUser(email: email, password: password);
                  final user = AuthService.firebase().currentUser;
                  logger.i('user credentials after register : $user');
                  AuthService.firebase().sendEmailVerification();
                  Navigator.of(context).pushNamed(verifyEmailRoute);
                  logger.i(userCredential);
                } on WeakPasswordAuthException {
                  logger.e('The password provided is too weak.',
                      time: DateTime.now(), stackTrace: StackTrace.current);
                  await showErrorDialog(
                      context, 'The password provided is too weak.');
                } on EmailAlreadyInUseAuthExcpetion {
                  logger.e('The account already exists for that email.',
                      time: DateTime.now(), stackTrace: StackTrace.current);
                  await showErrorDialog(
                      context, 'The account already exists for that email.');
                } on GenericAuthException catch (e) {
                  logger.e(e,
                      time: DateTime.now(), stackTrace: StackTrace.current);
                  await showErrorDialog(context, e.toString());
                }
              },
              child: Text('Register Now')),
          TextButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, loginRoute, (Route<dynamic> route) => false);
              },
              child: Text('Already registered? Login here!'))
        ],
      )),
    );
  }
}
