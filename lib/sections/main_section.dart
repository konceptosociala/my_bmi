import 'package:flutter/material.dart';
import 'package:my_bmi/data/bmi.dart';
import 'package:my_bmi/sections/page_section.dart';
import 'package:my_bmi/utils/dialog.dart';
import 'package:my_bmi/widgets/heading.dart';
import 'package:my_bmi/widgets/labeled_button.dart';
import 'package:my_bmi/widgets/labeled_text_field.dart';
import 'package:my_bmi/widgets/results.dart';

class MainSection extends PageSection {
  final BMIData _bmiData;

  const MainSection(this._bmiData, {Key? key}) : super (key: key);

  @override
  State<MainSection> createState() => _MainSectionState();
}

class _MainSectionState extends State<MainSection> with TickerProviderStateMixin {
  String _massField = "";
  String _heightField = "";
  BMI? _currentBMI;

  late BMIData _bmiData;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this);
    _bmiData = widget._bmiData;
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(children: [
        const Heading("Calculate your BMI"),
        LabeledTextField(
          label: "Mass", 
          placeholder: "Enter your mass (in kg)",
          onChanged: _setMassField,
        ),
        const SizedBox(height: 25),
        LabeledTextField(
          label: "Height", 
          placeholder: "Enter your height (in cm)",
          onChanged: _setHeightField,
        ),
        const SizedBox(height: 25),
        LabeledButton(
          label: "Calculate", 
          onPressed: _calculateBMI,
        ),
        const SizedBox(height: 25),
        Results(
          currentBMI: _currentBMI,
          animController: _animationController,
          bmiData: _bmiData,
        ),
      ]),
    );
  }

  void _setMassField(String massField) {
    setState(() {
      _massField = massField;
    });
  }

  void _setHeightField(String heightField) {
    setState(() {
      _heightField = heightField;
    });
  }

  void _calculateBMI() {

    int? mass = int.tryParse(_massField);
    int? height = int.tryParse(_heightField);

    if (mass == null || mass < 20 || mass > 300) {
      dialog(context, "Error", "Enter a valid mass!");
      return;
    }

    if (height == null || height < 100 || height > 300) {
      dialog(context, "Error", "Enter a valid height!");
      return;
    }
    
    setState(() {
      _currentBMI = BMI(
        value: (mass/(height*height)*10000).toInt(), 
        date: DateTime.now(),
      );
    });

    _animationController.reset();
    _animationController.forward();
  }
}