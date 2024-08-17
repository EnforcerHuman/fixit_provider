import 'package:calendar_agenda/calendar_agenda.dart';
import 'package:fixit_provider/common/color_extension.dart';
import 'package:fixit_provider/features/authentication/data/datasources/auth_local_data_source.dart';
import 'package:fixit_provider/features/booking/presentation/bloc/upcoming_bookings_bloc/upcoming_bookings_bloc.dart';
import 'package:fixit_provider/features/booking/presentation/screens/booking_details_screen.dart';
import 'package:fixit_provider/features/booking/presentation/screens/payment_collection_screen.dart';
import 'package:fixit_provider/features/booking/presentation/widgets/upcoming_booking_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class UpcomingBookingsScreen extends StatelessWidget {
  const UpcomingBookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CalendarAgendaController calendarAgendaControllerAppBar =
        CalendarAgendaController();
    return Scaffold(
        appBar: CalendarAgenda(
          backgroundColor: Tcolor.secondryColor2,
          controller: calendarAgendaControllerAppBar,
          appbar: true,
          selectedDayPosition: SelectedDayPosition.left,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
          weekDay: WeekDay.long,
          fullCalendarScroll: FullCalendarScroll.horizontal,
          fullCalendarDay: WeekDay.long,
          selectedDateColor: Colors.green.shade900,
          locale: 'en',
          initialDate: DateTime.now(),
          calendarEventColor: Colors.green,
          firstDate: DateTime.now().subtract(const Duration(days: 140)),
          lastDate: DateTime.now().add(const Duration(days: 60)),
          onDateSelected: (date) async {
            String actualdate = DateFormat('yyy-MM-dd').format(date);
            String id = await SharedPreferencesHelper.getUserId();
            // ignore: use_build_context_synchronously
            print(actualdate);
            context
                .read<UpcomingBookingsBloc>()
                .add(GetUpcomingBookings(actualdate, id));
          },
        ),
        body: BlocBuilder<UpcomingBookingsBloc, UpcomingBookingsState>(
          builder: (context, state) {
            if (state is UpcomingBookingLoaded) {
              if (state.upcomingBookings.isEmpty) {
                return const Center(
                  child: Text('No Bookings'),
                );
              } else {
                return Expanded(
                    child: ListView.builder(
                        itemCount: state.upcomingBookings.length,
                        itemBuilder: (context, index) {
                          bool isRequested =
                              state.upcomingBookings[index].paymentStatus ==
                                  'Requested';
                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: UpcomingBookingCard(
                                onViewDetails: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (ctx) => WorkDetailsScreen(
                                            isUpcoming: true,
                                            bookingDetails:
                                                state.upcomingBookings[index],
                                          )));
                                },
                                isRequsted: isRequested,
                                service:
                                    state.upcomingBookings[index].serviceName,
                                amount: 300,
                                bookingDate: state
                                    .upcomingBookings[index].bookingDateTime,
                                bookedOn:
                                    state.upcomingBookings[index].createdAt,
                                onButtonPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (ctx) => PaymentCollectionScreen(
                                            bookingModel:
                                                state.upcomingBookings[index],
                                          )));
                                }),
                          );
                        }));
              }
            } else if (state is UpcomingBookingFailed) {
              return const Center(
                child: Text('No Bookings'),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}
