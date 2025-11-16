import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:courier_delivery_app/core/helpers/cache_helper.dart';
import 'package:courier_delivery_app/features/account/cubit/logout_cubit/logout_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogoutCubit extends Cubit<LogoutState> {
  LogoutCubit() : super(LogoutInitial());

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> logout() async {
    try {
      emit(LogoutLoading());
      await auth.signOut();
      await CacheHelper.clearData();
      emit(LogoutSuccess());
    } catch (e) {
      emit(LogoutError(e.toString()));
    }
  }
}
