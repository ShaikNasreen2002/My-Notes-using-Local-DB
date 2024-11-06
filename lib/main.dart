import 'package:flutter/material.dart';
import 'constants/routes.dart';
import 'services/auth/auth_service.dart';
// import 'views/notes/new_note_view.dart';
import 'views/notes/notes_view.dart';
import 'constants/loggerWithOutput.dart';
import 'views/create_update_note_view.dart';
import 'views/loginPage.dart';
import 'views/register_page.dart';
import 'views/home_page.dart';
import 'views/verifyEmail.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter ',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const InitialPage(),
      routes: {
        loginRoute: (context) => const LoginView(title: 'Login'),
        registerRoute: (context) => const RegisterView(title: 'Register'),
        homeRoute: (context) => const HomePage(),
        verifyEmailRoute: (context) => const VerifyEmailView(),
        notesRoute: (context) => const NotesViewPage(),
        createOrUpdateNoteRoute: (context) => const CreateUpdateNoteView(),
        // newNoteRoute: (context) => const NewNoteView(),
      },
    );
  }
}

class InitialPage extends StatelessWidget {
  const InitialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AuthService.firebase().initialize(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text('Error: ${snapshot.error}')),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          logger.i('connected');
          final user = AuthService.firebase().currentUser;
          if (user != null) {
            if (user.isEmailVerified) {
              return const HomePage();
            } else {
              return const VerifyEmailView();
            }
          }
          // if (user != null && user.emailVerified) {
          //   return const HomePage();
          // }
          else {
            return const LoginView(title: 'Login');
          }
        }
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
