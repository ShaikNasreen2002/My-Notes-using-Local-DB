// import 'package:firebase_auth/firebase_auth.dart';
// import '../models/user_model.dart';

// class FirebaseAuthProvider {
//   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

//   Future<UserModel?> getCurrentUser() async {
//     final user = _firebaseAuth.currentUser;
//     if (user != null) {
//       return UserModel(
//           uid: user.uid, email: user.email!, emailVerified: user.emailVerified);
//     }
//     return null;
//   }
// }
