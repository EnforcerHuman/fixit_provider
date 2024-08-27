import 'package:fixit_provider/features/booking/presentation/bloc/requested_bookings_bloc/requested_bookings_bloc.dart';
import 'package:fixit_provider/features/booking/presentation/widgets/mini_booking_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HorizontalBookingList extends StatelessWidget {
  const HorizontalBookingList({super.key});

  void _showBookingDetails(BuildContext context, MiniBookingCard card) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: card,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RequestedBookingsBloc, RequestedBookingsState>(
      builder: (context, state) {
        if (state is RequestedBookingLoaded) {
          if (state.requestedBooking.isEmpty) {
            return Center(
              child: SizedBox(
                  width:
                      MediaQuery.of(context).orientation == Orientation.portrait
                          ? MediaQuery.of(context).size.width * 0.5
                          : MediaQuery.of(context).size.width * 0.3,
                  height:
                      MediaQuery.of(context).orientation == Orientation.portrait
                          ? MediaQuery.of(context).size.height * 0.1
                          : MediaQuery.of(context).size.height * 0.08,
                  child: const Center(child: Text('NO BOOKING REQUESTS'))),
            );
          } else {
            final screenWidth = MediaQuery.of(context).size.width;
            final screenHeight = MediaQuery.of(context).size.height;
            final orientation = MediaQuery.of(context).orientation;

            final cardWidth = orientation == Orientation.portrait
                ? screenWidth * 0.8
                : screenWidth * 0.8;

            return SizedBox(
              height: orientation == Orientation.portrait
                  ? screenHeight * 0.30
                  : screenHeight * 0.40,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: cardWidth / (screenHeight * 0.30),
                ),
                itemCount: state.requestedBooking.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final bookingCard = MiniBookingCard(
                    service: state.requestedBooking[index].serviceName,
                    amount: double.parse(
                        state.requestedBooking[index].hourlyPayment),
                    bookingDate: state.requestedBooking[index].bookingDateTime,
                    bookedOn: state.requestedBooking[index].createdAt,
                    cardColor: Colors.blue,
                  );

                  return GestureDetector(
                    onTapUp: (_) => _showBookingDetails(context, bookingCard),
                    child: bookingCard,
                  );
                },
              ),
            );
          }
        } else if (state is RequestedBookingError) {
          return const Center(child: Text('Error: '));
        }
        return Container();
      },
    );
  }
}
