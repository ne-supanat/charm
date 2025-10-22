import 'package:flutter/material.dart';

class AppTextFormField extends StatelessWidget {
  const AppTextFormField({super.key, this.controller, this.onChanged, this.hintText});

  final TextEditingController? controller;
  final Function(String value)? onChanged;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(hintText: hintText),
        onChanged: onChanged,
      ),
    );
  }
}
