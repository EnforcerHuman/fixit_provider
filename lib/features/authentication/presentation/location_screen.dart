// import 'package:fixit_provider/features/authentication/data/datasources/auth_remote_data_source.dart';
// import 'package:fixit_provider/features/authentication/domain/usecases/sign_up.dart';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:geolocator/geolocator.dart';

// class LocationScreen extends StatefulWidget {
//   @override
//   _LocationScreenState createState() => _LocationScreenState();
// }

// class _LocationScreenState extends State<LocationScreen> {
//   late GoogleMapController myController;
//   LatLng _currentPosition = LatLng(0, 0);
//   bool showMap = false;
//   bool _isLoading = false;
//   String _errorMessage = '';

//   @override
//   void initState() {
//     super.initState();
//     _getCurrentLocation();
//   }

//   void _onMapCreated(GoogleMapController controller) {
//     myController = controller;
//   }

//   Future<void> _getCurrentLocation() async {
//     setState(() {
//       _isLoading = true;
//       _errorMessage = '';
//     });

//     try {
//       bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//       if (!serviceEnabled) {
//         throw Exception('Location services are disabled.');
//       }

//       LocationPermission permission = await Geolocator.checkPermission();
//       if (permission == LocationPermission.denied) {
//         permission = await Geolocator.requestPermission();
//         if (permission == LocationPermission.denied) {
//           throw Exception('Location permissions are denied');
//         }
//       }

//       if (permission == LocationPermission.deniedForever) {
//         throw Exception('Location permissions are permanently denied');
//       }

//       Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high,
//       );

//       setState(() {
//         _currentPosition = LatLng(position.latitude, position.longitude);
//         showMap = true;
//       });
//     } catch (e) {
//       setState(() {
//         _errorMessage = e.toString();
//       });
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     AuthRemoteDataSource remoteDataSource = AuthRemoteDataSource();
//     SignUpUseCase signup = SignUpUseCase(remoteDataSource);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Flutter Maps Demo'),
//         backgroundColor: Colors.green,
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             if (_isLoading)
//               CircularProgressIndicator()
//             else if (_errorMessage.isNotEmpty)
//               Text(_errorMessage, style: TextStyle(color: Colors.red))
//             else if (showMap)
//               Expanded(
//                 child: GoogleMap(
//                   onMapCreated: _onMapCreated,
//                   initialCameraPosition: CameraPosition(
//                     target: _currentPosition,
//                     zoom: 15.0,
//                   ),
//                   myLocationEnabled: true,
//                   myLocationButtonEnabled: false,
//                 ),
//               )
//             else
//               Text('Map not shown. This should not happen.'),
//             ElevatedButton(
//               onPressed: () async {
//                 final test = await signup.signUp(
//                     "melbin123@gmail.com", 'qwerty@123', '6282431089');
//               },
//               child: Text('Refresh Location'),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _getCurrentLocation,
//         materialTapTargetSize: MaterialTapTargetSize.padded,
//         backgroundColor: Colors.green,
//         child: const Icon(Icons.my_location, size: 30.0),
//       ),
//     );
//   }
// }
