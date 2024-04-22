import 'package:flutter/material.dart';

class LabeledButton extends StatelessWidget {
  final String label;
  final void Function() onPressed;

  const LabeledButton({
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
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
}