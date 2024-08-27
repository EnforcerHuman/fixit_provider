import 'package:bloc/bloc.dart';
import 'package:fixit_provider/features/earnings/data/models/day_booking.dart';
import 'package:fixit_provider/features/earnings/domain/usecases/daily_booking.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'daily_income_event.dart';
part 'daily_income_state.dart';

class DailyIncomeBloc extends Bloc<DailyIncomeEvent, DailyIncomeState> {
  final GetDailyBookingOverviewUseCase _getDailyBookingOverviewUseCase;
  DailyIncomeBloc(this._getDailyBookingOverviewUseCase)
      : super(DailyIncomeInitial()) {
    on<LoadDailyIncome>((event, emit) async {
      try {
        // Await the result from the use case
        final data = await _getDailyBookingOverviewUseCase.call(event.date);
        // Emit the loaded state with the data
        emit(DailyIncomeLoaded(data));
      } catch (e) {
        // Print or log the error for debugging purposes
        // Emit an error state
        emit(DailyIncomeError());
      }
    });
  }
}
