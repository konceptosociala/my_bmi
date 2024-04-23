import 'dart:developer';

import 'package:adwaita/adwaita.dart';
import 'package:flutter/material.dart';
import 'package:my_bmi/data/bmi.dart';
import 'package:my_bmi/sections/main_section.dart';
import 'package:my_bmi/sections/page_section.dart';
import 'package:my_bmi/sections/stats_section.dart';
import 'package:my_bmi/widgets/appbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(App());
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
          theme: AdwaitaThemeData.dark(fontFamily: "IBMPlexMono"),
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
  final BMIData _bmiData = BMIData.empty();

  late final PageSection _mainSection;
  late final PageSection _statsSection;

  PageSection? _section;

  _PageState() {
    _loadBMIData();
    _mainSection = MainSection(_bmiData);
    _statsSection = StatsSection(_bmiData);
    _section = _mainSection;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        heading: "My BMI",
        context: context,
      ),
      drawer: Drawer(child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.blueGrey),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "My BMI",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.calculate),
            title: const Text('Calculator'),
            onTap: () {
              _setSection(_mainSection);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.auto_graph),
            title: const Text('Stats'),
            onTap: () {
              _setSection(_statsSection);
              Navigator.pop(context);
            },
          ),
        ],
      )),
      body: SingleChildScrollView(child: _section),
    );
  }

  void _setSection(PageSection section) {
    setState(() {
      _section = section;
    });
  }

  Future<void> _loadBMIData() async {
    final prefs = await SharedPreferences.getInstance();

    List<String>? json = prefs.getStringList("bmi_data");
    if (json == null) return;

    for (String s in json) { 
      log(s); 
    }

    _bmiData.load(json);
  }
}