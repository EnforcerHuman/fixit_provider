// import 'package:fixit_provider/features/booking/presentation/bloc/requested_bookings_bloc/requested_bookings_bloc.dart';
// import 'package:fixit_provider/features/booking/presentation/screens/booking_details_screen.dart';
// import 'package:fixit_provider/features/booking/presentation/widgets/booking_card.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class PendingBookingRequestScreen extends StatelessWidget {
//   const PendingBookingRequestScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     context.read<RequestedBookingsBloc>().add(GetRequestedBooking());
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Requested Bookings'),
//         backgroundColor: Colors.blue,
//       ),
//       body: BlocBuilder<RequestedBookingsBloc, RequestedBookingsState>(
//         builder: (context, state) {
//           if (state is RequestedBookingLoaded) {
//             return ListView.builder(
//               itemCount: state.requestedBooking.length,
//               itemBuilder: (context, index) {
//                 final booking = state.requestedBooking[index];

//                 return Padding(
//                   padding: const EdgeInsets.all(10.0),
//                   child: BookingCard(
//                     onButtonPressed: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (ctx) => WorkDetailsScreen(
//                                   bookingDetails:
//                                       state.requestedBooking[index])));
//                     },
//                     service: booking.serviceName,
//                     amount: 300,
//                     bookingDate: booking.bookingDateTime,
//                     bookedOn: booking.createdAt,
//                   ),
//                 );
//               },
//             );
//           } else if (state is RequestedBookingError) {
//             return Center(child: Text('Error: ${state.errorMessage}'));
//           } else {
//             return const Center(child: Text('Loading...'));
//           }
//         },
//       ),
//     );
//   }
// }

import 'package:fixit_provider/features/booking/presentation/bloc/requested_bookings_bloc/requested_bookings_bloc.dart';
import 'package:fixit_provider/features/booking/presentation/screens/booking_details_screen.dart';
import 'package:fixit_provider/features/booking/presentation/widgets/booking_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PendingBookingRequestScreen extends StatelessWidget {
  const PendingBookingRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<RequestedBookingsBloc>().add(GetRequestedBooking());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Requested Bookings'),
        backgroundColor: Colors.blue,
      ),
      body: BlocBuilder<RequestedBookingsBloc, RequestedBookingsState>(
        builder: (context, state) {
          if (state is RequestedBookingLoaded) {
            if (state.requestedBooking.isEmpty) {
              return const Center(
                child: Text(
                  'No Pending Bookings',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              );
            }
            return ListView.builder(
              itemCount: state.requestedBooking.length,
              itemBuilder: (context, index) {
                final booking = state.requestedBooking[index];
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: BookingCard(
                    onButtonPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) => WorkDetailsScreen(
                            isUpcoming: false,
                            bookingDetails: booking,
                          ),
                        ),
                      );
                    },
                    service: booking.serviceName,
                    amount: double.parse(booking.hourlyPayment),
                    bookingDate: booking.bookingDateTime,
                    bookedOn: booking.createdAt,
                  ),
                );
              },
            );
          } else if (state is RequestedBookingError) {
            return Center(child: Text('Error: ${state.errorMessage}'));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
