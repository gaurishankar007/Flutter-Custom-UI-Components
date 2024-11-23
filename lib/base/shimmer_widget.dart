import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  final Color? baseColor;
  final Color? highlightColor;
  final Color? containerColor;
  final double height;
  final double width;
  final BorderRadius? borderRadius;

  const ShimmerWidget({
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
      baseColor: baseColor ?? Colors.grey.withOpacity(.5),
      highlightColor: highlightColor ?? Colors.grey.withOpacity(.3),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: containerColor ?? Colors.grey.withOpacity(.5),
          borderRadius: borderRadius,
        ),
      ),
    );
  }
}
