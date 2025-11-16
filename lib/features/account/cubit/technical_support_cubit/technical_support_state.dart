import 'package:courier_delivery_app/features/account/data/technical_support_model.dart';

sealed class TechnicalSupportState {}

class TechnicalSupportInitial extends TechnicalSupportState {}

class TechnicalSupportLoading extends TechnicalSupportState {}

class TechnicalSupportSuccess extends TechnicalSupportState {
  final TechnicalSupportModel technicalSupportModel;

  TechnicalSupportSuccess({required this.technicalSupportModel});
}

class TechnicalSupportError extends TechnicalSupportState {
  final String message;

  TechnicalSupportError({required this.message});
}
