import 'package:flutter/material.dart';

class ErrorIndicator extends StatelessWidget {
  final double? dimension;
  final double? iconSize;
  const ErrorIndicator({super.key, this.dimension, this.iconSize});

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: dimension,
      child: Center(
        child: Icon(
          Icons.error_outline_rounded,
          color: Colors.red,
          size: iconSize,
        ),
      ),
    );
  }
}
