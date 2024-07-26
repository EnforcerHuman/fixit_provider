import 'package:fixit_provider/common/widgets/round_button.dart';
import 'package:fixit_provider/features/authentication/data/model/location.dart';
import 'package:fixit_provider/features/authentication/presentation/bloc/location/location_bloc.dart';
import 'package:fixit_provider/features/authentication/presentation/bloc/location/location_state.dart';
import 'package:fixit_provider/features/authentication/presentation/bloc/service_provider/service_provider_bloc.dart';
import 'package:fixit_provider/features/authentication/presentation/bloc/service_provider/service_provider_event.dart';
import 'package:fixit_provider/features/authentication/presentation/service_selection_sccreen.dart';
import 'package:fixit_provider/features/authentication/presentation/widgets/location_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationScreen extends StatelessWidget {
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ServiceProvider serviceprovider = ServiceProvider();
    // late GoogleMapController myController;
    // LatLng _currentPosition = LatLng(37.7749, -122.4194);
    late LatLng position;
    late String adress;
    TextEditingController locationcontroller =
        TextEditingController(text: 'Adress');
    TextEditingController businessNameController = TextEditingController();
    TextEditingController businessAdressControler = TextEditingController();
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: BlocConsumer<LocationBloc, LocationState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is LocationSelected) {
            locationcontroller.text = state.adress;
            position = state.selectedPosition;
            adress = state.adress;
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Allow “FixIt” to use your location',
                    style: TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(255, 80, 77, 77),
                        fontWeight: FontWeight.bold),
                  ),
                  const Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: const Text(
                      'We need to know your exact location so that Clients can find you easily near you.',
                      style: TextStyle(
                          fontSize: 15,
                          color: Color.fromARGB(255, 139, 138, 138),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: 300,
                    width: MediaQuery.of(context).size.width - 50,
                    color: Colors.blue,
                    child: LocationWidget(),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 50,
                    child: Column(
                      children: [
                        TextField(
                          controller: locationcontroller,
                          decoration: const InputDecoration(
                            hintText: 'Location',
                            prefixIcon: Icon(
                              Icons.location_on_sharp,
                              color: Colors.blue,
                            ),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextField(
                          controller: businessNameController,
                          decoration: const InputDecoration(
                            iconColor: Colors.blue,
                            hintText: 'Business name',
                            prefixIcon: Icon(
                              Icons.person_2_rounded,
                              color: Colors.blue,
                            ),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextField(
                          controller: businessAdressControler,
                          decoration: const InputDecoration(
                            hintText: 'Business adress',
                            prefixIcon: Icon(
                              Icons.business_sharp,
                              color: Colors.blue,
                            ),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        RoundButton(
                            title: 'Next',
                            onPressed: () async {
                              Location providerLocation = Location(
                                  latitude: position.latitude,
                                  longitude: position.longitude,
                                  address: adress);
                              context.read<ServiceProviderBloc>().add(
                                  UpdateBusinessName(
                                      businessNameController.text));
                              context
                                  .read<ServiceProviderBloc>()
                                  .add(UpdateLocation(providerLocation));
                              context.read<ServiceProviderBloc>().add(
                                  UpdateBusinessAdress(
                                      businessAdressControler.text));
                              //logic to move after location receiving
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (ctx) => ServiceSelection()));
                            })
                      ],
                    ),
                  ),
                ]),
          );
        },
      )),
    );
  }
}
