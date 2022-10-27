import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthProvider extends ChangeNotifier {
  var auth = FirebaseAuth.instance;
  var currentUser = FirebaseAuth.instance.currentUser?.uid;
  CollectionReference ref = FirebaseFirestore.instance.collection('users');
  String message = '';
  User? user;
  String? uid;
  String? userEmail;

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

  Future<String> logout() async {
    await auth.signOut();
    return 'Berhasil Log Out';
  }
}
