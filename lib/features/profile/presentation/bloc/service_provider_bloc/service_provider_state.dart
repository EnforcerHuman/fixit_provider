part of 'service_provider_bloc.dart';

@immutable
sealed class ServiceProviderDetailsState {}

final class ServiceProviderInitial extends ServiceProviderDetailsState {}

final class ServiceProviderDataLoaded extends ServiceProviderDetailsState {
  final Map<String, dynamic> serviceProvider;

  ServiceProviderDataLoaded(this.serviceProvider);
}

final class ServiceProviderDataError extends ServiceProviderDetailsState {
  final String error;

  ServiceProviderDataError(this.error);
}
