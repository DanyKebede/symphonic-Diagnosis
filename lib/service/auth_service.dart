import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static final _auth = FirebaseAuth.instance;
// Sign in with Google
  static Future<void> googleSignin() async {
    try {
      GoogleAuthProvider googleAuthProvider = GoogleAuthProvider();
      _auth.signInWithProvider(googleAuthProvider);
    } on FirebaseException catch (e) {
      throw e.code;
    } catch (e) {
      throw e.toString();
    }
  }

// register with email and password service
  static Future<UserCredential> signUp(String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseException catch (e) {
      throw e.code;
    } catch (e) {
      throw 'Something went wrong while registering user';
    }
  }
}
