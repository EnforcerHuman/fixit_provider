import 'package:fixit_provider/features/authentication/presentation/widgets/location_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Widget buildLocation(BuildContext context, LatLng initialPosition) {
  return Container(
    height: 300,
    width: MediaQuery.of(context).size.width - 50,
    color: Colors.blue,
    child: LocationWidget(
      initialLocation: initialPosition,
    ),
  );
}
