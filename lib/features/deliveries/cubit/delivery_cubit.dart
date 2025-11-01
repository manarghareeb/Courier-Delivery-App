import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:courier_delivery_app/features/deliveries/data/delivery_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'delivery_state.dart';

class DeliveryCubit extends Cubit<DeliveryState> {
  DeliveryCubit() : super(DeliveryInitial());

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  String? deliveryType;
  String? paymentMethod;

  void setDeliveryType(String value) {
    deliveryType = value;
    emit(DeliveryTypeSelected(value));
  }

  void setPaymentMethod(String value) {
    paymentMethod = value;
    emit(PaymentMethodSelected(value));
  }

  Future<void> addDelivery(DeliveryModel delivery) async {
    emit(DeliveryLoading());
    try {
      final userId = delivery.userId;
      final docRef = await firestore
          .collection('users')
          .doc(userId)
          .collection('deliveries')
          .add(delivery.toJson());
      final deliveryWithId = delivery.copyWith(id: docRef.id);

      await firestore
        .collection('users')
        .doc(userId)
        .collection('notifications')
        .add({
        'title': '📦 Delivery Created',
        'body': 'Your delivery is being processed and will arrive soon!',
        'createdAt': FieldValue.serverTimestamp(),
      });

      await docRef.set(deliveryWithId.toJson());
      emit(DeliverySuccess(await fetchDeliveriesByUser(userId)));
    } catch (e) {
      emit(DeliveryError('Failed to add delivery: $e'));
    }
  }

  Future<List<DeliveryModel>> fetchDeliveriesByUser(String userId) async {
    final querySnapshot =
        await firestore
            .collection('users')
            .doc(userId)
            .collection('deliveries')
            .get();

    return querySnapshot.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id;
      return DeliveryModel.fromJson(data);
    }).toList();
  }

}
