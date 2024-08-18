import 'package:bloc/bloc.dart';
import 'package:fixit_provider/features/earnings/domain/usecases/montly_income.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:meta/meta.dart';

part 'monthly_income_event.dart';
part 'monthly_income_state.dart';

class MonthlyIncomeBloc extends Bloc<MonthlyIncomeEvent, MonthlyIncomeState> {
  final MontlyIncomeUseCase montlyIncomeUseCase;
  MonthlyIncomeBloc(this.montlyIncomeUseCase) : super(MonthlyIncomeInitial()) {
    on<MonthlyIncomeEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<LoadMontlyIncome>((event, emit) async {
      try {
        await emit.forEach<List<FlSpot>>(
          montlyIncomeUseCase.getMonthlyIncomeData(),
          onData: (data) => MontlyIncomeLoaded(data),
          onError: (error, stackTrace) {
            return MontlyIncomeErrror(error.toString());
          },
        );
      } catch (e) {}
    });
  }
}
