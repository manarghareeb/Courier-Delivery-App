import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:courier_delivery_app/features/notifications/cubit/notification_state.dart';
import 'package:courier_delivery_app/features/notifications/data/notification_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationIntitial());

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> addNotification(NotificationModel notification) async {
    emit(NotificationLoding());
    try {
      final userId = notification.userId;
      await firestore
          .collection('users')
          .doc(userId)
          .collection('notifications')
          .add(notification.toMap());
      final notifications = await fetchNotifications(userId);
      emit(NotificationSuccess(notifications));
    } catch (e) {
      emit(NotificationError('Failed to add notification: $e'));
    }
  }

  Future<List<NotificationModel>> fetchNotifications(String userId) async {
    try {
      final snapshot = await firestore
          .collection('users')
          .doc(userId)
          .collection('notifications')
          .orderBy('createdAt', descending: true)
          .get();

      final notifications = snapshot.docs.map((doc) {
        return NotificationModel.fromMap(doc.data(), doc.id);
      }).toList();

      emit(NotificationSuccess(notifications));
      return notifications;
    } catch (e) {
      emit(NotificationError('Failed to fetch notifications: $e'));
      return [];
    }
  }
}
