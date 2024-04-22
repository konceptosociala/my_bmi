import 'package:fl_chart/fl_chart.dart';

class BMI {
  final int value;
  final BMIType type;
  final DateTime date;

  BMI({required this.value, required this.date}): 
    type = BMIType.fromBMI(value);

  Map toJson() => {
    'value': value,
    'type': type,
    'date': date,
  };
}

class BMIData {
  List<BMI> values = [];

  BMIData({required this.values});

  BMIData.empty() : this(values: []);

  // BMIData.parse(List<String> parse) {

  // }

  void add(BMI bmi) {
    values.add(bmi);
  }

  List<FlSpot> toChartSpots() {
    return values
      .asMap()
      .entries
      .map((entry) => FlSpot(
        entry.key.toDouble(), 
        entry.value.value.toDouble()
      ))
      .toList();
  }
}

enum BMIType {
  underweight,
  normal,
  overweight,
  obese,
  extremelyObese;

  factory BMIType.fromBMI(int bmi) {
    if (bmi <= 18) {
      return underweight;
    } else if (bmi > 18 && bmi <= 25) {
      return normal;
    } else if (bmi > 25 && bmi <= 30) {
      return overweight;
    } else if (bmi > 30 && bmi <=35) {
      return obese;
    } else {
      return extremelyObese;
    }
  }

  @override String toString() {
    switch (this) {
      case underweight:     return "underweight";
      case normal:          return "normal";
      case overweight:      return "overweight";
      case obese:           return "obese";
      case extremelyObese:  return "extremely obese";
    }
  }
}