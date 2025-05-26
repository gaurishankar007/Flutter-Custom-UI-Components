import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final Function(String?)? onChanged;
  final String? initialValue;
  final String? Function(String?)? validator;
  final bool enabled;
  final String? labelText;
  final String? hintText;
  final Widget? prefixIcon;
  final BoxConstraints? prefixIconConstraints;
  final Widget? suffixIcon;
  final BoxConstraints? suffixIconConstraints;

  const TextFieldWidget({
    super.key,
    this.controller,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.initialValue,
    this.validator,
    this.enabled = true,
    this.labelText,
    this.hintText,
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
      style: const TextStyle(fontSize: 14, color: Colors.black),
      decoration: InputDecoration(
        enabled: enabled,
        label: labelText != null ? Text(labelText!) : null,
        hintText: hintText,
        prefixIconConstraints: prefixIconConstraints,
        prefixIcon: prefixIcon,
        suffixIconConstraints: suffixIconConstraints,
        suffixIcon: suffixIcon,
        enabledBorder: _textFiledBorder(Colors.grey),
        focusedBorder: _textFiledBorder(Colors.grey),
        disabledBorder: _textFiledBorder(Colors.grey),
        errorBorder: _textFiledBorder(Colors.red),
        focusedErrorBorder: _textFiledBorder(Colors.red),
      ),
    );
  }

  OutlineInputBorder _textFiledBorder(Color borderColor) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(color: borderColor),
      );
}
