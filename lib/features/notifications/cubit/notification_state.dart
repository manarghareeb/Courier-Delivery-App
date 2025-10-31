import 'package:courier_delivery_app/features/notifications/data/notification_model.dart';

sealed class NotificationState {}

class NotificationIntitial extends NotificationState {}

class NotificationLoding extends NotificationState {}

class NotificationSuccess extends NotificationState {
  final List<NotificationModel> notifications;

  NotificationSuccess(this.notifications);
}

class NotificationError extends NotificationState {
  final String message;

  NotificationError(this.message);
}
