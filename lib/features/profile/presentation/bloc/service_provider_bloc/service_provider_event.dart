part of 'service_provider_bloc.dart';

@immutable
sealed class ServiceProviderEvent {}

final class GetServiceProviderData extends ServiceProviderEvent {}
