// import 'package:bloc/bloc.dart';
// import 'package:fixit_provider/features/payment/domain/enitities/payment_result.dart';

// import '../../../domain/repositories/payment_repositories.dart';
// part 'payment_event.dart';
// part 'payment_state.dart';

// class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {

//   PaymentBloc(this.repository) : super(PaymentInitial()) {
//     on<PaymentEvent>((event, emit) {
//       // TODO: implement event handler
//     });

//     on<InitiatePayment>((event, emit) async {
//       emit(PaymentLoading());
//       try {
//         final result = await repository.initiatePayment();
//         switch (result.status) {
//           case PaymentStatus.success:
//             emit(PaymentSuccessful());
//             break;
//           case PaymentStatus.error:
//             emit(PaymentFailed(result.message ?? 'Payment failed'));
//             break;
//           case PaymentStatus.walletSelected:
//             emit(ExternalWalletUsed(result.message ?? 'External wallet used'));
//             break;
//         }
//       } catch (e) {
//         emit(PaymentFailed(e.toString()));
//       }
//     });
//   }
// }
