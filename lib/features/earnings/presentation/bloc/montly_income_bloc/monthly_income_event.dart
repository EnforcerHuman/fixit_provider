part of 'monthly_income_bloc.dart';

@immutable
sealed class MonthlyIncomeEvent {}

final class LoadMontlyIncome extends MonthlyIncomeEvent {}
