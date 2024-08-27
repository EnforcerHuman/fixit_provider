part of 'daily_income_bloc.dart';

@immutable
sealed class DailyIncomeEvent {}

class LoadDailyIncome extends DailyIncomeEvent {
  final String date;

  LoadDailyIncome(this.date);
}
