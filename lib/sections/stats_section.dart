import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:my_bmi/data/bmi.dart';
import 'package:my_bmi/sections/page_section.dart';
import 'package:my_bmi/widgets/heading.dart';
import 'package:my_bmi/widgets/labeled_button.dart';

class StatsSection extends PageSection {
  final BMIData _bmiData;

  const StatsSection(this._bmiData, {Key? key}) : super (key: key);

  @override
  State<StatsSection> createState() => _StatsSectionState();
}

class _StatsSectionState extends State<StatsSection> { 
  late BMIData _bmiData;

  LineChart lineChart = LineChart(
    LineChartData(
      minY: 0,
      maxY: 100,
      lineBarsData: [
        LineChartBarData(
          spots: [FlSpot.zero],
          isCurved: true,
        ),
      ],
    ),
  );
  
  @override
  void initState() {
    super.initState();
    _bmiData = widget._bmiData;
    _updateLineChart(_bmiData.chartSpots());
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
        const SizedBox(height: 16),
        const Heading("Stats"),
        const SizedBox(height: 10),
        AspectRatio(
          aspectRatio: 2,
          child: lineChart,
        ),
        const SizedBox(height: 20),
        LabeledButton(
          label: "Clear data", 
          onPressed: () => _clearBMIData(),
        ),
      ]
    );
  }
  
  void _updateLineChart(List<FlSpot> chartSpots) {
    setState(() {
      lineChart = LineChart(
        LineChartData(
          minY: 0,
          maxY: _bmiData.values.map((bmi) => bmi.value).reduce(max).toDouble() + 25,
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 1,
                getTitlesWidget: (value, meta) {
                  return SideTitleWidget(axisSide: meta.axisSide, child: Text("s"));
                }
              )
            ),
          ),
          lineBarsData: [
            LineChartBarData(
              spots: chartSpots,
              isCurved: true,
            ),
          ],
        ),
      );
    });
  }
  
  void _clearBMIData() {
    _bmiData.clear();
    _updateLineChart([]);
  }
}