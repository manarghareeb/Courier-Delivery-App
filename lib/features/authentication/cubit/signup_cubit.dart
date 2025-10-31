import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:courier_delivery_app/features/authentication/cubit/auth_state.dart';
import 'package:courier_delivery_app/features/authentication/data/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupCubit extends Cubit<AuthState> {
  SignupCubit() : super(AuthInitial());

  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController phone = TextEditingController();

  final CollectionReference users =
    FirebaseFirestore.instance.collection("users");

  Future<void> signupAccount() async {
    try {
      emit(SignUpLoading());

      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );

      final uid = userCredential.user!.uid;

      final userModel = UserModel(
        id: uid,
        name: name.text,
        email: email.text,
        phone: phone.text,
        password: password.text,
      );

      await users.doc(uid).set(userModel.toMap());

      await users.doc(uid).collection('notifications').add({
        'title': 'Welcome 🎉',
        'body': 'Thanks for joining us, ${name.text}!',
        'createdAt': FieldValue.serverTimestamp(),
      });

      emit(SignUpSuccess());
      log("Account created successfully for ${email.text}");
    } on FirebaseAuthException catch (e) {
      emit(SignUpError(e.code));
      log("Signup error: ${e.code}");
    }
  }
}
