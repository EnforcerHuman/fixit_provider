import 'package:google_maps_flutter/google_maps_flutter.dart';

sealed class LocationState {}

final class LocationInitial extends LocationState {}

final class LocationLoaded extends LocationState {
  final LatLng position;

  LocationLoaded({required this.position});
}

final class LocationError extends LocationState {
  final String message;

  LocationError(this.message);
}

final class LocationLoading extends LocationState {}

final class LocationSelected extends LocationState {
  final LatLng selectedPosition;
  final String adress;
  LocationSelected(this.adress, {required this.selectedPosition});
}
