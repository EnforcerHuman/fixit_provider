import 'package:bloc/bloc.dart';

import 'package:fixit_provider/features/earnings/data/earnings_booking_data_source.dart';
import 'package:fixit_provider/features/earnings/domain/enitities/income.dart';
import 'package:fixit_provider/features/earnings/domain/usecases/seven_days_income.dart';
import 'package:meta/meta.dart';

part 'seven_days_income_event.dart';
part 'seven_days_income_state.dart';

class SevenDaysIncomeBloc
    extends Bloc<SevenDaysIncomeEvent, SevenDaysIncomeState> {
  final EarningsBookingDataSource earningsBookingDataSource;
  final GetLast7DaysIncomeUseCase getLast7DaysIncomeUseCase;

  SevenDaysIncomeBloc({
    required this.earningsBookingDataSource,
    required this.getLast7DaysIncomeUseCase,
  }) : super(SevenDaysIncomeInitial()) {
    on<LoadSevenDaysIncome>((event, emit) async {
      try {
        await emit.forEach<List<IncomeData>>(
          getLast7DaysIncomeUseCase.execute(),
          onData: (income) {
            print('Income data: $income'); // Log income data
            return SevendaysIncomeLoaded(income);
          },
          onError: (error, stackTrace) {
            print('Error: $error');
            print('StackTrace: $stackTrace');
            return SevendaysIncomeError('Failed to load income data: $error');
          },
        );
      } catch (e, stackTrace) {
        print('Catch Error: $e');
        print('Catch StackTrace: $stackTrace');
        emit(SevendaysIncomeError('An unexpected error occurred: $e'));
      }
    });
  }
}
