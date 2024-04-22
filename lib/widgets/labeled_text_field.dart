import 'package:flutter/material.dart';

class LabeledTextField extends StatelessWidget {
  final String? label;
  final String? placeholder;
  final ValueChanged<String>? onChanged;

  const LabeledTextField({
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
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.left,
          ),
        ),
      ),
      TextField(
        decoration: InputDecoration(
          hintText: placeholder??"",
        ),
        keyboardType: TextInputType.number,
        onChanged: onChanged,
      )
    ]);
  }
}