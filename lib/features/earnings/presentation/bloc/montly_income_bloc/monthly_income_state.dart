part of 'monthly_income_bloc.dart';

@immutable
sealed class MonthlyIncomeState {}

final class MonthlyIncomeInitial extends MonthlyIncomeState {}

final class MontlyIncomeLoaded extends MonthlyIncomeState {
  final List<FlSpot> data;

  MontlyIncomeLoaded(this.data);
}

final class MontlyIncomeErrror extends MonthlyIncomeState {
  final String error;

  MontlyIncomeErrror(this.error);
}
