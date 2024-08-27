import 'package:bloc/bloc.dart';
import 'package:fixit_provider/features/authentication/data/datasources/auth_local_data_source.dart';
import 'package:fixit_provider/features/earnings/data/models/monthly_overview.dart';
import 'package:fixit_provider/features/earnings/domain/usecases/montly_income.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'monthly_income_event.dart';
part 'monthly_income_state.dart';

class MonthlyIncomeBloc extends Bloc<MonthlyIncomeEvent, MonthlyIncomeState> {
  final GetMonthlyOverviewUseCase montlyIncomeUseCase;
  MonthlyIncomeBloc(this.montlyIncomeUseCase) : super(MonthlyIncomeInitial()) {
    on<LoadMontlyIncome>((event, emit) async {
      String id = await SharedPreferencesHelper.getUserId();
      try {
        await emit.forEach<List<MonthlyOverview>>(
          montlyIncomeUseCase.execute(id, 2024),
          onData: (data) => MontlyIncomeLoaded(data),
          onError: (error, stackTrace) {
            return MontlyIncomeErrror(error.toString());
          },
        );
      } catch (e) {
        emit(MontlyIncomeErrror(e.toString()));
      }
    });
  }
}
