import 'package:courier_delivery_app/core/errors/failures.dart';
import 'package:courier_delivery_app/features/payments/data/models/payment_intent_input_model.dart';
import 'package:dartz/dartz.dart';

abstract class PaymentRepo {
  Future<Either<Failures, void>> makePayment(
      {required PaymentIntentInputModel paymentIntentInputModel});
}
