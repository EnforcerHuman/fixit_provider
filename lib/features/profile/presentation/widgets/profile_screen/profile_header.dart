import 'package:fixit_provider/features/profile/presentation/bloc/service_provider_bloc/service_provider_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget buildProfileHeader() {
  return BlocBuilder<ServiceProviderDetailsBloc, ServiceProviderDetailsState>(
    builder: (context, state) {
      if (state is ServiceProviderDataLoaded) {
        return Row(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage:
                  NetworkImage(state.serviceProvider['profileImage']),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  state.serviceProvider['name'],
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  state.serviceProvider['serviceArea'],
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
          ],
        );
      } else {
        return const Text('NO DETAILS');
      }
    },
  );
}
