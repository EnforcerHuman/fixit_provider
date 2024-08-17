import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'monthly_income_event.dart';
part 'monthly_income_state.dart';

class MonthlyIncomeBloc extends Bloc<MonthlyIncomeEvent, MonthlyIncomeState> {
  MonthlyIncomeBloc() : super(MonthlyIncomeInitial()) {
    on<MonthlyIncomeEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
