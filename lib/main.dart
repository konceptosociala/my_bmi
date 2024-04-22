import 'package:adwaita/adwaita.dart';
import 'package:flutter/material.dart';
import 'package:my_bmi/sections/main_section.dart';
import 'package:my_bmi/sections/page_section.dart';
import 'package:my_bmi/sections/stats_section.dart';
import 'package:my_bmi/widgets/appbar.dart';

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
  final PageSection _mainSection = const MainSection();
  final PageSection _statsSection = const StatsSection();

  PageSection? _section;

  _PageState() {
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
      body: _section,
    );
  }

  void _setSection(PageSection section) {
    setState(() {
      _section = section;
    });
  }
}