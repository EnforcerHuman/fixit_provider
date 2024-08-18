import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';

class ChartWidget extends StatefulWidget {
  final List<FlSpot> dataPoints;
  final List<Color> gradientColors;
  final String viewType; // 'daily', 'monthly', or 'yearly'

  const ChartWidget({
    Key? key,
    required this.dataPoints,
    required this.gradientColors,
    required this.viewType,
  }) : super(key: key);

  @override
  _ChartWidgetState createState() => _ChartWidgetState();
}

class _ChartWidgetState extends State<ChartWidget> {
  TouchedSpotInfo? touchedSpot;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (touchedSpot != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              '\$${touchedSpot!.y.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: widget.gradientColors.last,
              ),
            ).animate().scale(duration: 200.ms),
          ),
        Container(
          height: 300,
          padding: const EdgeInsets.all(20),
          child: LineChart(
            LineChartData(
              gridData: FlGridData(show: false),
              titlesData: FlTitlesData(show: false),
              borderData: FlBorderData(show: false),
              minX: widget.dataPoints
                  .map((spot) => spot.x)
                  .reduce((a, b) => a < b ? a : b),
              maxX: widget.dataPoints
                  .map((spot) => spot.x)
                  .reduce((a, b) => a > b ? a : b),
              minY: widget.dataPoints
                  .map((spot) => spot.y)
                  .reduce((a, b) => a < b ? a : b),
              maxY: widget.dataPoints
                  .map((spot) => spot.y)
                  .reduce((a, b) => a > b ? a : b),
              lineBarsData: [
                LineChartBarData(
                  spots: widget.dataPoints,
                  isCurved: true,
                  gradient: LinearGradient(colors: widget.gradientColors),
                  barWidth: 5,
                  isStrokeCapRound: true,
                  dotData: FlDotData(show: false),
                  belowBarData: BarAreaData(
                    show: true,
                    gradient: LinearGradient(
                      colors: widget.gradientColors
                          .map((color) => color.withOpacity(0.3))
                          .toList(),
                    ),
                  ),
                ),
              ],
              lineTouchData: LineTouchData(
                touchTooltipData: LineTouchTooltipData(
                  // tooltipBgColor: Colors.blueAccent,
                  getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                    return touchedBarSpots.map((barSpot) {
                      return LineTooltipItem(
                        '\$${barSpot.y.toStringAsFixed(2)}',
                        const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      );
                    }).toList();
                  },
                ),
                touchCallback:
                    (FlTouchEvent event, LineTouchResponse? touchResponse) {
                  setState(() {
                    if (touchResponse?.lineBarSpots != null &&
                        touchResponse!.lineBarSpots!.isNotEmpty) {
                      touchedSpot = TouchedSpotInfo(
                        x: touchResponse.lineBarSpots![0].x,
                        y: touchResponse.lineBarSpots![0].y,
                      );
                    } else {
                      touchedSpot = null;
                    }
                  });
                },
                handleBuiltInTouches: true,
              ),
            ),
          ),
        ),
        if (touchedSpot != null)
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              _formatDate(touchedSpot!.x.toInt()),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: widget.gradientColors.first,
              ),
            ).animate().scale(duration: 200.ms),
          ),
      ],
    );
  }

  String _formatDate(int index) {
    final now = DateTime.now();
    final date = widget.viewType == 'daily'
        ? now.subtract(Duration(days: widget.dataPoints.length - 1 - index))
        : widget.viewType == 'monthly'
            ? DateTime(
                now.year, now.month - (widget.dataPoints.length - 1 - index), 1)
            : DateTime(now.year - (widget.dataPoints.length - 1 - index), 1, 1);

    switch (widget.viewType) {
      case 'daily':
        return DateFormat('MMM d, yyyy').format(date);
      case 'monthly':
        return DateFormat('MMMM yyyy').format(date);
      case 'yearly':
        return DateFormat('yyyy').format(date);
      default:
        return '';
    }
  }
}

class TouchedSpotInfo {
  final double x;
  final double y;

  TouchedSpotInfo({required this.x, required this.y});
}
