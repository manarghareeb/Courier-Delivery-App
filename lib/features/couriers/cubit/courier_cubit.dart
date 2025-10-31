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
    final docRef = firestore
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


  /// Fetch all couriers for the current user
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

  /*Future<void> addCourier(CourierModel courier) async {
    emit(CourierLoading());
    try {
      final userId = courier.id;
      final docRef = await firestore
          .collection('users')
          .doc(userId)
          .collection('couriers')
          .add(courier.());
      final courierWithId = courier.copyWith(id: docRef.id);
      await docRef.set(courierWithId.toJson());
      emit(CourierSuccess(await fetchCouriers(userId)));
    } catch (e) {
      emit(CourierError('Failed to add delivery: $e'));
    }
  }

  Future<List<CourierModel>> fetchCouriers(String userId) async {
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
    return couriers;
  }*/
  /*Future<void> addCourier({
    required String courierName,
    required double initialRating,
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

      final courierData = {
        'name': courierName,
        'rating': initialRating,
        'estimatedTime': estimatedTime,
      };
      await docRef.set(courierData);
      await fetchCouriers();
    } catch (e) {
      emit(CourierError('Failed to add courier: $e'));
    }
  }*/
  
  /// Add a courier rating
  /*Future<void> addCourierRating({
    required String courierName,
    required double rating,
    required double estimatedTime,
  }) async {
    emit(CourierLoading());
    try {
      final userId = auth.currentUser!.uid;

      final docRef = firestore
          .collection('users')
          .doc(userId)
          .collection('couriers')
          .doc(); // auto generate ID

      final courierData = {
        'name': courierName,
        'rating': rating,
        'estimatedTime': estimatedTime,
      };

      await docRef.set(courierData);

      await fetchCouriers(); // refresh list
    } catch (e) {
      emit(CourierError('Failed to add courier rating: $e'));
    }
  }
}*/

/*Future<void> updateRating(
    String userId,
    String courierId,
    double rating,
  ) async {
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
  }*/
//}
