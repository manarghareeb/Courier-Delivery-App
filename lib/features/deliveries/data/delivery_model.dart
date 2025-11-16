import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:courier_delivery_app/features/deliveries/data/package_info.dart';
import 'package:courier_delivery_app/features/deliveries/data/receiver_info.dart';

class DeliveryModel {
  final String id;
  final String pickupLocation;
  final String dropOffLocation;
  final String deliveryType;
  final double totalPrice;
  final String courierId;
  final String paymentMethod;
  final String status;
  final String userId;
  final Timestamp? createdAt;

  final PackageInfo packageInfo;
  final ReceiverInfo receiverInfo;

  DeliveryModel({
    required this.id,
    required this.pickupLocation,
    required this.dropOffLocation,
    required this.deliveryType,
    required this.totalPrice,
    required this.courierId,
    required this.paymentMethod,
    required this.status,
    required this.userId,
    required this.packageInfo,
    required this.receiverInfo,
    this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'pickupLocation': pickupLocation,
      'dropOffLocation': dropOffLocation,
      'deliveryType': deliveryType,
      'totalPrice': totalPrice,
      'courierId': courierId,
      'paymentMethod': paymentMethod,
      'status': status,
      'userId': userId,
      'createdAt': createdAt ?? FieldValue.serverTimestamp(),
      'packageInfo': packageInfo.toJson(),
      'receiverInfo': receiverInfo.toJson(),
    };
  }

  factory DeliveryModel.fromJson(Map<String, dynamic> json) {
    return DeliveryModel(
      id: json['id'] ?? '',
      pickupLocation: json['pickupLocation'] ?? '',
      dropOffLocation: json['dropOffLocation'] ?? '',
      deliveryType: json['deliveryType'] ?? '',
      totalPrice: (json['totalPrice'] ?? 0).toDouble(),
      courierId: json['courierId'] ?? '',
      paymentMethod: json['paymentMethod'] ?? '',
      status: json['status'] ?? 'pending',
      userId: json['userId'] ?? '',
      createdAt: json['createdAt'],
      packageInfo: PackageInfo.fromJson(json['packageInfo'] ?? {}),
      receiverInfo: ReceiverInfo.fromJson(json['receiverInfo'] ?? {}),
    );
  }

  DeliveryModel copyWith({
    String? id,
    String? pickupLocation,
    String? dropOffLocation,
    String? deliveryType,
    String? paymentMethod,
    double? totalPrice,
    String? userId,
    PackageInfo? packageInfo,
    ReceiverInfo? receiverInfo,
    String? courierId,
    String? status,
    Timestamp? createdAt,
  }) {
    return DeliveryModel(
      id: id ?? this.id,
      packageInfo: packageInfo ?? this.packageInfo,
      receiverInfo: receiverInfo ?? this.receiverInfo,
      deliveryType: deliveryType ?? this.deliveryType,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      totalPrice: totalPrice ?? this.totalPrice,
      userId: userId ?? this.userId,
      pickupLocation: pickupLocation ?? this.pickupLocation,
      dropOffLocation: dropOffLocation ?? this.dropOffLocation,
      courierId: courierId ?? this.courierId,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory DeliveryModel.fromMap(Map<String, dynamic> map, String docId) {
    return DeliveryModel(
      id: docId,
      pickupLocation: map['pickupLocation'] ?? '',
      dropOffLocation: map['dropOffLocation'] ?? '',
      deliveryType: map['deliveryType'] ?? '',
      totalPrice: (map['totalPrice'] ?? 0).toDouble(),
      courierId: map['courierId'] ?? '',
      paymentMethod: map['paymentMethod'] ?? '',
      status: map['status'] ?? 'pending',
      userId: map['userId'] ?? '',
      createdAt:
          map['createdAt'] is Timestamp ? map['createdAt'] as Timestamp : null,
      packageInfo: map['packageInfo'] != null
          ? PackageInfo.fromJson(Map<String, dynamic>.from(map['packageInfo']))
          : PackageInfo(weight: '', size: '', contents: ''),
      receiverInfo: map['receiverInfo'] != null
          ? ReceiverInfo.fromJson(
              Map<String, dynamic>.from(map['receiverInfo']))
          : ReceiverInfo(name: '', phone: '', address: '', location: ''),
    );
  }
}
