import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  //instanse of auth
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  //instanse of firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //sing in
  Future<UserCredential> SingInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      _firestore.collection("users").doc(credential.user!.uid).set({
        "id": credential.user!.uid,
        "email": credential.user!.email,
      }, SetOptions(merge: true));
      return credential;
    } on FirebaseException catch (e) {
      throw Exception(e.code);
    }
  }

  //create user
  Future<UserCredential> SignUpWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      //after the creating user  create user document for user in the users collection
      _firestore.collection("users").doc(credential.user!.uid).set({
        "id": credential.user!.uid,
        "email": credential.user!.email,
      });
      return credential;
    } on FirebaseException catch (e) {
      throw Exception(e.code);
    }
  }

  //sing out
  Future<void> signOut() async {
    return await FirebaseAuth.instance.signOut();
  }
}
