import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BMI {
  late final int value;
  late final BMIType type;
  late final DateTime date;

  BMI({required this.value, required this.date}) : type = BMIType.fromBMI(value);
  
  BMI.fromJson(String jsonString) {
    final Map<String, dynamic> jsonMap = jsonDecode(jsonString);

    value = int.parse(jsonMap['value'] as String);
    type = BMIType.fromString(jsonMap['type'] as String);
    date = DateTime.parse(jsonMap['date'] as String);
  }
  
  String toJson() {
    final Map<dynamic, dynamic> jsonMap = {
      'value': value.toString(),
      'type': type.toString(),
      'date': date.toString(),
    };

    return jsonEncode(jsonMap);
  }
}

@immutable class BMIData {
  final List<BMI> values;

  const BMIData({required this.values});

  BMIData.empty():
    this(values: []);

  BMIData.fromJson(List<String> json):
    values = []
  {
    load(json);
  }

  void load(List<String> json) {
    values.clear();
    json
      .map((s) => BMI.fromJson(s))
      .forEach((bmi) { values.add(bmi); });
  }

  void add(BMI bmi) {
    values.add(bmi);
  }

  List<String> toJson() {
    return values
      .map((bmi) => bmi.toJson())
      .toList();
  }

  List<FlSpot> chartSpots() {
    return values
      .asMap()
      .entries
      .map((entry) => FlSpot(
        entry.key.toDouble(), 
        entry.value.value.toDouble()
      ))
      .toList();
  }

  void clear() {
    values.clear();
  }
}

enum BMIType {
  underweight,
  normal,
  overweight,
  obese,
  extremelyObese;

  factory BMIType.fromString(String s) {
    switch (s) {
      case "underweight":     return underweight;
      case "normal":          return normal;
      case "overweight":      return overweight;
      case "obese":           return obese;
      case "extremely obese":  return extremelyObese;
      default: throw Exception("Invalid BMIType string `$s`");
    }
  }

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