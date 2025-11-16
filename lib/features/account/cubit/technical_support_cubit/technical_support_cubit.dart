import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:courier_delivery_app/features/account/cubit/technical_support_cubit/technical_support_state.dart';
import 'package:courier_delivery_app/features/account/data/technical_support_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TechnicalSupportCubit extends Cubit<TechnicalSupportState> {
  TechnicalSupportCubit() : super(TechnicalSupportInitial());

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> addSupportMessage(TechnicalSupportModel supportMessage) async {
    emit(TechnicalSupportLoading());
    try {
      final userId = supportMessage.userId;
      await firestore
          .collection('users')
          .doc(userId)
          .collection('support')
          .add(supportMessage.toMap());

      await firestore
          .collection('users')
          .doc(userId)
          .collection('notifications')
          .add({
        'title': 'Support Message Received',
        'body':
            'Your message has been received. We will respond as soon as possible.',
        'createdAt': FieldValue.serverTimestamp(),
      });
      emit(TechnicalSupportSuccess(technicalSupportModel: supportMessage));
    } catch (e) {
      emit(TechnicalSupportError(message: 'Failed to add notification: $e'));
    }
  }
}
