import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:notoro/core/utils/strings/app_strings.dart';

class WeightProgressChart extends StatelessWidget {
  final Map<DateTime, double> data;

  const WeightProgressChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final sorted = data.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));

    final spots = List.generate(sorted.length, (i) {
      return FlSpot(i.toDouble(), sorted[i].value);
    });

    if (spots.length == 1) {
      spots.insert(0, FlSpot(spots.first.x - 1, 0));
    }

    final totalWeeks = sorted.length;
    final maxValue = sorted
        .map((e) => e.value)
        .fold<double>(0, (prev, curr) => prev > curr ? prev : curr);
    final lastWeek = sorted.last;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppStrings.weightWeeklyProgress,
            style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 4),
        Text(
          'Tygodni: $totalWeeks • Najwięcej: ${maxValue.toStringAsFixed(0)} kg • Ostatni: ${lastWeek.value.toStringAsFixed(0)} kg',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 200,
          child: LineChart(
            LineChartData(
              lineBarsData: [
                LineChartBarData(
                  spots: spots,
                  isCurved: true,
                  dotData: FlDotData(show: false),
                  color: Theme.of(context).colorScheme.primary,
                  belowBarData: BarAreaData(
                    show: true,
                    color: Theme.of(context).colorScheme.primary.withAlpha(50),
                  ),
                ),
              ],
              titlesData: FlTitlesData(show: false),
              borderData: FlBorderData(show: false),
              gridData: FlGridData(show: false),
              lineTouchData: LineTouchData(
                enabled: false,
                touchTooltipData: LineTouchTooltipData(
                  getTooltipItems: (touchedSpots) {
                    return touchedSpots.map((spot) {
                      final index = spot.x.toInt();
                      final date = sorted[index].key;
                      return LineTooltipItem(
                        '${date.day}.${date.month} ${sorted[index].value.toStringAsFixed(0)} kg',
                        const TextStyle(color: Colors.white),
                      );
                    }).toList();
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
