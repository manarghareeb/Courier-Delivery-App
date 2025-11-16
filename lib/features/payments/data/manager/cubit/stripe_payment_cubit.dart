import 'package:courier_delivery_app/features/payments/data/models/payment_intent_input_model.dart';
import 'package:courier_delivery_app/features/payments/data/repos/payment_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'stripe_payment_state.dart';

class StripePaymentCubit extends Cubit<StripePaymentState> {
  StripePaymentCubit(this.paymentRepo) : super(StripePaymentInitial());
  final PaymentRepo paymentRepo;

  Future makePayment(
      {required PaymentIntentInputModel paymentIntentInputModel}) async {
    emit(StripePaymentLoading());
    var data = await paymentRepo.makePayment(
        paymentIntentInputModel: paymentIntentInputModel);
    data.fold((l) {
      emit(StripePaymentFailure(error: l.error));
    }, (r) {
      emit(StripePaymentSuccess());
    });
  }
}
