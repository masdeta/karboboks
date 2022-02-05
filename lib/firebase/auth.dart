import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  static Stream<User?> userStream = FirebaseAuth.instance.authStateChanges();

  static Future<bool> googleLogin() async {
    try {
      final googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) return false;

      final googleAuth = await googleUser.authentication;
      final authCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(authCredential);
      return true;
    } on FirebaseAuthException catch (e) {
      AlertDialog(
        title: const Text("Error"),
        content: Text('Failed to sign in with Google: $e.message'),
      );
      return false;
    }
  }

  static Future<String?> signin(email, password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'Tidak ada pengguna yang ditemukan untuk email $email!';
      } else if (e.code == 'wrong-password') {
        return 'Kata sandi salah!';
      }
    } catch (e) {
      return 'Login gagal!';
    }
  }

  static Future<String?> register(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'Akun untuk email $email sudah terdaftar!';
      }
    } catch (e) {
      return 'Registrasi gagal!';
    }
  }

  static Future<void> signOut() async {
    await GoogleSignIn().disconnect();
    await FirebaseAuth.instance.signOut();
  }
}
