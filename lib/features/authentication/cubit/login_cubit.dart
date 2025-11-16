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

      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
            email: email.text,
            password: password.text,
          );

      final uid = userCredential.user!.uid;

      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('notifications')
          .add({
            'title': 'Welcome back 👋',
            'body': 'Glad to see you again, ${email.text}!',
            'createdAt': FieldValue.serverTimestamp(),
          });

      final existingDeliveries = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('deliveries')
        .where('status', whereIn: ['in progress', 'delivered', 'cancelled'])
        .get();

    if (existingDeliveries.docs.isEmpty) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('deliveries')
          .add({
            'pickupLocation': 'Giza, Egypt',
            'dropOffLocation': 'Mansoura, Egypt',
            'deliveryType': 'Express',
            'totalPrice': 150.0,
            'paymentMethod': 'Online',
            'status': 'in progress',
            'userId': uid,
            'createdAt': FieldValue.serverTimestamp(),
            'packageInfo': {'weight': '300', 'size': 'Medium', 'contents': 'books'},
            'receiverInfo': {
              'name': 'Mohamed Hassan',
              'phone': '01029311009',
              'address': 'Mansoura, Egypt',
              'location': 'Mansoura, Egypt',
            },
          });

      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('deliveries')
          .add({
            'pickupLocation': 'Cairo, Egypt',
            'dropOffLocation': 'Aswan, Egypt',
            'deliveryType': 'Standard',
            'totalPrice': 90.0,
            'paymentMethod': 'Cash',
            'status': 'delivered',
            'userId': uid,
            'createdAt': FieldValue.serverTimestamp(),
            'packageInfo': {'weight': '100', 'size': 'small', 'contents': 'pens'},
            'receiverInfo': {
              'name': 'Ahmed Ali',
              'phone': '01029348769',
              'address': 'Giza, Egypt',
              'location': 'Giza, Egypt',
            },
          });

      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('deliveries')
          .add({
            'pickupLocation': 'Alexandria, Egypt',
            'dropOffLocation': 'Fayoum, Egypt',
            'deliveryType': 'Same Day',
            'totalPrice': 600.0,
            'paymentMethod': 'Card',
            'status': 'cancelled',
            'userId': uid,
            'createdAt': FieldValue.serverTimestamp(),
            'packageInfo': {'weight': '800', 'size': 'large', 'contents': 'mobiles'},
            'receiverInfo': {
              'name': 'Osama Farouk',
              'phone': '01028348001',
              'address': 'Fayoum, Egypt',
              'location': 'Fayoum, Egypt',
            },
          });
    }

      await saveTheDatainSharedPref();

      emit(LoginSuccess());
      log("Login success for ${email.text}");
    } on FirebaseAuthException catch (e) {
      emit(LoginError(e.code));
      log("Login error: ${e.code}");
    }
  }

  Future<void> saveTheDatainSharedPref() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final docSnapshot =
        await FirebaseFirestore.instance
            .collection("users")
            .doc(user.uid)
            .get();

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
    final snapshot =
        await FirebaseFirestore.instance
            .collection("users")
            .where("email", isEqualTo: email.text)
            .get();

    for (var doc in snapshot.docs) {
      docID = doc.id;
    }
    return docID;
  }
}
