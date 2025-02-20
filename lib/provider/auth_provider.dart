import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProviderFirebase extends ChangeNotifier {
  final FirebaseAuth _fireAuth = FirebaseAuth.instance;
  User? _user;

  User? get user => _user;

  Future<void> submit(String email, String password) async {
    try {
      final userCredential = await _fireAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _user = userCredential.user;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          throw 'Email tidak terdaftar';
        case 'wrong-password':
          throw 'Password salah';
        case 'invalid-email':
          throw 'Format email tidak valid';
        default:
          throw e.message ?? 'Terjadi kesalahan';
      }
    }
  }
}
