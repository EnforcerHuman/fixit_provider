import 'package:fixit_provider/features/authentication/data/model/service_provider_model.dart';

abstract class ServiceProviderState {}

class ServiceProviderInitial extends ServiceProviderState {}

class ServiceProviderLoading extends ServiceProviderState {}

class ServiceProviderLoaded extends ServiceProviderState {
  final ServiceProvider serviceProvider;

  ServiceProviderLoaded(this.serviceProvider);
}

class ServiceProviderError extends ServiceProviderState {
  final String message;

  ServiceProviderError(this.message);
}

class ServiceProviderCreated extends ServiceProviderState {}

class ServiceProviderCreating extends ServiceProviderState {}
