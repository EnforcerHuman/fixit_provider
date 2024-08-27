part of 'service_type_bloc.dart';

@immutable
sealed class ServiceTypeEvent {}

class LoadServices extends ServiceTypeEvent {}
