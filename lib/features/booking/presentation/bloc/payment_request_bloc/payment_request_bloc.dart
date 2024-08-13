import 'package:bloc/bloc.dart';
import 'package:fixit_provider/features/booking/domain/usecases/update_booking_status_usecases.dart';
import 'package:meta/meta.dart';

part 'payment_request_event.dart';
part 'payment_request_state.dart';

class PaymentRequestBloc
    extends Bloc<PaymentRequestEvent, PaymentRequestState> {
  final UpdateBookingStatusUsecases bookingStatusUsecases;
  PaymentRequestBloc(this.bookingStatusUsecases)
      : super(PaymentRequestInitial()) {
    on<RequestPayment>((event, emit) async {
      try {
        await bookingStatusUsecases.requestPayment(event.id, event.amount);
        emit(PaymentRequested());
      } catch (e) {
        emit(PaymentRequestFailed());
      }
    });
  }
}
