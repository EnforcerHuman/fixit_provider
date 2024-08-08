import 'package:fixit_provider/features/booking/presentation/screens/all_bookings_screen.dart';
import 'package:fixit_provider/features/booking/presentation/screens/home_screen.dart';
import 'package:fixit_provider/features/main_navigation/presentation/bottom_navigation_bloc/bottom_navigation_bloc_bloc.dart';
import 'package:fixit_provider/features/main_navigation/presentation/bottom_navigation_bloc/bottom_navigation_bloc_event.dart';
import 'package:fixit_provider/features/main_navigation/presentation/bottom_navigation_bloc/bottom_navigation_bloc_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/bottom_nav_bar.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainNavigationBloc(),
      child: MainScreenContent(),
    );
  }
}

class MainScreenContent extends StatelessWidget {
  final List<Widget> _pages = [HomeScreen(), AllBookingsScreen()];

  MainScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainNavigationBloc, MainNavigationState>(
      builder: (context, state) {
        return Scaffold(
          body: _pages[state.selectedIndex],
          bottomNavigationBar: BottomNavBar(
            selectedIndex: state.selectedIndex,
            onItemTapped: (index) {
              context.read<MainNavigationBloc>().add(NavigateToIndex(index));
            },
          ),
        );
      },
    );
  }
}
