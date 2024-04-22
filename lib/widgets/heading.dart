import 'package:flutter/material.dart';

class Heading extends StatelessWidget {
  final String heading;

  const Heading(
    this.heading,
    {super.key}
  );

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          heading,
          style: Theme.of(context).textTheme.displayLarge,
        )
      ),
    );
  }
}