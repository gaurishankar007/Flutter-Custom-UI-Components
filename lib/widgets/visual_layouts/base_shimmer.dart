import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class BaseShimmer extends StatelessWidget {
  final Color? baseColor;
  final Color? highlightColor;
  final Color? containerColor;
  final double height;
  final double width;
  final BorderRadius? borderRadius;

  const BaseShimmer({
    super.key,
    this.baseColor,
    this.highlightColor,
    this.containerColor,
    required this.height,
    required this.width,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor ?? Colors.grey.withAlpha(125),
      highlightColor: highlightColor ?? Colors.grey.withAlpha(75),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: containerColor ?? Colors.grey.withAlpha(125),
          borderRadius: borderRadius,
        ),
      ),
    );
  }
}
