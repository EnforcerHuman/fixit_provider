import 'package:fixit_provider/features/earnings/presentation/bloc/daily_income_bloc/daily_income_bloc.dart';
import 'package:fixit_provider/features/earnings/presentation/widgets/calender.dart';
import 'package:fixit_provider/features/earnings/presentation/widgets/daily_booking_overview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class EarningsMainScreen extends StatelessWidget {
  const EarningsMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String actualDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    context.read<DailyIncomeBloc>().add(LoadDailyIncome(actualDate));
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return constraints.maxWidth > 600
                ? _buildWideLayout(context, constraints)
                : _buildNarrowLayout(context, constraints);
          },
        ),
      ),
    );
  }

  Widget _buildWideLayout(BuildContext context, BoxConstraints constraints) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: _buildCalendar(context),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: _buildBookingOverview(),
        ),
      ],
    );
  }

  Widget _buildNarrowLayout(BuildContext context, BoxConstraints constraints) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: _buildCalendar(context),
        ),
        Expanded(
          child: _buildBookingOverview(),
        ),
      ],
    );
  }

  Widget _buildCalendar(BuildContext context) {
    return Card(
      shadowColor: Colors.blue,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Calender(
          onSelected: (date) {
            String actualDate = DateFormat('yyyy-MM-dd').format(date);
            context.read<DailyIncomeBloc>().add(LoadDailyIncome(actualDate));
          },
        ),
      ),
    );
  }

  Widget _buildBookingOverview() {
    return BlocBuilder<DailyIncomeBloc, DailyIncomeState>(
      builder: (context, state) {
        if (state is DailyIncomeLoaded) {
          return DailyBookingOverview(
            bookings: state.dailyBooking,
          );
        } else if (state is DailyIncomeError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 60, color: Colors.red),
                const SizedBox(height: 20),
                const Text(
                  'Oops! Something went wrong.',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    // Add retry logic here
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
