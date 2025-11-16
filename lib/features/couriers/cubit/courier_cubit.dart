import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:courier_delivery_app/features/couriers/cubit/courier_state.dart';
import 'package:courier_delivery_app/features/couriers/data/courier_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourierCubit extends Cubit<CourierState> {
  CourierCubit() : super(CourierInitial());

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> addCourier({
    required String deliveryId,
    required double rating,
    required double estimatedTime,
  }) async {
    emit(CourierLoading());
    try {
      final userId = auth.currentUser!.uid;
      final docRef =
          firestore
              .collection('users')
              .doc(userId)
              .collection('couriers')
              .doc();

      await docRef.set({
        'deliveryId': deliveryId,
        'rating': rating,
        'estimatedTime': estimatedTime,
      });

      await fetchCouriers();
    } catch (e) {
      emit(CourierError('Failed to add courier: $e'));
    }
  }

  Future<void> fetchCouriers() async {
    emit(CourierLoading());
    try {
      final userId = auth.currentUser!.uid;
      final snapshot =
          await firestore
              .collection('users')
              .doc(userId)
              .collection('couriers')
              .get();

      final couriers =
          snapshot.docs
              .map((doc) => CourierModel.fromMap(doc.data(), doc.id))
              .toList();

      emit(CourierSuccess(couriers));
    } catch (e) {
      emit(CourierError('Failed to fetch couriers: $e'));
    }
  }
}
