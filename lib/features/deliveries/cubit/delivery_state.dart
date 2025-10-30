part of 'delivery_cubit.dart';

sealed class DeliveryState{
  const DeliveryState();
}

class DeliveryInitial extends DeliveryState {}
class DeliveryLoading extends DeliveryState {}
class DeliverySuccess extends DeliveryState {
  final List<DeliveryModel> deliveries;
  const DeliverySuccess(this.deliveries);
}
class DeliveryError extends DeliveryState {
  final String message;
  DeliveryError(this.message);
}
class DeliveryTypeSelected extends DeliveryState {
  final String type;
  DeliveryTypeSelected(this.type);
}
class PaymentMethodSelected extends DeliveryState {
  final String method;
  PaymentMethodSelected(this.method);
}

