import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

// class AuthUser {
//   final String id;
//   final String? email;
//   final bool isEmailVerified;
//   const AuthUser(this.id, this.email, this.isEmailVerified);
//   factory AuthUser.fromFirebase(fb.User user) => AuthUser(
//         user.uid,
//         user.email,
//         user.emailVerified,
//       );
// }

@immutable
class AuthUser {
  // final String id;
  final String? email;
  final bool isEmailVerified;
  const AuthUser({required this.email, required this.isEmailVerified});
  factory AuthUser.fromFirebase(User user) =>
      AuthUser(email: user.email, isEmailVerified: user.emailVerified);
}
