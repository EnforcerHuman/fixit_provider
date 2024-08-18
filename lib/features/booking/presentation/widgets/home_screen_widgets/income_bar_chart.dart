import 'package:fixit_provider/common/widgets/loading_animation.dart';
import 'package:fixit_provider/features/earnings/presentation/bloc/seven_days_income/seven_days_income_bloc.dart';
import 'package:fixit_provider/features/earnings/presentation/widgets/income_bar_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget buildIncomeBarChart() {
  return BlocBuilder<SevenDaysIncomeBloc, SevenDaysIncomeState>(
    builder: (context, state) {
      if (state is SevendaysIncomeLoaded) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: SizedBox(
              height: (MediaQuery.of(context).size.height * 0.30),
              child: IncomeBarChart(incomeData: state.income)),
        );
      } else if (state is SevendaysIncomeError) {
        return Text(state.error);
      } else {
        return const Center(child: CustomLoadingAnimation());
      }
    },
  );
}
