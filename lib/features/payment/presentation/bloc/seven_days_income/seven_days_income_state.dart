part of 'seven_days_income_bloc.dart';

@immutable
sealed class SevenDaysIncomeState {}

final class SevenDaysIncomeInitial extends SevenDaysIncomeState {}

final class SevendaysIncomeLoaded extends SevenDaysIncomeState {
  final List<IncomeData> income;

  SevendaysIncomeLoaded(this.income);
}

final class SevendaysIncomeError extends SevenDaysIncomeState {
  final String error;

  SevendaysIncomeError(this.error);
}
