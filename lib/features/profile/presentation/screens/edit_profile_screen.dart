import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:fixit_provider/common/widgets/app_bar.dart';
import 'package:fixit_provider/features/authentication/data/model/location.dart';
import 'package:fixit_provider/features/profile/presentation/bloc/edit_profile_bloc/edit_profile_bloc.dart';
import 'package:fixit_provider/features/profile/presentation/bloc/service_provider_bloc/service_provider_bloc.dart';
import 'package:fixit_provider/features/profile/presentation/widgets/edit_profile_screen/build_button.dart';
import 'package:fixit_provider/features/profile/presentation/widgets/edit_profile_screen/build_location_widget.dart';
import 'package:fixit_provider/features/profile/presentation/widgets/edit_profile_screen/build_text_editing_fileds.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// ignore: must_be_immutable
class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});

  String payment = '';
  String experience = '';
  String description = '';
  LatLng initialPosition = const LatLng(0, 0);

  @override
  Widget build(BuildContext context) {
    // Fetch the service provider's data initially
    context.read<ServiceProviderDetailsBloc>().add(GetServiceProviderData());

    return Scaffold(
      appBar: const CustomAppBar(),
      body: BlocListener<EditProfileBloc, EditProfileState>(
        listener: (context, state) {
          if (state is ProfileEdited) {
            onProfileEdited(context);
          }
        },
        child: BlocConsumer<ServiceProviderDetailsBloc,
            ServiceProviderDetailsState>(
          listener: (context, state) {
            if (state is ServiceProviderDataLoaded) {
              payment = state.serviceProvider['hourlyPay'];
              experience = state.serviceProvider['experience'];
              description = state.serviceProvider['info'];
              final location =
                  Location.fromJson(state.serviceProvider['location']);
              initialPosition = LatLng(location.latitude, location.longitude);
              context
                  .read<EditProfileBloc>()
                  .add(SetInitialValues(state.serviceProvider));
            }
          },
          builder: (context, state) {
            // TextEditingControllers initialized inside build with the latest data
            TextEditingController hourlyPaymentController =
                TextEditingController(text: payment);
            TextEditingController experienceController =
                TextEditingController(text: experience);
            TextEditingController descriptionController =
                TextEditingController(text: description);

            return SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    buildLocation(context, initialPosition),
                    buildEditingFields(
                      hourlyPaymentController,
                      experienceController,
                      descriptionController,
                    ),
                    buildButton(
                      () {
                        onUpdate(
                          hourlyPaymentController.text,
                          experienceController.text,
                          descriptionController.text,
                          context,
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void onUpdate(
    String payment,
    String experience,
    String description,
    BuildContext context,
  ) {
    context
        .read<EditProfileBloc>()
        .add(UpdateValues(payment, experience, description));
  }
}

void onProfileEdited(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    content: AwesomeSnackbarContent(
      color: Colors.green,
      title: 'Successul!',
      message: 'You have succcessfully edited your profile information!',
      contentType: ContentType.warning,
    ),
  ));
  Navigator.pop(context);
}
