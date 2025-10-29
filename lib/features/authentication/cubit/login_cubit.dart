import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:courier_delivery_app/core/helpers/cache_helper.dart';
import 'package:courier_delivery_app/features/authentication/cubit/auth_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<AuthState> {
  LoginCubit() : super(AuthInitial());

  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  Future<void> loginAccount() async {
    try {
      emit(LoginLoading());

      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );

      await saveTheDatainSharedPref();

      emit(LoginSuccess());
      log("Login success for ${email.text}");
    } on FirebaseAuthException catch (e) {
      emit(LoginError(e.code));
      log("Login error: ${e.code}");
    }
  }

  /*saveTheDatainSharedPref() async {
    String? docID = await getDocID();
    log(docID.toString());
    await FirebaseFirestore.instance
        .collection("users")
        .doc(docID)
        .get()
        .then((value) {
      log(value.data().toString());
      CacheHelper.saveData(key: "name", value: value.data()!["name"]);
      CacheHelper.saveData(key: "email", value: value.data()!["email"]);
      CacheHelper.saveData(key: "phone", value: value.data()!["phone"]);
      log("-------------------");
      log(CacheHelper.getData("name").toString());
      log("-------------------");
      log(CacheHelper.getData("email").toString());
    });
  }*/
  Future<void> saveTheDatainSharedPref() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final docSnapshot =
        await FirebaseFirestore.instance.collection("users").doc(user.uid).get();

    if (docSnapshot.exists) {
      final data = docSnapshot.data()!;
      CacheHelper.saveData(key: "id", value: data["id"]);
      CacheHelper.saveData(key: "name", value: data["name"]);
      CacheHelper.saveData(key: "email", value: data["email"]);
      CacheHelper.saveData(key: "phone", value: data["phone"]);

      log("Cached user data: ${data["name"]}");
    }
  }
  
  Future<String?> getDocID() async {
    String? docID;
    final snapshot = await FirebaseFirestore.instance
        .collection("users")
        .where("email", isEqualTo: email.text)
        .get();

    for (var doc in snapshot.docs) {
      docID = doc.id;
    }
    return docID;
  }
}
