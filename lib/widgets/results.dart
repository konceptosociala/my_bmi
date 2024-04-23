import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:my_bmi/data/bmi.dart';
import 'package:my_bmi/widgets/labeled_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Results extends StatelessWidget {
  final AnimationController animController;
  final BMIData bmiData;
  final BMI? currentBMI;

  const Results({
    super.key, 
    required this.animController, 
    required this.currentBMI,
    required this.bmiData,
  });

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      const Column(children: [SizedBox(width: 10)]),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(  
            "Results",
            style: Theme.of(context).textTheme.displayLarge,
            textAlign: TextAlign.left,
          ),
          const SizedBox(height: 10),
          Text(
            resultText(),
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 10),
          BMIPalette(highlightIndex: _getHighlightIndex()),
          const SizedBox(height: 20),
          SizedBox(
            width: MediaQuery.of(context).size.width - 50,
            child:
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  LabeledButton(
                    label: "Save results", 
                    onPressed: (){
                      bmiData.add(currentBMI!);
                      _saveBmiData();
                    },
                  )
                ],
              ),
          ),
        ],
      ),
    ]).animate(controller: animController, autoPlay: false).fade();
  }

  Future<void> _saveBmiData() async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setStringList("bmi_data", bmiData.toJson());
  }

  String resultText() {
    if (currentBMI == null) return "";

    return "Your BMI is ${currentBMI!.value} (${currentBMI!.type})";
  }
  
  int _getHighlightIndex() {
    if (currentBMI == null) return -1;

    if (currentBMI!.value <= 18) {
      return 0;
    } else if (currentBMI!.value > 18 && currentBMI!.value <= 25) {
      return 1;
    } else if (currentBMI!.value > 25 && currentBMI!.value <= 30) {
      return 2;
    } else if (currentBMI!.value > 30 && currentBMI!.value <=35) {
      return 3;
    } else {
      return 4;
    }
  }
}

class BMIPalette extends StatelessWidget {
  final int highlightIndex;

  const BMIPalette({super.key, required this.highlightIndex});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _coloredBox(0, Colors.blue, "<18"),
          _coloredBox(1, Colors.green, "19-25"),
          _coloredBox(2, Colors.amber, "26-30"),
          _coloredBox(3, Colors.orange[700]!, "31-35"),
          _coloredBox(4, Colors.red, ">35"),
        ],
      ),
    );
  }

  ColoredBox _coloredBox(int index, Color color, String value) {
    return ColoredBox(
      color: color,
      value: value,
      highlighted: index == highlightIndex,
    );
  }
}

class ColoredBox extends StatelessWidget {
  final String value;
  final Color color;
  final bool highlighted;

  const ColoredBox({
    super.key, 
    required this.value, 
    required this.color, 
    required this.highlighted,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: highlighted
            ? Border(
                bottom: BorderSide(
                  color: Theme.of(context).cardColor,
                  width: 20,
                ),
                top: BorderSide(
                  color: color,
                  width: 20,
                )
              )
            : null,
          color: color,
        ),
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              value, 
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displayLarge,
            ),
          ]
        ),
      ),
    );
  }
}