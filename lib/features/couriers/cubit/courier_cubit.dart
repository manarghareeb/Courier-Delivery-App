import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:courier_delivery_app/features/couriers/cubit/courier_state.dart';
import 'package:courier_delivery_app/features/couriers/data/courier_model.dart';
import 'package:courier_delivery_app/features/deliveries/data/delivery_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourierCubit extends Cubit<CourierState> {
  CourierCubit() : super(CourierInitial());

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  /*Future<void> addCourier(DeliveryModel courier) async {
    emit(CourierLoading());
    try {
      final userId = courier.userId;
      // generate id
      final docRef = await firestore
          .collection('users')
          .doc(userId)
          .collection('couriers')
          .add(courier.toJson());
      final courierWithId = courier.copyWith(id: docRef.id);
      // save in firestore
      await docRef.set(courierWithId.toJson());
      emit(CourierSuccess(await fetchCourierDeliveries(userId)));
    } catch (e) {
      emit(CourierError('Failed to add delivery: $e'));
    }
  }*/

  Future<void> fetchCouriers(String userId) async {
    emit(CourierLoading());
    try {
      final snapshot = await firestore
          .collection('users')
          .doc(userId)
          .collection('couriers')
          .get();

      final couriers = snapshot.docs
          .map((doc) => CourierModel.fromMap(doc.data(), doc.id))
          .toList();

      emit(CourierSuccess(couriers));
    } catch (e) {
      emit(CourierError(e.toString()));
    }
  }
  // fetch deliveries to courier
  Future<Map<String, List<DeliveryModel>>> fetchCourierDeliveries(String userId) async {
    final courierSnapshot = await firestore
        .collection('users')
        .doc(userId)
        .collection('couriers')
        .get();

    final couriers = courierSnapshot.docs
        .map((doc) => CourierModel.fromMap(doc.data(), doc.id))
        .toList();

    final Map<String, List<DeliveryModel>> courierDeliveries = {};

    for (final courier in couriers) {
      List<DeliveryModel> deliveries = [];

      for (final deliveryId in courier.assignedDeliveries) {
        final doc = await firestore
            .collection('users')
            .doc(userId)
            .collection('deliveries')
            .doc(deliveryId)
            .get();

        if (doc.exists) {
          deliveries.add(DeliveryModel.fromMap(doc.data()!, doc.id));
        }
      }
      courierDeliveries[courier.id] = deliveries;
    }
    return courierDeliveries;
  }

  Future<void> updateRating(String userId, String courierId, double rating) async {
    try {
      await firestore
          .collection('users')
          .doc(userId)
          .collection('couriers')
          .doc(courierId)
          .set({'rating': rating}, SetOptions(merge: true));

      fetchCouriers(userId);
    } catch (e) {
      emit(CourierError(e.toString()));
    }
  }

  Future<void> updateEstimatedTime(String userId, String courierId, String time) async {
    try {
      await firestore
          .collection('users')
          .doc(userId)
          .collection('couriers')
          .doc(courierId)
          .update({'estimatedTime': time});

      fetchCouriers(userId);
    } catch (e) {
      emit(CourierError(e.toString()));
    }
  }

  Future<void> assignDelivery(String userId, String courierId, String deliveryId) async {
    try {
      final docRef = firestore
          .collection('users')
          .doc(userId)
          .collection('couriers')
          .doc(courierId);

      //await docRef.update({
        //'assignedDeliveries': FieldValue.arrayUnion([deliveryId])
      //});
      await docRef.set({
        'assignedDeliveries': FieldValue.arrayUnion([deliveryId])
      }, SetOptions(merge: true));

      fetchCouriers(userId);
    } catch (e) {
      emit(CourierError(e.toString()));
    }
  }
}
