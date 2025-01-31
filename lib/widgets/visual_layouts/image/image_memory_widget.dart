import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../../../utils/ui_helper.dart';
import '../error_indicator_widget.dart';


class ImageMemoryWidget extends StatelessWidget {
  /// image bytes data
  final Uint8List? uint8List;

  /// encoded image data
  final String? base64;

  final double? height;
  final double? width;
  final int? cacheHeight;
  final int? cacheWidth;
  final bool isCircular;
  final BoxFit? fit;
  final BorderRadius? borderRadius;

  const ImageMemoryWidget({
    super.key,
    this.uint8List,
    this.base64,
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
    if (base64 == null && uint8List == null) return UIHelper.nothing;

    Widget child = Image.memory(
      _getImageBytes(),
      height: height,
      width: width,
      cacheHeight: cacheHeight,
      cacheWidth: cacheWidth,
      fit: fit,
      errorBuilder: (_, __, ___) => const ErrorIndicatorWidget(),
    );

    if (isCircular) {
      return ClipOval(child: child);
    } else if (borderRadius != null) {
      return ClipRRect(
        borderRadius: borderRadius!,
        child: child,
      );
    }

    return child;
  }

  Uint8List _getImageBytes() {
    if (uint8List?.isNotEmpty == true) {
      return uint8List!;
    } else if (base64?.isNotEmpty == true) {
      try {
        return base64Decode(base64!);
      } catch (_) {}
    }

    return Uint8List.fromList([]);
  }
}
