import 'package:fixit_provider/common/utils/date_utils.dart';
import 'package:fixit_provider/common/widgets/round_button.dart';
import 'package:fixit_provider/features/authentication/presentation/bloc/service_provider/service_provider_bloc.dart';
import 'package:fixit_provider/features/authentication/presentation/bloc/service_provider/service_provider_event.dart';
import 'package:fixit_provider/features/authentication/presentation/documents_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fixit_provider/common/widgets/drop_down_widget.dart';

class ServiceSelection extends StatelessWidget {
  const ServiceSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String from = '';
    String to = '';
    String experience = '';
    String serviceArea = '';
    String serviceType = '';

    final List<String> serviceTypes = [
      'Electrician',
      'Plumber',
      'Carpenter',
      'Painter',
      'HVAC Technician',
      'Locksmith',
      'Gardener',
      'House Cleaner',
      'Appliance Repair',
      'Roofer',
      'Pest Control',
      'Flooring Specialist',
      'Handyman',
      'Window Cleaner',
      'Chimney Sweep',
      'Pool Maintenance',
      'Gutter Cleaner',
      'Landscaper',
      'Solar Panel Installer',
      'Home Security Installer',
      'Interior Designer',
      'Fence Installer',
      'Drywall Contractor',
      'Masonry Contractor',
      'Asphalt Paving',
      'Tree Service',
      'Carpet Cleaner',
      'Pressure Washer',
      'Insulation Installer',
      'Smart Home Technician'
    ];
    DateUtil dateUtils = DateUtil();
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Your Service'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomDropdown(
                  items: const [
                    '0-6 months',
                    '1-2 years',
                    '2-4 years',
                    '4-5 years',
                    '5+ years'
                  ],
                  hint: 'Choose your service Experience',
                  onChanged: (String? value) {
                    // Handle the change, e.g., update state in your bloc
                    experience = value!;
                    print('Selected service: $value');
                  },
                ),
                SizedBox(height: 20),
                CustomDropdown(
                  items: serviceTypes,
                  hint: 'Choose your service type',
                  onChanged: (String? value) {
                    // Handle the change, e.g., update state in your bloc
                    serviceArea = value!;
                    print('Selected service: $value');
                  },
                ),
                SizedBox(height: 20),
                CustomDropdown(
                  items: const [
                    '0-5 k.m',
                    '5-10 k.m',
                    '10-20 k.m',
                    '20+ k.m',
                  ],
                  hint: 'Choose your service radius',
                  onChanged: (String? value) {
                    // Handle the change, e.g., update state in your bloc
                    serviceType = value!;
                    print('Selected service: $value');
                  },
                ),
                SizedBox(height: 20),
                Column(
                  children: [
                    const Row(
                      children: [
                        Text('Working from'),
                      ],
                    ),
                    SizedBox(
                      height: 100,
                      child: CupertinoDatePicker(
                        onDateTimeChanged: (newTime) {
                          from = dateUtils.formatTime(newTime);
                        },
                        initialDateTime: DateTime.now(),
                        use24hFormat: false,
                        minuteInterval: 1,
                        mode: CupertinoDatePickerMode.time,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Column(
                  children: [
                    const Row(
                      children: [
                        Text('Working until'),
                      ],
                    ),
                    SizedBox(
                      height: 70,
                      child: CupertinoDatePicker(
                        onDateTimeChanged: (newTime) {
                          to = dateUtils.formatTime(newTime);
                        },
                        initialDateTime: DateTime.now(),
                        use24hFormat: false,
                        minuteInterval: 1,
                        mode: CupertinoDatePickerMode.time,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: RoundButton(
                    title: 'Next',
                    onPressed: () {
                      context
                          .read<ServiceProviderBloc>()
                          .add(UpdateExperience(experience));
                      context
                          .read<ServiceProviderBloc>()
                          .add(UpdateArea(serviceArea));
                      context
                          .read<ServiceProviderBloc>()
                          .add(UpdateServiceType(serviceType));
                      context
                          .read<ServiceProviderBloc>()
                          .add(UpdateWorkingFrom(from));
                      context
                          .read<ServiceProviderBloc>()
                          .add(UpdateWorkingUntil(to));

                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => UploadDocumentsScreen()));
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
