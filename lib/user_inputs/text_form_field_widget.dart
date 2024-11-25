import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final Function(String?)? onChanged;
  final String? initialValue;
  final String? Function(String?)? validator;
  final String labelText;
  final Widget? prefixIcon;
  final BoxConstraints? prefixIconConstraints;
  final Widget? suffixIcon;
  final BoxConstraints? suffixIconConstraints;

  const TextFormFieldWidget({
    super.key,
    this.controller,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.initialValue,
    this.validator,
    required this.labelText,
    this.prefixIcon,
    this.prefixIconConstraints,
    this.suffixIcon,
    this.suffixIconConstraints,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      onChanged: onChanged,
      initialValue: initialValue,
      obscureText: obscureText,
      obscuringCharacter: "*",
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: const TextStyle(fontSize: 14),
      decoration: InputDecoration(
        label: Text(labelText),
        prefixIconConstraints: prefixIconConstraints,
        prefixIcon: prefixIcon,
        suffixIconConstraints: suffixIconConstraints,
        suffixIcon: suffixIcon,
      ),
    );
  }
}
