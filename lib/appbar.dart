import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BMIAppBar extends AppBar {
  final BuildContext context;
  final String? heading;
  
  BMIAppBar({
    super.key, 
    required this.context, 
    this.heading,
  }) : super (
    title: Text(
      heading??"",
      style: GoogleFonts.ubuntuMono(textStyle: Theme.of(context).textTheme.displayMedium),
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