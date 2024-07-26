import 'package:fixit_provider/common/widgets/round_button.dart';
import 'package:fixit_provider/features/authentication/data/datasources/auth_local_data_source.dart';

import 'package:fixit_provider/features/authentication/presentation/bloc/service_provider/service_provider_bloc.dart';
import 'package:fixit_provider/features/authentication/presentation/bloc/service_provider/service_provider_event.dart';
import 'package:fixit_provider/features/authentication/presentation/bloc/service_provider/service_provider_state.dart';
import 'package:fixit_provider/features/authentication/presentation/verification_pending_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PricingAndRateScreen extends StatelessWidget {
  const PricingAndRateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController paymentController = TextEditingController();

    TextEditingController infoController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Pricing and rate'),
      ),
      body: BlocConsumer<ServiceProviderBloc, ServiceProviderState>(
        listener: (context, state) {
          if (state is ServiceProviderCreated) {
            SharedPreferencesHelper.setLoginStatus(true);
            SharedPreferencesHelper.setVerificationStatus(false);
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (ctx) => const VerificationPendingScreen()),
                (route) => false);
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'How much you charge?',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blue),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ListTile(
                            leading: const Icon(Icons.access_time,
                                color: Colors.blue),
                            title: const Text('Hourly fee'),
                            trailing:
                                const Icon(Icons.check, color: Colors.blue),
                            onTap: () {},
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          validator: (value) {
                            if (value == null) {
                              return 'Please enter amount';
                            }
                            return null;
                          },
                          controller: paymentController,
                          decoration: const InputDecoration(
                            labelText: 'Amount',
                            suffixText: '₹/h',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'More information (Optional)',
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: infoController,
                          decoration: const InputDecoration(
                            hintText: 'Write here...',
                            border: OutlineInputBorder(),
                          ),
                          maxLines: 3,
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16.0),
                  child: RoundButton(
                      title: 'Submit',
                      onPressed: () async {
                        String payment = paymentController.text;

                        context
                            .read<ServiceProviderBloc>()
                            .add(UpdateHourlyPayment(payment));
                        context
                            .read<ServiceProviderBloc>()
                            .add(UpdateMoreInfo(infoController.text));
                        context
                            .read<ServiceProviderBloc>()
                            .add(UpdateIsVerified(false));

                        BlocProvider.of<ServiceProviderBloc>(context);
                        await Future.delayed(const Duration(seconds: 5));
                        // ignore: use_build_context_synchronously
                        context
                            .read<ServiceProviderBloc>()
                            .add(SubmitServiceProvider());
                        // bloc.storeServiceProviderData();
                      })),
            ],
          );
        },
      ),
    );
  }
}
