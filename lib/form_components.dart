import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LabelledTextField extends StatelessWidget {
  final String? label;
  final String? placeholder;
  final ValueChanged<String>? onChanged;

  const LabelledTextField({
    super.key, 
    this.label, 
    this.placeholder,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 8.0),
          child: Text(
            label??"",
            style: GoogleFonts.ubuntuMono(textStyle: Theme.of(context).textTheme.titleMedium),
            textAlign: TextAlign.left,
          ),
        ),
      ),
      TextField(
        decoration: InputDecoration(
          hintText: placeholder??"",
          hintStyle: GoogleFonts.ubuntuMono(),
        ),
        keyboardType: TextInputType.number,
        onChanged: onChanged,
      )
    ]);
  }
}

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
          style: GoogleFonts.ubuntuMono(textStyle: Theme.of(context).textTheme.displayLarge),
        )
      ),
    );
  }
}

class LabelledButton extends StatelessWidget {
  final String label;
  final void Function() onPressed;

  const LabelledButton({
    super.key, 
    required this.label, 
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(15),
      ),
      onPressed: onPressed,
      child: Text(
        label,
        style: GoogleFonts.ubuntuMono(textStyle: Theme.of(context).textTheme.headlineMedium),
      ),
    );
  }
}