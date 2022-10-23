import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthProvider extends ChangeNotifier {
  var auth = FirebaseAuth.instance;
  var currentUser = FirebaseAuth.instance.currentUser?.uid;
  CollectionReference ref = FirebaseFirestore.instance.collection('users');

  Future login(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future register(String email, String password, String name) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      await ref.doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'name': name,
        'email': email,
      });
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future logout() async {
    await auth.signOut();
  }
}
