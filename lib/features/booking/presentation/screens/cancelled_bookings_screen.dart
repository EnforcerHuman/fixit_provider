import 'package:fixit_provider/features/booking/presentation/bloc/cancelled_bookings.dart/cancelled_bookings_bloc.dart';
import 'package:fixit_provider/features/booking/presentation/widgets/booking_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CancelledBookingsScreen extends StatelessWidget {
  const CancelledBookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CancelledBookingsBloc, CancelledBookingsState>(
          builder: (context, state) {
        if (state is CancelledBookingsLoaded) {
          return ListView.builder(itemBuilder: (context, index) {
            BookingCard(
                service: state.cancelledBookings[index].serviceName,
                amount: 0,
                bookingDate: state.cancelledBookings[index].bookingDateTime,
                bookedOn: state.cancelledBookings[index].createdAt,
                onButtonPressed: () {});
          });
        } else {
          return const Center(
            child: Text('NO Bookigs Cancelled'),
          );
        }
      }),
    );
  }
}
