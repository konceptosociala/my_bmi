import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:my_bmi/sections/page_section.dart';

class StatsSection extends PageSection {
  const StatsSection({Key? key}) : super (key: key);

  @override
  State<StatsSection> createState() => _StatsSectionState();
}

class _StatsSectionState extends State<StatsSection> { 
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2,
      child: LineChart(
        LineChartData(
          lineBarsData: [
            LineChartBarData(
              spots: [const FlSpot(0, 0), const FlSpot(1, 2), const FlSpot(3, 0.5), const FlSpot(4, 5)],
              isCurved: true,
            )
          ]
        ),
      ),
    );
  }
}