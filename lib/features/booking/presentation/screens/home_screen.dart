import 'package:fixit_provider/common/widgets/app_bar.dart';
import 'package:fixit_provider/common/widgets/header_with_button.dart';
import 'package:fixit_provider/features/booking/presentation/bloc/requested_bookings_bloc/requested_bookings_bloc.dart';
import 'package:fixit_provider/features/booking/presentation/constants/_home_screen_strings.dart';
import 'package:fixit_provider/features/booking/presentation/screens/pending_booking_request.dart';
import 'package:fixit_provider/features/booking/presentation/widgets/home_screen_widgets/income_bar_chart.dart';
import 'package:fixit_provider/features/booking/presentation/widgets/horizontal_booking_list.dart';
import 'package:fixit_provider/features/booking/presentation/widgets/welcome_widget.dart';
import 'package:fixit_provider/features/earnings/presentation/bloc/seven_days_income/seven_days_income_bloc.dart';
import 'package:fixit_provider/features/earnings/presentation/screens/earning_history_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<RequestedBookingsBloc>().add(GetRequestedBooking());
    context.read<SevenDaysIncomeBloc>().add(LoadSevenDaysIncome());

    return Scaffold(
      appBar: const CustomAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const WelcomeWidget(),
              HeaderWithButton(
                heading: HomeScreenStrings.incomeHistoryTitle,
                buttonText: HomeScreenStrings.historyButtonLabel,
                onTap: () {
                  onHistoryPressed(context);
                },
              ),
              buildIncomeBarChart(),
              HeaderWithButton(
                  heading: HomeScreenStrings.bookingHomeScreenTitle,
                  buttonText: HomeScreenStrings.viewAllButtonLabel,
                  onTap: () {
                    onViewAllPressed(context);
                  }),
              const HorizontalBookingList(),
            ],
          ),
        ),
      ),
    );
  }
}

void onViewAllPressed(BuildContext context) {
  Navigator.of(context).push(
      MaterialPageRoute(builder: (ctx) => const PendingBookingRequestScreen()));
}

void onHistoryPressed(BuildContext context) {
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (ctx) => EarningHistoryScreen()));
}
