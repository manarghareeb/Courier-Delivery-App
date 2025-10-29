import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:courier_delivery_app/core/helpers/cache_helper.dart';
import 'package:courier_delivery_app/features/account/cubit/account_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountCubit extends Cubit<AccountState> {
  AccountCubit() : super(AccountInitial());

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> logout() async {
    try {
      emit(AccountLogoutLoading());
      await auth.signOut();
      await CacheHelper.clearData();
      emit(AccountLogoutSuccess());
    } catch (e) {
      emit(AccountLogoutError(e.toString()));
    }
  }

  Future<void> updateUserData({
    required String name,
    required String phone,
    String? newEmail,
    String? newPassword,
  }) async {
    try {
      emit(AccountUpdateLoading());
      final user = auth.currentUser;
      if (user == null) throw Exception("User not logged in");

      await firestore.collection("users").doc(user.uid).update({
        'name': name,
        'phone': phone,
        if (newEmail != null && newEmail.isNotEmpty) 'email': newEmail,
        if (newPassword != null && newPassword.isNotEmpty) 'password': newPassword,
      });

      emit(AccountUpdateSuccess());
    } catch (e) {
      emit(AccountUpdateError(e.toString()));
    }
  }
}
