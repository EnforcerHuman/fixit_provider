import 'package:fixit_provider/features/authentication/presentation/bloc/location/location_bloc.dart';
import 'package:fixit_provider/features/authentication/presentation/bloc/location/location_event.dart';
import 'package:fixit_provider/features/authentication/presentation/bloc/location/location_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationWidget extends StatelessWidget {
  const LocationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationBloc, LocationState>(
      builder: (context, state) {
        if (state is LocationInitial) {
          BlocProvider.of<LocationBloc>(context).add(GetLocationEvent());
          return Center(child: Text('Getting location...'));
        } else if (state is LocationLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is LocationLoaded || state is LocationSelected) {
          LatLng position;
          if (state is LocationLoaded) {
            position = state.position;
          } else {
            position = (state as LocationSelected).selectedPosition;
          }
          return GoogleMap(
            initialCameraPosition: CameraPosition(
              target: position,
              zoom: 14,
            ),
            markers: {
              Marker(
                markerId: MarkerId('selected-location'),
                position: position,
              ),
            },
            onMapCreated: (GoogleMapController controller) {
              // Handle controller if needed
            },
            onTap: (LatLng tappedPosition) async {
              List<Placemark> placemarks = await placemarkFromCoordinates(
                  tappedPosition.latitude, tappedPosition.longitude);
              print(placemarks);
              // ignore: use_build_context_synchronously
              BlocProvider.of<LocationBloc>(context).add(SelectLocationEvent(
                  tappedPosition,
                  '${placemarks.first.name},${placemarks.first.thoroughfare},${placemarks.first.locality},${placemarks.first.street} ,${placemarks.first.postalCode}'));
            },
          );
        } else if (state is LocationError) {
          return Center(child: Text('Error: ${state.message}'));
        }
        return Container();
      },
    );
  }
}
