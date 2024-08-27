part of 'service_type_bloc.dart';

@immutable
sealed class ServiceTypeState {}

final class ServiceTypeInitial extends ServiceTypeState {}

final class ServiceTypesLoaded extends ServiceTypeState {
  final List<String> services;

  ServiceTypesLoaded(this.services);
}

final class ServiceTypeError extends ServiceTypeState {}
