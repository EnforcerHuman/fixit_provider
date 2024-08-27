part of 'daily_income_bloc.dart';

@immutable
sealed class DailyIncomeState {}

final class DailyIncomeInitial extends DailyIncomeState {}

class DailyIncomeLoaded extends DailyIncomeState {
  final DailyBooking dailyBooking;

  DailyIncomeLoaded(this.dailyBooking);
}

class DailyIncomeLoading extends DailyIncomeState {}

class DailyIncomeError extends DailyIncomeState {}
