import 'package:fixit_provider/features/booking/presentation/bloc/top_nav_bar_bloc/top_nav_bar_bloc.dart';
import 'package:fixit_provider/features/earnings/presentation/screens/earings_main_screen.dart';
import 'package:fixit_provider/features/earnings/presentation/screens/earning_history_screen.dart';
import 'package:fixit_provider/features/earnings/presentation/widgets/upper_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainEarningScreen extends StatelessWidget {
  MainEarningScreen({super.key});
  final List<Widget> pages = [
    EarningHistoryScreen(),
    const EarningsMainScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TopNavBarBloc(),
      child: BlocBuilder<TopNavBarBloc, TopNavState>(
        builder: (context, state) {
          return Scaffold(
            appBar: UpperNavBar(
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
