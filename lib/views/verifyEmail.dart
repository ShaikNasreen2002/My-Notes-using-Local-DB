import 'package:flutter/material.dart';
import 'package:flutter_application/constants/logger.dart';
import 'package:flutter_application/constants/routes.dart';
import 'package:flutter_application/services/auth/auth_service.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text(
              "We've sent you an email verification. Please open it to verify your account."),
          Text(
              "If you haven't received a verification email yet, press the button below:"),
          TextButton(
              child: Text('Send email verification'),
              onPressed: () async {
                final user = AuthService.firebase().currentUser;
                logger.i('user (in verifyEmail): $user');
                // await user?.reload();
                await AuthService.firebase().sendEmailVerification();
              }),
          TextButton(
              child: Text('Restart'),
              onPressed: () async {
                await AuthService.firebase().logOut();
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(registerRoute, (route) => false);
              }),
        ],
      ),
    );
  }
}
