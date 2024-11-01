import 'dart:developer';

import 'package:earning_tracker/models/earnings.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class EarningsGraph extends StatelessWidget {
  final List<EarningChartModel> earningData;
  final Function(String quarter, int year) onPointClicked;

  const EarningsGraph({
    super.key,
    required this.earningData,
    required this.onPointClicked,
  });

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 2,
              getTitlesWidget: (value, meta) {
                return Text(
                  value.toStringAsFixed(1),
                  style: const TextStyle(color: Colors.white),
                );
              },
            ),
          ),
          rightTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 1,
              getTitlesWidget: (value, meta) {
                return Text(
                  value.toStringAsFixed(1),
                  style: const TextStyle(color: Colors.white),
                );
              },
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 1,
              getTitlesWidget: (value, meta) {
                int index = value.toInt();
                if (index >= 0 && index < earningData.length) {
                  final month = earningData[index].pricedate.month;
                  String quarterLabel;
                  // Correctly calculate the quarter based on the month
                  if (month >= 1 && month <= 3) {
                    quarterLabel = 'Q1';
                  } else if (month >= 4 && month <= 6) {
                    quarterLabel = 'Q2';
                  } else if (month >= 7 && month <= 9) {
                    quarterLabel = 'Q3';
                  } else {
                    quarterLabel = 'Q4';
                  }
                  return Text(
                    quarterLabel,
                    style: const TextStyle(color: Colors.white),
                  );
                }
                return const Text('');
              },
            ),
          ),
        ),
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: true),
        lineBarsData: [
          // Line for Actual EPS
          LineChartBarData(
            spots: earningData
                .asMap()
                .entries
                .where((e) => e.value.actualEps != null)
                .map((e) => FlSpot(e.key.toDouble(), e.value.actualEps ?? 0.0))
                .toList(),
            isCurved: true,
            color: Colors.green,
            dotData: const FlDotData(show: true),
            belowBarData: BarAreaData(show: false),
          ),
          // Line for Estimated EPS
          LineChartBarData(
            spots: earningData
                .asMap()
                .entries
                .where((e) => e.value.estimatedEps != null)
                .map((e) =>
                    FlSpot(e.key.toDouble(), e.value.estimatedEps ?? 0.0))
                .toList(),
            color: Colors.blue,
            dotData: const FlDotData(show: true),
            belowBarData: BarAreaData(show: false),
          ),
        ],
        lineTouchData: LineTouchData(
          touchTooltipData: const LineTouchTooltipData(),
          handleBuiltInTouches: true,
          touchCallback:
              (FlTouchEvent event, LineTouchResponse? touchResponse) {
            if (!event.isInterestedForInteractions || touchResponse == null) {
              return;
            }
            final spot = touchResponse.lineBarSpots?.first;
            if (spot != null) {
              final index = spot.spotIndex;
              if (index >= 0 && index < earningData.length) {
                final pricedate = earningData[index].pricedate;
                if (pricedate != null) {
                  final month = pricedate.month;
                  final year = pricedate.year;
                  String quarter = ((month - 1) ~/ 3 + 1).toString();
                  onPointClicked(quarter, year);
                } else {
                  log('Pricedate is null for index: $index');
                }
              } else {
                log('Index $index is out of bounds for earningData length: ${earningData.length}');
              }
            }
          },
        ),
      ),
    );
  }
}
