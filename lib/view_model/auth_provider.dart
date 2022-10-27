import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthProvider extends ChangeNotifier {
  var auth = FirebaseAuth.instance;
  CollectionReference ref = FirebaseFirestore.instance.collection('users');
  String name = '';
  String message = '';
  User? user;
  String? uid;
  String? userEmail;
  bool isLoading = false;
  bool isHide = true;

  Future<User?> login(String email, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
      if (user != null) {
        uid = user?.uid;
        userEmail = user?.email;
      }
    } on FirebaseAuthException catch (e) {
      message = e.code.replaceAll("-", " ");
      notifyListeners();
    }
    return user;
  }

  Future<String> register(String email, String password, String name) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      await ref.doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'name': name,
        'email': email,
      });
      return 'ok';
    } on FirebaseAuthException catch (e) {
      message = e.code.replaceAll("-", " ");
      notifyListeners();
      return 'fail';
    }
  }

  Future<void> logout() async {
    await auth.signOut();
    isLoading = false;
  }

  void showPassword() {
    isHide = !isHide;
    notifyListeners();
  }

  void showLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  void getUser() async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();
    name = (snapshot.data() as Map<String, dynamic>)['name'];
    notifyListeners();
  }
}
