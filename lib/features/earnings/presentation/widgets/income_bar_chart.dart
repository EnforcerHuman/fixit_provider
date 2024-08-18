import 'package:fixit_provider/features/earnings/domain/enitities/income.dart';
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
    final minBars = 7;
    final incomeData = List.generate(
      minBars,
      (index) => index < widget.incomeData.length
          ? widget.incomeData[index]
          : IncomeData(date: DateTime.now(), amount: 0.0),
    );

    // Determine if all values are zero
    bool allValuesZero = incomeData.every((data) => data.amount == 0);

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
              allValuesZero: allValuesZero,
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
    bool allValuesZero = false,
    double width = 22,
  }) {
    // Determine bar color based on value and overall data
    Color barColor =
        allValuesZero ? Colors.grey : (y == 0 ? Colors.grey : Colors.blue);

    // Ensure the bar has a minimum height to be visible
    double barHeight = y == 0 ? 0.1 : y;

    // Remove the extra height adjustment when touched
    double adjustedHeight = isTouched ? barHeight : barHeight;

    // Debug print statements to trace the values
    print(
        'Bar Index: $x, Original Value: $y, Bar Height: $barHeight, Is Touched: $isTouched, Adjusted Height: $adjustedHeight');

    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: adjustedHeight,
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
