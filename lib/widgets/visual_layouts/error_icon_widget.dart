import 'package:flutter/material.dart';

class ErrorIconWidget extends StatelessWidget {
  final double? height;
  final double? width;

  const ErrorIconWidget({super.key, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: const Icon(Icons.error_rounded, color: Colors.red),
    );
  }
}
