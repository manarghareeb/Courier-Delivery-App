part of 'delivery_cubit.dart';

sealed class DeliveryState{
  const DeliveryState();
}

final class DeliveryCubitInitial extends DeliveryState {}

class DeliveryLoading extends DeliveryState {}

class DeliverySuccess extends DeliveryState {
  final List<DeliveryModel> deliveries;
  const DeliverySuccess(this.deliveries);
}

class DeliveryError extends DeliveryState {
  final String message;
  const DeliveryError(this.message);
}

class DeliveryTypeChanged extends DeliveryState {
  final String type;
  const DeliveryTypeChanged(this.type);
}

class PaymentMethodChanged extends DeliveryState {
  final String method;
  const PaymentMethodChanged(this.method);
}
