// import 'package:fixit_provider/features/payment/domain/enitities/income.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class IncomeBarChart extends StatefulWidget {
//   final List<IncomeData> incomeData;

//   const IncomeBarChart({super.key, required this.incomeData});

//   @override
//   State<IncomeBarChart> createState() => _IncomeBarChartState();
// }

// class _IncomeBarChartState extends State<IncomeBarChart> {
//   int touchedIndex = -1;

//   @override
//   Widget build(BuildContext context) {
//     return AspectRatio(
//       aspectRatio: 1.7,
//       child: BarChart(
//         BarChartData(
//           barTouchData: BarTouchData(
//             touchTooltipData: BarTouchTooltipData(
//               getTooltipItem: (group, groupIndex, rod, rodIndex) {
//                 return BarTooltipItem(
//                   '${DateFormat('dd-MM').format(widget.incomeData[group.x].date)}\n',
//                   const TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 14,
//                   ),
//                   children: <TextSpan>[
//                     TextSpan(
//                       text: '\$${rod.toY.toStringAsFixed(2)}',
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 16,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ],
//                 );
//               },
//             ),
//             touchCallback: (FlTouchEvent event, barTouchResponse) {
//               setState(() {
//                 if (!event.isInterestedForInteractions ||
//                     barTouchResponse == null ||
//                     barTouchResponse.spot == null) {
//                   touchedIndex = -1;
//                   return;
//                 }
//                 touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
//               });
//             },
//           ),
//           titlesData: FlTitlesData(
//             show: true,
//             rightTitles: const AxisTitles(
//               sideTitles: SideTitles(showTitles: false),
//             ),
//             topTitles: const AxisTitles(
//               sideTitles: SideTitles(showTitles: false),
//             ),
//             bottomTitles: AxisTitles(
//               sideTitles: SideTitles(
//                 showTitles: true,
//                 getTitlesWidget: getTitles,
//                 reservedSize: 64, // Increased to accommodate longer date text
//               ),
//             ),
//             leftTitles: const AxisTitles(
//               sideTitles: SideTitles(
//                 showTitles: false,
//               ),
//             ),
//           ),
//           borderData: FlBorderData(
//             show: false,
//           ),
//           barGroups: List.generate(widget.incomeData.length, (i) {
//             return makeGroupData(
//               i,
//               widget.incomeData[i].amount,
//               isTouched: i == touchedIndex,
//             );
//           }),
//           gridData: const FlGridData(show: false),
//         ),
//       ),
//     );
//   }

//   Widget getTitles(double value, TitleMeta meta) {
//     final dateFormat = DateFormat('dd-MM'); // Full date format
//     final date = widget.incomeData[value.toInt()].date;
//     final text = dateFormat.format(date);

//     return SideTitleWidget(
//       axisSide: meta.axisSide,
//       space: 16,
//       child: Text(text,
//           style: const TextStyle(
//             color: Colors.grey,
//             fontWeight: FontWeight.w500,
//             fontSize: 12,
//           )),
//     );
//   }

//   BarChartGroupData makeGroupData(
//     int x,
//     double y, {
//     bool isTouched = false,
//     Color barColor = Colors.blue,
//     double width = 22,
//   }) {
//     return BarChartGroupData(
//       x: x,
//       barRods: [
//         BarChartRodData(
//           toY: isTouched ? y + 1 : y,
//           color: barColor,
//           width: width,
//           borderSide: isTouched
//               ? const BorderSide(color: Colors.yellow)
//               : const BorderSide(color: Colors.white, width: 0),
//           backDrawRodData: BackgroundBarChartRodData(
//             show: true,
//             toY: widget.incomeData
//                     .map((e) => e.amount)
//                     .reduce((a, b) => a > b ? a : b) *
//                 1.2,
//             color: Colors.grey.withOpacity(0.2),
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:fixit_provider/features/payment/domain/enitities/income.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class IncomeBarChart extends StatefulWidget {
  final List<IncomeData> incomeData;

  const IncomeBarChart({super.key, required this.incomeData});

  @override
  State<IncomeBarChart> createState() => _IncomeBarChartState();
}

class _IncomeBarChartState extends State<IncomeBarChart> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    // Check if there's data to display
    if (widget.incomeData.isEmpty) {
      return Center(child: Text('No data available'));
    }

    // Ensure minimum number of bars for better chart appearance
    final minBars = 7; // Minimum number of bars you want to show
    final incomeData = List.generate(
      minBars,
      (index) => index < widget.incomeData.length
          ? widget.incomeData[index]
          : IncomeData(date: DateTime.now(), amount: 0.0),
    );

    return AspectRatio(
      aspectRatio: 1.7,
      child: BarChart(
        BarChartData(
          barTouchData: BarTouchData(
            touchTooltipData: BarTouchTooltipData(
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                return BarTooltipItem(
                  '${DateFormat('dd-MM').format(incomeData[group.x].date)}\n',
                  const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: '\$${rod.toY.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                );
              },
            ),
            touchCallback: (FlTouchEvent event, barTouchResponse) {
              setState(() {
                if (!event.isInterestedForInteractions ||
                    barTouchResponse == null ||
                    barTouchResponse.spot == null) {
                  touchedIndex = -1;
                  return;
                }
                touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
              });
            },
          ),
          titlesData: FlTitlesData(
            show: true,
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: getTitles,
                reservedSize: 64,
              ),
            ),
            leftTitles: const AxisTitles(
              sideTitles: SideTitles(
                showTitles: false,
              ),
            ),
          ),
          borderData: FlBorderData(
            show: false,
          ),
          barGroups: List.generate(incomeData.length, (i) {
            return makeGroupData(
              i,
              incomeData[i].amount,
              isTouched: i == touchedIndex,
            );
          }),
          gridData: const FlGridData(show: false),
        ),
      ),
    );
  }

  Widget getTitles(double value, TitleMeta meta) {
    final index = value.toInt();

    // Ensure the index is within the valid range
    if (index >= 0 && index < widget.incomeData.length) {
      final dateFormat = DateFormat('dd-MM');
      final date = widget.incomeData[index].date;
      final text = dateFormat.format(date);

      return SideTitleWidget(
        axisSide: meta.axisSide,
        space: 16,
        child: Text(text,
            style: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w500,
              fontSize: 12,
            )),
      );
    } else {
      // Return an empty widget if index is out of range
      return const SideTitleWidget(
        axisSide: AxisSide.left,
        space: 16,
        child: SizedBox.shrink(), // Empty widget
      );
    }
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color barColor = Colors.blue,
    double width = 22,
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: isTouched ? y + 1 : y,
          color: barColor,
          width: width,
          borderSide: isTouched
              ? const BorderSide(color: Colors.yellow)
              : const BorderSide(color: Colors.white, width: 0),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: widget.incomeData
                    .map((e) => e.amount)
                    .reduce((a, b) => a > b ? a : b) *
                1.2,
            color: Colors.grey.withOpacity(0.2),
          ),
        ),
      ],
    );
  }
}
