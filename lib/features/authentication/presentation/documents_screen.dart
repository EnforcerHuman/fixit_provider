import 'package:fixit_provider/common/services/image_picker.dart';
import 'package:fixit_provider/common/widgets/round_button.dart';
import 'package:fixit_provider/features/authentication/presentation/bloc/service_provider/service_provider_bloc.dart';
import 'package:fixit_provider/features/authentication/presentation/bloc/service_provider/service_provider_event.dart';
import 'package:fixit_provider/features/authentication/presentation/bloc/upload_file/upload_file_bloc.dart';
import 'package:fixit_provider/features/authentication/presentation/pricing_screen.dart';
import 'package:fixit_provider/features/authentication/presentation/widgets/upload_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class UploadDocumentsScreen extends StatelessWidget {
  const UploadDocumentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ServiceProviderBloc>(context);
    String boxtext1 = 'Upload';
    String boxtext2 = 'Upload';
    String boxtext3 = 'Upload';

    Color color1 = Colors.blue;
    Color color2 = Colors.blue;
    Color color3 = Colors.blue;
    int statecount = 1;
    final double width = MediaQuery.of(context).size.width;
    ImagePickerService imagepicker = ImagePickerService();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        title: const Text('fixIt',
            style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 24,
                fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: BlocConsumer<UploadFileBloc, UploadFileState>(
        listener: (context, state) {
          if (state is ProfileImageUploadedState) {
            boxtext3 = 'Uploaded';
            color3 = Colors.green;
            context
                .read<ServiceProviderBloc>()
                .add(UpdatePhoto(state.imagepath!));
          } else if (state is LicenseUploadedState) {
            boxtext1 = 'Uploaded';
            color1 = Colors.green;
            context
                .read<ServiceProviderBloc>()
                .add(UpdateLicense(state.imagepath!));
          } else if (state is CertificateUploadedState) {
            boxtext2 = 'Uploaded';
            color2 = Colors.green;
            context
                .read<ServiceProviderBloc>()
                .add(UpdateCertificate(state.imagepath!));
          } else if (state is ProfileImageUploadedState) {
            context
                .read<ServiceProviderBloc>()
                .add(UpdatePhoto(state.imagepath!));
          } else if (state is CertificateUploadingState) {
            boxtext2 = 'uploading';
          } else if (state is ProfileImageUploadingState) {
            boxtext3 = 'Uploading';
          } else if (state is LicenseUploadingState) {
            boxtext1 = 'uploading';
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'We need a few Documents.',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 20),
                UploadFileWidget(
                  boxText: boxtext1,
                  color: color1,
                  onTap: () async {
                    XFile? image = await imagepicker.pickImage();
                    if (image != null) {
                      // ignore: use_build_context_synchronously
                      BlocProvider.of<UploadFileBloc>(context)
                          .add(LicenseUploadEvent(image));
                    }
                  },
                  label: 'Upload your services license',
                ),
                const SizedBox(height: 20),
                UploadFileWidget(
                  boxText: boxtext2,
                  color: color2,
                  onTap: () async {
                    statecount = 2;
                    XFile? image = await imagepicker.pickImage();
                    if (image != null) {
                      // ignore: use_build_context_synchronously
                      BlocProvider.of<UploadFileBloc>(context)
                          .add(CertificateUploadEvent(image));
                    }
                  },
                  label: 'Upload your Certification',
                ),
                const SizedBox(height: 20),
                UploadFileWidget(
                  boxText: boxtext3,
                  color: color3,
                  onTap: () async {
                    statecount = 3;
                    XFile? image = await imagepicker.pickImage();
                    if (image != null) {
                      // ignore: use_build_context_synchronously
                      BlocProvider.of<UploadFileBloc>(context)
                          .add(ProfileImageUploadEvent(image));
                    }
                  },
                  label: 'Upload your photo',
                ),
                const Spacer(),
                RoundButton(
                    title: 'Next',
                    onPressed: () async {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => const PricingAndRateScreen()));
                    })
              ],
            ),
          );
        },
      ),
    );
  }
}
