import 'package:fixit_provider/features/booking/presentation/bloc/completed_bookings_bloc/completed_bookings_bloc.dart';
import 'package:fixit_provider/features/booking/presentation/widgets/booking_card.dart';
import 'package:fixit_provider/features/booking/presentation/widgets/completed_booking_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CompletedBookingsScreen extends StatelessWidget {
  const CompletedBookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<CompletedBookingsBloc>().add(GetCompletedBooking());
    return BlocBuilder<CompletedBookingsBloc, CompletedBookingsState>(
      builder: (context, state) {
        if (state is CompletedBookinsLoaded) {
          return ListView.builder(
              itemCount: state.completedBookings.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: CompletedBookingCard(
                      service: state.completedBookings[index].serviceName,
                      amount: double.parse(
                          state.completedBookings[index].totalPayment),
                      bookingDate:
                          state.completedBookings[index].bookingDateTime,
                      bookedOn: state.completedBookings[index].createdAt,
                      onButtonPressed: () {}),
                );
              });
        } else if (state is CompletedBookingsLoading) {
          return const CircularProgressIndicator();
        } else if (state is CompletedBookingsFailed) {
          return Center(
            child: Text(state.message),
          );
        } else {
          return const Center(
            child: Text('unexpected error'),
          );
        }
      },
    );
  }
}
