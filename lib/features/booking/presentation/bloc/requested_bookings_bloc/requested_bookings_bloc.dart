import 'package:bloc/bloc.dart';
import 'package:fixit_provider/features/authentication/data/datasources/auth_local_data_source.dart';
import 'package:fixit_provider/features/booking/data/model/booking_model.dart';
import 'package:fixit_provider/features/booking/domain/usecases/booking_use_case.dart';

import 'package:meta/meta.dart';

part 'requested_bookings_event.dart';
part 'requested_bookings_state.dart';

class RequestedBookingsBloc
    extends Bloc<RequestedBookingsEvent, RequestedBookingsState> {
  final BookingUseCase bookingUseCase;
  RequestedBookingsBloc(this.bookingUseCase)
      : super(RequestedBookingsInitial()) {
    on<RequestedBookingsEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<GetRequestedBooking>((event, emit) async {
      //handle the getrequestd booking event
      String providerId = await SharedPreferencesHelper.getUserId();
      print('PROCESS STATED');
      try {
        await emit.forEach<List<BookingModel>>(
            bookingUseCase.getPendingBooking(providerId),
            onData: (data) => RequestedBookingLoaded(data),
            onError: (error, stackTrace) =>
                RequestedBookingError(error.toString()));
      } catch (e) {
        emit(RequestedBookingError(e.toString()));
      }
    });
  }
}
