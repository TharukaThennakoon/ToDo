import 'package:daypilot/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  UserModel? _userFromFirebaseUser(User? user) {
    return user != null ? UserModel(uid: user.uid) : null;
  }

  // Auth state stream
  Stream<UserModel?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  // Email & Password Sign In
  Future<UserModel?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return _userFromFirebaseUser(result.user);
    } on FirebaseAuthException catch (e) {
      print('Sign in error [${e.code}]: ${e.message}');
      rethrow; // rethrow so the UI can show the real error
    }
  }

  // Email & Password Sign Up
  Future<UserModel?> signUpWithEmailAndPassword(
    String email,
    String password,
    String name,
  ) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Save display name to Firebase profile
      await result.user?.updateDisplayName(name);
      await result.user?.reload();
      return _userFromFirebaseUser(result.user);
    } on FirebaseAuthException catch (e) {
      print('Sign up error [${e.code}]: ${e.message}');
      rethrow;
    }
  }

  // Google Sign In (works for both login and signup)
  Future<UserModel?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      // User cancelled the sign-in dialog
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential result = await _auth.signInWithCredential(credential);
      return _userFromFirebaseUser(result.user);
    } on FirebaseAuthException catch (e) {
      print('Google sign-in error [${e.code}]: ${e.message}');
      rethrow;
    } catch (e) {
      print('Google sign-in unexpected error: $e');
      rethrow;
    }
  }

  // Sign Out
  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut(); // also clear Google session
      await _auth.signOut();
    } catch (e) {
      print('Sign out error: $e');
    }
  }
}
