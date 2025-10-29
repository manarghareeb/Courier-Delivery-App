import 'package:courier_delivery_app/features/deliveries/data/package_info.dart';
import 'package:courier_delivery_app/features/deliveries/data/receiver_info.dart';

class DeliveryModel {
  final String id;
  final PackageInfo packageInfo;
  final ReceiverInfo receiverInfo;
  final String deliveryType;
  final String paymentMethod;
  final double price;
  final String userId;

  DeliveryModel({
    required this.id,
    required this.packageInfo,
    required this.receiverInfo,
    required this.deliveryType,
    required this.paymentMethod,
    required this.price,
    required this.userId,
  });

  factory DeliveryModel.fromJson(Map<String, dynamic> json) {
    return DeliveryModel(
      id: json['id'],
      packageInfo: PackageInfo.fromJson(json['packageInfo']),
      receiverInfo: ReceiverInfo.fromJson(json['receiverInfo']),
      deliveryType: json['deliveryType'],
      paymentMethod: json['paymentMethod'],
      price: json['price'].toDouble(),
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'packageInfo': packageInfo.toJson(),
      'receiverInfo': receiverInfo.toJson(),
      'deliveryType': deliveryType,
      'paymentMethod': paymentMethod,
      'price': price,
      'userId': userId,
    };
  }

  DeliveryModel copyWith({
    String? id,
    PackageInfo? packageInfo,
    ReceiverInfo? receiverInfo,
    String? deliveryType,
    String? paymentMethod,
    double? price,
    String? userId,
  }) {
    return DeliveryModel(
      id: id ?? this.id,
      packageInfo: packageInfo ?? this.packageInfo,
      receiverInfo: receiverInfo ?? this.receiverInfo,
      deliveryType: deliveryType ?? this.deliveryType,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      price: price ?? this.price,
      userId: userId ?? this.userId,
    );
  }
}
