import 'package:flutter/material.dart';

class MainAppBar extends AppBar {
  final BuildContext context;
  final String? heading;
  
  MainAppBar({
    super.key, 
    required this.context, 
    this.heading,
  }) : super (
    title: Text(
      heading??"",
      style: Theme.of(context).textTheme.displayMedium,
    ),
    leading: Builder(
      builder: (BuildContext context) {
        return IconButton(
          icon: const Icon(Icons.gite_rounded),
          onPressed: () => Scaffold.of(context).openDrawer(),
          tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
        );
      },
    )
  );
}