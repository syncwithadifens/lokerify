import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthProvider extends ChangeNotifier {
  var auth = FirebaseAuth.instance;
  bool isLoading = false;

  Future login(String email, String password) async {
    try {
      isLoading = true;
      await auth.signInWithEmailAndPassword(email: email, password: password);
      isLoading = false;
      notifyListeners();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future register(String email, String password) async {
    try {
      isLoading = true;
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      isLoading = false;
      notifyListeners();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future logout() async {
    try {
      await auth.signOut();
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
