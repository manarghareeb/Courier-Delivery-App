import 'package:courier_delivery_app/features/couriers/data/courier_model.dart';

sealed class CourierState {}

class CourierInitial extends CourierState {}

class CourierLoading extends CourierState {}

class CourierSuccess extends CourierState {
  final List<CourierModel> couriers;
  CourierSuccess(this.couriers);
}

class CourierError extends CourierState {
  final String message;
  CourierError(this.message);
}