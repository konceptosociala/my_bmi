import 'package:adwaita/adwaita.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_bmi/appbar.dart';
import 'package:my_bmi/form_components.dart';

void main() {
  runApp(App());
}

enum AppSection {
  mainSection,
  statsSection,
}

class App extends StatelessWidget {
  App({super.key});

  final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.dark);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: themeNotifier, 
      builder: (_, ThemeMode currentMode, __) {
        return MaterialApp(
          theme: AdwaitaThemeData.dark(),
          debugShowCheckedModeBanner: false,
          home: Page(themeNotifier: themeNotifier),
          themeMode: currentMode,
        );
      },
    );
  }
}

class Page extends StatefulWidget {
  const Page({required this.themeNotifier, Key? key}) : super (key: key);

  final ValueNotifier<ThemeMode> themeNotifier;

  @override
  State<Page> createState() => _PageState();
}

class _PageState extends State<Page> { 
  AppSection _section = AppSection.mainSection;

  @override
  Widget build(BuildContext context) {
    Widget body;

    switch (_section) {
      case AppSection.mainSection:
        body = const MainSection();
        break;

      case AppSection.statsSection:
        body = const StatsSection();
        break;
    }

    return Scaffold(
      appBar: BMIAppBar(
        heading: "My BMI",
        context: context,
      ),
      drawer: Drawer(child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.blueGrey
            ),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "My BMI",
                style: GoogleFonts.ubuntuMono(textStyle: Theme.of(context).textTheme.headlineLarge),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.calculate),
            title: const Text('Calculator'),
            onTap: () {
              _setSection(AppSection.mainSection);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.auto_graph),
            title: const Text('Stats'),
            onTap: () {
              _setSection(AppSection.statsSection);
              Navigator.pop(context);
            },
          ),
        ],
      )),
      body: body,
    );
  }

  void _setSection(AppSection section) {
    setState(() {
      _section = section;
    });
  }
}

class MainSection extends StatefulWidget {
  const MainSection({Key? key}) : super (key: key);

  @override
  State<MainSection> createState() => _MainSectionState();
}

class _MainSectionState extends State<MainSection> {
  String _massField = "";
  String _heightField = "";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(children: [
        const Heading("Calculate your BMI"),
        LabelledTextField(
          label: "Mass", 
          placeholder: "Enter your mass (in kg)",
          onChanged: _setMassField,
        ),
        const SizedBox(height: 25),
        LabelledTextField(
          label: "Height", 
          placeholder: "Enter your height (in cm)",
          onChanged: _setHeightField,
        ),
        const SizedBox(height: 25),
        LabelledButton(
          label: "Calculate", 
          onPressed: _calculateBMI,
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

    if (mass == null) {
      dialog(context, "Error", "Mass must be a number");
      return;
    }

    if (height == null) {
      dialog(context, "Error", "Height must be a number");
      return;
    }
    
    dialog(context, "Results", "Your BMI is ${(mass/(height*height)*10000).toInt()}");
  }
}

class StatsSection extends StatefulWidget {
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

void dialog(BuildContext context, String title, String message) {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, "OK"),
          child: const Text("Ok"),
        ),
      ],
    ),
  );
}