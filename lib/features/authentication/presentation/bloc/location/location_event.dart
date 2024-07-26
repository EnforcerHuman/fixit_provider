import 'package:google_maps_flutter/google_maps_flutter.dart';

sealed class LocationEvent {}

class GetLocationEvent extends LocationEvent {}

class SelectLocationEvent extends LocationEvent {
  final LatLng position;
  final String adress;
  SelectLocationEvent(this.position, this.adress);
}
