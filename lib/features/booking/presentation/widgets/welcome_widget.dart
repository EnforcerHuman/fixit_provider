import 'package:fixit_provider/features/profile/presentation/bloc/service_provider_bloc/service_provider_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WelcomeWidget extends StatelessWidget {
  const WelcomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ServiceProviderDetailsBloc>().add(GetServiceProviderData());
    return BlocBuilder<ServiceProviderDetailsBloc, ServiceProviderDetailsState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Welcome Back',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 10,
              ),
              Text(
                  state is ServiceProviderDataLoaded
                      ? state.serviceProvider['name']
                      : 'User',
                  style: const TextStyle(fontWeight: FontWeight.w400)),
            ],
          ),
        );
      },
    );
  }
}
