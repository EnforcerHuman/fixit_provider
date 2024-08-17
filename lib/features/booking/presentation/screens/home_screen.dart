import 'package:fixit_provider/common/widgets/app_bar.dart';
import 'package:fixit_provider/common/widgets/round_button.dart';
import 'package:fixit_provider/core/styles/app_colors.dart';
import 'package:fixit_provider/features/authentication/data/datasources/auth_local_data_source.dart';
import 'package:fixit_provider/features/booking/presentation/bloc/requested_bookings_bloc/requested_bookings_bloc.dart';
import 'package:fixit_provider/features/booking/presentation/constants/_home_screen_strings.dart';
import 'package:fixit_provider/features/booking/presentation/widgets/mini_booking_card.dart';
import 'package:fixit_provider/features/payment/domain/enitities/income.dart';
import 'package:fixit_provider/features/payment/presentation/bloc/seven_days_income/seven_days_income_bloc.dart';
import 'package:fixit_provider/features/payment/presentation/widgets/income_bar_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String id = 'x90xCE8D67dI15D5J3MYKmjGJgX2';
    // void test() async {
    //   id = await SharedPreferencesHelper.getUserId();
    // }

    context.read<RequestedBookingsBloc>().add(GetRequestedBooking());
    context.read<SevenDaysIncomeBloc>().add(LoadSevenDaysIncome(id));
    final List<IncomeData> incomeData = [
      IncomeData(date: DateTime(2025, 1, 1), amount: 1000),
      IncomeData(date: DateTime(2024, 1, 1), amount: 1200),
      IncomeData(date: DateTime(2024, 3, 1), amount: 900),
      IncomeData(date: DateTime(2024, 4, 1), amount: 1500),
      IncomeData(date: DateTime(2024, 5, 1), amount: 1800),
      IncomeData(date: DateTime(2024, 6, 1), amount: 0),
      IncomeData(date: DateTime(2024, 7, 1), amount: 1200),
    ];
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const WelcomeWidget(),
                ResponsiveHeader(
                  heading: HomeScreenStrings.incomeHistoryTitle,
                  buttonText: HomeScreenStrings.historyButtonLabel,
                  onTap: () {},
                ),
                BlocBuilder<SevenDaysIncomeBloc, SevenDaysIncomeState>(
                  builder: (context, state) {
                    if (state is SevendaysIncomeLoaded) {
                      print(state.income.toString());
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: IncomeBarChart(incomeData: state.income),
                      );
                    } else if (state is SevendaysIncomeError) {
                      print(state.error);
                      return Text(state.error);
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
                ResponsiveHeader(
                    heading: HomeScreenStrings.bookingHomeScreenTitle,
                    buttonText: HomeScreenStrings.viewAllButtonLabel,
                    onTap: () {}),
                const BookingList()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BookingList extends StatelessWidget {
  const BookingList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RequestedBookingsBloc, RequestedBookingsState>(
      builder: (context, state) {
        if (state is RequestedBookingLoaded) {
          return SizedBox(
            height: 200,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                childAspectRatio: 1.0,
              ),
              itemCount: state.requestedBooking.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return MiniBookingCard(
                  service: state.requestedBooking[index].serviceName,
                  amount:
                      double.parse(state.requestedBooking[index].hourlyPayment),
                  bookingDate: state.requestedBooking[index].bookingDateTime,
                  bookedOn: state.requestedBooking[index].createdAt,
                );
              },
            ),
          );
        } else if (state is RequestedBookingError) {
          return const Center(child: Text('Error: '));
        }
        return Container();
      },
    );
  }
}

class WelcomeWidget extends StatelessWidget {
  const WelcomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Welcome Back', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(
            height: 10,
          ),
          Text('Melbin', style: TextStyle(fontWeight: FontWeight.w400)),
        ],
      ),
    );
  }
}

class ResponsiveHeader extends StatelessWidget {
  final String heading;
  final String buttonText;
  final VoidCallback onTap;

  const ResponsiveHeader(
      {super.key,
      required this.heading,
      required this.buttonText,
      required this.onTap});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              heading,
              style: TextStyle(
                color: AppColors.secondaryColor,
                fontWeight: FontWeight.bold,
                fontSize: MediaQuery.of(context).size.width > 600 ? 20 : 16,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width > 600 ? 120 : 100,
            child: RoundButton(
              title: buttonText,
              onPressed: onTap,
            ),
          ),
        ],
      ),
    );
  }
}
