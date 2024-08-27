import 'package:bloc/bloc.dart';
import 'package:fixit_provider/features/booking/data/model/booking_model.dart';
import 'package:fixit_provider/features/booking/domain/usecases/booking_use_case.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'upcoming_bookings_event.dart';
part 'upcoming_bookings_state.dart';

class UpcomingBookingsBloc
    extends Bloc<UpcomingBookingsEvent, UpcomingBookingsState> {
  final BookingUseCase bookingUseCase;
  UpcomingBookingsBloc(this.bookingUseCase) : super(UpcomingBookingsInitial()) {
    on<UpcomingBookingsEvent>((event, emit) async {});
    on<GetUpcomingBookings>((event, emit) async {
      try {
        await emit.forEach<List<BookingModel>>(
            bookingUseCase.getAcceptedBooking(event.date, event.id),
            onData: (data) => UpcomingBookingLoaded(data));
      } catch (e) {
        emit(UpcomingBookingError());
      }
    });
  }
}
