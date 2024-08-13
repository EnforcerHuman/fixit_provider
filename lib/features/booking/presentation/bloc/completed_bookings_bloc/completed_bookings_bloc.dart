import 'package:bloc/bloc.dart';
import 'package:fixit_provider/features/authentication/data/datasources/auth_local_data_source.dart';
import 'package:fixit_provider/features/booking/data/model/booking_model.dart';
import 'package:fixit_provider/features/booking/domain/usecases/booking_use_case.dart';
import 'package:meta/meta.dart';

part 'completed_bookings_event.dart';
part 'completed_bookings_state.dart';

class CompletedBookingsBloc
    extends Bloc<CompletedBookingsEvent, CompletedBookingsState> {
  final BookingUseCase bookingUseCase;
  CompletedBookingsBloc(this.bookingUseCase)
      : super(CompletedBookingsInitial()) {
    on<GetCompletedBooking>((event, emit) async {
      String providerId = await SharedPreferencesHelper.getUserId();
      emit(CompletedBookingsLoading());
      try {
        await emit.forEach<List<BookingModel>>(
            bookingUseCase.getCompletedBookings(providerId),
            onData: (data) {
              return data.isNotEmpty
                  ? CompletedBookinsLoaded(data)
                  : CompletedBookingsFailed('NO BOOKINGS');
            },
            onError: (error, stackTrace) =>
                CompletedBookingsFailed(error.toString()));
      } catch (e) {
        emit(CompletedBookingsFailed(e.toString()));
      }
    });
  }
}
