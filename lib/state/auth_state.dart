import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthState extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;
  bool isLoading = true;
  String? errorMessage;

  AuthState() {
    _auth.authStateChanges().listen((user) {
      this.user = user;
      isLoading = false;
      notifyListeners();
    });
  }

  Future<void> signIn(String email, String password) async {
    errorMessage = null;
    isLoading = true;
    notifyListeners();

    try {
      final credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      user = credential.user;
    } on FirebaseAuthException catch (error) {
      errorMessage = error.message;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> register(String email, String password) async {
    errorMessage = null;
    isLoading = true;
    notifyListeners();

    try {
      final credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      user = credential.user;
    } on FirebaseAuthException catch (error) {
      errorMessage = error.message;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    user = null;
    notifyListeners();
  }

  void setError(String? value) {
    errorMessage = value;
    notifyListeners();
  }
}
