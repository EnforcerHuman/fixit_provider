import 'package:fixit_provider/common/widgets/app_bar.dart';
import 'package:fixit_provider/features/earnings/presentation/bloc/montly_income_bloc/monthly_income_bloc.dart';
import 'package:fixit_provider/features/earnings/presentation/widgets/chart_widget.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
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
    return Scaffold(
      appBar: CustomAppBar(),
      body: BlocBuilder<MonthlyIncomeBloc, MonthlyIncomeState>(
        builder: (context, state) {
          return Column(
            children: [
              const SizedBox(height: 20),
              _buildViewSelector(),
              const SizedBox(height: 20),
              state is MontlyIncomeLoaded
                  ? ChartWidget(
                      dataPoints: state.data,
                      gradientColors: gradientColors,
                      viewType: 'monthly')
                  : ChartWidget(
                      dataPoints: [
                        FlSpot(0, 300),
                        FlSpot(1, 1500),
                        FlSpot(2, 4),
                        FlSpot(3, 2),
                        FlSpot(4, 5),
                        FlSpot(5, 1),
                        FlSpot(6, 3),
                      ],
                      gradientColors: [
                        Color(0xff23b6e6),
                        Color(0xff02d39a),
                      ],
                      viewType: 'monthly', // or 'monthly' or 'yearly'
                    ),
              const SizedBox(height: 20),
              _buildTotalEarnings(),
            ],
          );
        },
      ).animate().fade(duration: 500.ms),
    );
  }

  Widget _buildViewSelector() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(30),
      ),
      child: ValueListenableBuilder<String>(
        valueListenable: currentViewNotifier,
        builder: (context, currentView, _) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: ['Daily', 'Monthly', 'Yearly']
                .map(
                    (view) => _buildViewButton(view.toLowerCase(), currentView))
                .toList(),
          );
        },
      ),
    );
  }

  Widget _buildViewButton(String view, String currentView) {
    bool isSelected = currentView == view;
    return GestureDetector(
      onTap: () => currentViewNotifier.value = view,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          view.capitalize(),
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ).animate().scale(duration: 200.ms),
    );
  }

  Widget _buildTotalEarnings() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: const [
          Text(
            'Total Earnings',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            '\$1,234.56',
            style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ).animate().scale(duration: 500.ms);
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}
