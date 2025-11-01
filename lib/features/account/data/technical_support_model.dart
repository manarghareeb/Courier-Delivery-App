import 'package:cloud_firestore/cloud_firestore.dart';

class TechnicalSupportModel {
  final String id;
  final String message;
  final Timestamp? createdAt;
  final String userId;

  TechnicalSupportModel({required this.id, required this.userId, required this.message, this.createdAt,});

  factory TechnicalSupportModel.fromMap(Map<String, dynamic> map, String docId) {
    return TechnicalSupportModel(
      id: docId,
      message: map['message'] ?? '',
      createdAt:
          map['createdAt'] is Timestamp ? map['createdAt'] as Timestamp : null,
      userId: map['userId'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'message': message,
      'createdAt': createdAt ?? FieldValue.serverTimestamp(),
    };
  }
}
