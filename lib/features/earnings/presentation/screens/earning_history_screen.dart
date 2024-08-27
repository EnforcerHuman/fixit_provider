import 'package:fixit_provider/common/widgets/app_bar.dart';
import 'package:fixit_provider/features/earnings/presentation/bloc/montly_income_bloc/monthly_income_bloc.dart';
import 'package:fixit_provider/features/earnings/presentation/screens/earings_main_screen.dart';
import 'package:fixit_provider/features/earnings/presentation/widgets/monthly_booking_card.dart';
import 'package:fixit_provider/features/profile/presentation/bloc/booking_summary_bloc/booking_summary_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EarningHistoryScreen extends StatelessWidget {
  final ValueNotifier<String> currentViewNotifier =
      ValueNotifier<String>('monthly');

  EarningHistoryScreen({super.key});

  final List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  @override
  Widget build(BuildContext context) {
    context.read<MonthlyIncomeBloc>().add(LoadMontlyIncome());
    context.read<BookingSummaryBloc>().add(LoadBookingOverview());
    return Scaffold(
      body: BlocBuilder<MonthlyIncomeBloc, MonthlyIncomeState>(
        builder: (context, state) {
          if (state is MontlyIncomeLoaded) {
            return Column(
              children: [_buildTotalEarnings(), _buildMOntlyOverview(state)],
            ).animate().fade(duration: 500.ms);
          } else if (state is MontlyIncomeErrror) {
            return const Center(
              child: Text('Error loading data'),
            );
          } else {
            return const Column(
              children: [
                SizedBox(height: 20),
                Center(
                  child: CircularProgressIndicator(),
                )
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildMOntlyOverview(MontlyIncomeLoaded state) {
    return Expanded(
      child: ListView.builder(
        itemCount: state.data.length,
        itemBuilder: (context, index) {
          final overview = state.data[state.data.length - index - 1];
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: MonthlyBookingCard(
              monthYear: overview.monthYear,
              totalBookings: int.parse(overview.totalBookings),
              totalEarnings: double.parse(overview.totalEarnings),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTotalEarnings() {
    return BlocBuilder<BookingSummaryBloc, BookingSummaryState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Text(
                'Total Earnings',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              state is BookingSummaryLoaded
                  ? Text(
                      ' ₹${state.bookingOverView.totalEarnings.toString()}',
                      style: const TextStyle(
                          fontSize: 36, fontWeight: FontWeight.bold),
                    )
                  : const Text('calculating..'),
            ],
          ),
        );
      },
    ).animate().scale(duration: 500.ms);
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}

Route createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        const EarningsMainScreen(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(-1.0, 0.0); // Start from the left
      const end = Offset.zero; // End at the current position
      const curve = Curves.easeInOut;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}
