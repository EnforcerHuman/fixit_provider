import 'package:fixit_provider/common/color_extension.dart';
import 'package:fixit_provider/features/profile/presentation/bloc/booking_summary_bloc/booking_summary_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget buildStatistics() {
  return BlocBuilder<BookingSummaryBloc, BookingSummaryState>(
    builder: (context, state) {
      if (state is BookingSummaryLoaded) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            buildStatItem(Icons.currency_rupee_outlined,
                state.bookingOverView.totalEarnings.toString(), 'Earnings'),
            buildStatItem(
                Icons.check_circle,
                " ${state.bookingOverView.bookingCount.toString()} Bookings",
                'Completed'),
          ],
        );
      } else {
        return const Text('NO BOOKING DATA AVAILABLE');
      }
    },
  );
}

Widget buildStatItem(IconData icon, String value, String label) {
  return Column(
    children: [
      Icon(icon, color: Colors.blue),
      Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      Text(label, style: TextStyle(color: Tcolor.gray)),
    ],
  );
}
