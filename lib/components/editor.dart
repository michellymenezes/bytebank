import 'package:flutter/material.dart';

class Editor extends StatelessWidget {
  final String hint;
  final String label;
  final TextEditingController controller;
  final IconData icon;
  final bool autofocus;
  final bool hasError;
  final void Function(String) onChanged;

  const Editor({
    this.controller,
    this.label,
    this.hint,
    this.icon,
    this.onChanged,
    this.autofocus = false,
    this.hasError = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
      child: TextField(
        // Map values
        controller: controller,
        style: TextStyle(fontSize: 24.0),
        onChanged: onChanged,
        decoration: InputDecoration(
          icon: icon != null ? Icon(this.icon) : null,
          labelText: label,
          hintText: hint,
          focusedBorder: new OutlineInputBorder(
            borderSide:
                new BorderSide(color: hasError ? Colors.red : Colors.teal),
          ),
        ),
        keyboardType: TextInputType.number,
        autofocus: autofocus,
      ),
    );
  }
}
