// ignore_for_file: unused_field, unused_local_variable, unused_element, body_might_complete_normally_nullable
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

/// AuthBase class provides the abstraction for Authentication flow and methods in the app.
/// This class will serve to consolidate all authentication-related functions in the app and link it to Firebase Authentication service.
abstract class AuthBase {
  User? get currentUser;
  Stream<User?> authStateChanges();
  Future<User?> signInAnonmously();
  Future<User?> signInWithGoogle();
  Future<User?> signInWithEmailAndPassword(String email, String password);
  Future<User?> createUserWithEmailAndPassword(String email, String password);
  Future<void> signOut();
}

/// Auth class (or API) provides the implementation of the abstraction provided in AuthBase.
class Auth implements AuthBase {
  final _firebaseAuth = FirebaseAuth.instance;

  /// This will call Firebase's Authentication method to return a stream notification of the changes in signing state (i.e. sign-in or sign-out).
  @override
  Stream<User?> authStateChanges() => _firebaseAuth.authStateChanges();

  @override
  User? get currentUser => _firebaseAuth.currentUser;

  /// Returns a random user object generated for Anon access.
  @override
  Future<User?> signInAnonmously() async {
    final userCredential = await _firebaseAuth.signInAnonymously();
    return userCredential.user;
  }

  /// Returns an Email Credential user object generated for Email Authenticated access.
  @override
  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    final userCredential = await _firebaseAuth.signInWithCredential(
      EmailAuthProvider.credential(email: email, password: password),
    );
    return userCredential.user;
  }

  /// Returns a newly created Email Credential user object generated for Email Authenticated access.
  @override
  Future<User?> createUserWithEmailAndPassword(
      String email, String password) async {
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential.user;
  }

  /// Returns a Google Credential for Google Authenticated access.
  @override
  Future<User?> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    final googleUser = await googleSignIn.signIn();
    if (googleUser != null) {
      final googleAuth = await googleUser.authentication;
      if (googleAuth.idToken != null) {
        final userCredential = await _firebaseAuth
            .signInWithCredential(GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        ));
        return userCredential.user;
      } else {
        throw FirebaseAuthException(
          code: "ERROR_MISSING_GOOGLE_ID_TOKEN",
          message: "Missing Google ID Token",
        );
      }
    } else {
      throw FirebaseAuthException(
        code: "ERROR_ABORTED_BY_USER",
        message: "Sign in aborted by user",
      );
    }
  }

  /// A method that signs out all authenticated users, on both authentication methods; Google and Firebase (email and anon).
  @override
  Future<void> signOut() async {
    final googleSignIn = GoogleSignIn();

    await googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }
}
