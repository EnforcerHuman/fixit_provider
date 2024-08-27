import 'package:bloc/bloc.dart';
import 'package:fixit_provider/features/profile/data/model/booking_over_view.dart';
import 'package:fixit_provider/features/profile/domain/usecases/count_of_bookings.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'booking_summary_event.dart';
part 'booking_summary_state.dart';

class BookingSummaryBloc
    extends Bloc<BookingSummaryEvent, BookingSummaryState> {
  final CountOfBookings countOfBookings;
  BookingSummaryBloc(this.countOfBookings) : super(BookingSummaryInitial()) {
    on<LoadBookingOverview>((event, emit) async {
      await emit.forEach<BookingOverView>(
        countOfBookings.execute(),
        onData: (data) => BookingSummaryLoaded(data),
        onError: (error, stackTrace) {
          return BookingSummaryError(error.toString());
        },
      );
    });
  }
}
