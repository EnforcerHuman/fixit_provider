import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fixit_provider/features/payment/data/earnings_booking_data_source.dart';
import 'package:fixit_provider/features/payment/domain/enitities/income.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'seven_days_income_event.dart';
part 'seven_days_income_state.dart';

class SevenDaysIncomeBloc
    extends Bloc<SevenDaysIncomeEvent, SevenDaysIncomeState> {
  SevenDaysIncomeBloc() : super(SevenDaysIncomeInitial()) {
    EarningsBookingDataSource earningsBookingDataSource =
        EarningsBookingDataSource(FirebaseFirestore.instance);
    on<LoadSevenDaysIncome>((event, emit) async {
      await emit.forEach<List<IncomeData>>(
        earningsBookingDataSource.getLast7CompletedBookings(event.id),
        onData: (data) => SevendaysIncomeLoaded(data),
        onError: (error, stackTrace) => SevendaysIncomeError(error.toString()),
      );
    });
  }
}
