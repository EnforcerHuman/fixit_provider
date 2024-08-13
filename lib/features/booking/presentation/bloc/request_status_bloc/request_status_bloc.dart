import 'package:bloc/bloc.dart';

import 'package:fixit_provider/features/booking/domain/usecases/update_booking_status_usecases.dart';
import 'package:meta/meta.dart';

part 'request_status_event.dart';
part 'request_status_state.dart';

class RequestStatusBloc extends Bloc<RequestStatusEvent, RequestStatusState> {
  final UpdateBookingStatusUsecases bookingUseCase;
  RequestStatusBloc(this.bookingUseCase) : super(RequestStatusInitial()) {
    on<AcceptBooking>((event, emit) async {
      try {
        await bookingUseCase.acceptBooking(event.id, event.date);
        emit(RequestAccepted());
      } catch (e) {
        emit(StatusUpdateFailed());
      }
    });
    on<RejectBooking>((event, emit) async {
      try {
        await bookingUseCase.rejectBooking(event.id);
        emit(RequestAccepted());
      } catch (e) {
        emit(RequestRejected());
      }
    });
  }
}
