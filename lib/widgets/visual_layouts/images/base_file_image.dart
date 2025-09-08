import 'dart:io';

import 'package:flutter/material.dart';

import '../cupertino_loading.dart';
import '../error_indicator.dart';

class BaseFileImage extends StatelessWidget {
  final File file;
  final double? height;
  final double? width;
  final int? cacheHeight;
  final int? cacheWidth;
  final BoxFit? fit;
  final bool isCircular;
  final BorderRadius? borderRadius;

  const BaseFileImage({
    super.key,
    required this.file,
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
    Widget child = Image.file(
      file,
      height: height,
      width: width,
      cacheHeight: cacheHeight,
      cacheWidth: cacheWidth,
      fit: fit,
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        if (frame != null) return child;
        return CupertinoLoading(dimension: height);
      },
      errorBuilder: (_, __, ___) => const ErrorIndicator(),
    );

    if (isCircular) {
      return ClipOval(child: child);
    } else if (borderRadius != null) {
      return ClipRRect(borderRadius: borderRadius!, child: child);
    }

    return child;
  }
}
