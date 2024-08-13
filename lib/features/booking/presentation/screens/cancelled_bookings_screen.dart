import 'package:fixit_provider/features/booking/presentation/bloc/cancelled_bookings.dart/cancelled_bookings_bloc.dart';
import 'package:fixit_provider/features/booking/presentation/widgets/cancelled_booking_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CancelledBookingsScreen extends StatelessWidget {
  const CancelledBookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<CancelledBookingsBloc>().add(GetCancelledBookings());
    return Scaffold(
      body: BlocBuilder<CancelledBookingsBloc, CancelledBookingsState>(
          builder: (context, state) {
        ;
        if (state is CancelledBookingsLoaded) {
          if (state.cancelledBookings.isEmpty) {
            return const Center(
              child: Text(
                'No Cancelled Bookings',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            );
          } else {
            return ListView.builder(
                itemCount: state.cancelledBookings.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: CancelledBookingCard(
                        service: state.cancelledBookings[index].serviceName,
                        amount: 0,
                        bookingDate:
                            state.cancelledBookings[index].bookingDateTime,
                        bookedOn: state.cancelledBookings[index].createdAt,
                        onButtonPressed: () {}),
                  );
                });
          }
        } else {
          return const Center(
            child: Text('NO Bookigs Cancelled'),
          );
        }
      }),
    );
  }
}
