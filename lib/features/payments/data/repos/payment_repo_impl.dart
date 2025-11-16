import 'package:courier_delivery_app/core/errors/failures.dart';
import 'package:courier_delivery_app/core/services/stripe_service.dart';
import 'package:courier_delivery_app/features/payments/data/models/payment_intent_input_model.dart';
import 'package:courier_delivery_app/features/payments/data/repos/payment_repo.dart';
import 'package:dartz/dartz.dart';

class PaymentRepoImpl extends PaymentRepo {
  @override
  Future<Either<Failures, void>> makePayment(
      {required PaymentIntentInputModel paymentIntentInputModel}) async {
    final StripeService stripeService = StripeService();
    try {
      await stripeService.makePayment(
          paymentIntentInputModel: paymentIntentInputModel);
      return right(null);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
