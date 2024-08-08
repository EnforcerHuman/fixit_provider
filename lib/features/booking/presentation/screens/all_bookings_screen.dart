import 'package:fixit_provider/features/booking/presentation/bloc/top_nav_bar_bloc/top_nav_bar_bloc.dart';
import 'package:fixit_provider/features/booking/presentation/screens/cancelled_bookings_screen.dart';
import 'package:fixit_provider/features/booking/presentation/screens/pending_booking_request.dart';
import 'package:fixit_provider/features/booking/presentation/screens/upcoming_bookings.dart';
import 'package:fixit_provider/features/booking/presentation/widgets/top_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllBookingsScreen extends StatelessWidget {
  final List<Widget> pages = [
    const PendingBookingRequestScreen(),
    const UpcomingBookingsScreen(),
    const CancelledBookingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TopNavBarBloc(),
      child: BlocBuilder<TopNavBarBloc, TopNavState>(
        builder: (context, state) {
          return Scaffold(
            appBar: TopNavBar(
              selectedIndex: state.selectedIndex,
              onItemTapped: (index) {
                context.read<TopNavBarBloc>().add(NavigateToIndex(index));
              },
            ),
            body: pages[state.selectedIndex],
          );
        },
      ),
    );
  }
}
