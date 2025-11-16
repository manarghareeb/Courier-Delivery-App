import 'package:courier_delivery_app/features/deliveries/data/delivery_model.dart';

class CourierModel {
  final String id;
  final DeliveryModel deliveryId;
  final double rating;
  final double estimatedTime;

  CourierModel({
    required this.id,
    required this.deliveryId,
    required this.rating,
    required this.estimatedTime,
  });

  factory CourierModel.fromMap(Map<String, dynamic> map, String docId) {
    return CourierModel(
      id: docId,
      deliveryId: map['deliveryId'],
      rating: (map['rating']).toDouble(),
      estimatedTime: (map['estimatedTime']).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'deliveryId': deliveryId,
      'rating': rating,
      'estimatedTime': estimatedTime,
    };
  }
}
