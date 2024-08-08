import 'package:bloc/bloc.dart';
import 'package:fixit_provider/features/booking/data/model/booking_model.dart';
import 'package:fixit_provider/features/booking/domain/usecases/booking_use_case.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'cancelled_bookings_event.dart';
part 'cancelled_bookings_state.dart';

class CancelledBookingsBloc
    extends Bloc<CancelledBookingsEvent, CancelledBookingsState> {
  final BookingUseCase bookingUseCase;
  CancelledBookingsBloc(this.bookingUseCase)
      : super(CancelledBookingsInitial()) {
    on<CancelledBookingsEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<GetCancelledBookings>((event, emit) async {
      //
      try {
        await emit.forEach<List<BookingModel>>(
            bookingUseCase.getRejectedBookings(event.id),
            onData: (data) => CancelledBookingsLoaded(data),
            onError: (error, stacktree) =>
                CancelledBookingError(error.toString()));
      } catch (e) {
        emit(CancelledBookingError(e.toString()));
      }
    });
  }
}
