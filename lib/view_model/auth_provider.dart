import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class AuthProvider extends ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseStorage storage = FirebaseStorage.instance;
  CollectionReference ref = FirebaseFirestore.instance.collection('users');
  String? photo;
  String name = '';
  String email = '';
  String message = '';
  bool isLoading = false;
  bool isHide = true;
  final imagePicker = ImagePicker();
  XFile? avatar;

  Future<String> login(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      return 'ok';
    } on FirebaseAuthException catch (e) {
      message = e.code.replaceAll("-", " ");
      notifyListeners();
      return 'fail';
    }
  }

  Future<String> register(String email, String password, String name) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      if (avatar != null) {
        File file = File(avatar!.path);
        await storage
            .ref()
            .child('profile')
            .child('${userCredential.user!.uid}.png')
            .putFile(file);
        photo = await storage
            .ref()
            .child('profile')
            .child('${userCredential.user!.uid}.png')
            .getDownloadURL();
      } else {
        photo = null;
      }
      await ref.doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'name': name,
        'email': email,
        'photoUrl': photo
      });
      avatar = null;
      notifyListeners();
      return 'ok';
    } on FirebaseAuthException catch (e) {
      message = e.code.replaceAll("-", " ");
      notifyListeners();
      return 'fail';
    }
  }

  Future<String> logout() async {
    try {
      isLoading = false;
      await auth.signOut();
      notifyListeners();
      return 'ok';
    } on FirebaseAuthException catch (e) {
      message = e.code.replaceAll("-", " ");
      notifyListeners();
      return 'fail';
    }
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
    DocumentSnapshot snapshot = await ref.doc(auth.currentUser?.uid).get();
    name = (snapshot.data() as Map<String, dynamic>)['name'];
    email = (snapshot.data() as Map<String, dynamic>)['email'];
    photo = (snapshot.data() as Map<String, dynamic>)['photoUrl'];
    isLoading = false;
    notifyListeners();
  }

  void selectImg() async {
    final check = await imagePicker.pickImage(source: ImageSource.gallery);
    if (check != null) {
      avatar = check;
    } else {
      avatar = null;
    }
    notifyListeners();
  }
}
