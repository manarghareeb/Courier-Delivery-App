import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  final String id;
  final String title;
  final String body;
  final Timestamp? createdAt;
  final String userId;

  NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    this.createdAt,
    required this.userId,
  });

  factory NotificationModel.fromMap(Map<String, dynamic> map, String docId) {
    return NotificationModel(
      id: docId,
      title: map['title'] ?? '',
      body: map['body'] ?? '',
      createdAt:
          map['createdAt'] is Timestamp ? map['createdAt'] as Timestamp : null,
      userId: map['userId'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'body': body,
      'createdAt': createdAt ?? FieldValue.serverTimestamp(),
    };
  }

  NotificationModel copyWith({
    String? id,
    String? title,
    String? body,
    Timestamp? createdAt,
    String? userId,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      createdAt: createdAt ?? this.createdAt,
      userId: userId ?? this.userId,
    );
  }
}
