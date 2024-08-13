// ignore: file_names
import 'package:flutter/material.dart';

class TextEditingField extends StatelessWidget {
  final TextEditingController controller;
  final bool obscureText;
  final String hintText;
  final Icon? prefixIcon;
  final InputBorder border;
  final TextInputType keyboardType;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  final String? Function(String?)? validation;
  const TextEditingField({
    super.key,
    required this.controller,
    required this.hintText,
    this.prefixIcon,
    this.border = const OutlineInputBorder(),
    this.keyboardType = TextInputType.text,
    this.hintStyle,
    this.textStyle,
    this.validation,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      controller: controller,
      keyboardType: keyboardType,
      validator: validation,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: hintStyle,
        prefixIcon: prefixIcon,
        border: border,
      ),
      style: textStyle,
    );
  }
}
