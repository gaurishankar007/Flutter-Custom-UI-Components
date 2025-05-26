import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../../../utils/ui_helpers.dart';
import '../cupertino_loading_widget.dart';
import '../error_indicator_widget.dart';

class ImageMemoryWidget extends StatelessWidget {
  /// image bytes data
  final Uint8List uint8List;
  final double? height;
  final double? width;
  final int? cacheHeight;
  final int? cacheWidth;
  final bool isCircular;
  final BoxFit? fit;
  final BorderRadius? borderRadius;

  const ImageMemoryWidget({
    super.key,
    required this.uint8List,
    this.height,
    this.width,
    this.cacheHeight,
    this.cacheWidth,
    this.isCircular = false,
    this.fit,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    if (uint8List.isEmpty) return UIHelpers.nothing;

    Widget child = Image.memory(
      uint8List,
      height: height,
      width: width,
      cacheHeight: cacheHeight,
      cacheWidth: cacheWidth,
      fit: fit,
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        if (frame != null) return child;
        return CupertinoLoadingWidget(dimension: height);
      },
      errorBuilder: (_, __, ___) => const ErrorIndicatorWidget(),
    );

    if (isCircular) {
      return ClipOval(child: child);
    } else if (borderRadius != null) {
      return ClipRRect(borderRadius: borderRadius!, child: child);
    }

    return child;
  }
}
