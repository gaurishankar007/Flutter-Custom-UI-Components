import 'package:flutter/material.dart';

import '../cupertino_loading.dart';
import '../error_indicator.dart';

class BaseAssetImage extends StatelessWidget {
  final ImageProvider? imageProvider;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final BorderRadius? borderRadius;
  final bool circular;

  const BaseAssetImage({
    super.key,
    this.imageProvider,
    this.width,
    this.height,
    this.fit,
    this.borderRadius,
    this.circular = false,
  });

  @override
  Widget build(BuildContext context) {
    Widget child = Image(
      width: width,
      height: height,
      image: imageProvider!,
      fit: fit,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return CupertinoLoading();
      },
      errorBuilder: (context, error, stackTrace) => ErrorIndicator(),
    );

    if (circular) {
      child = ClipOval(child: child);
    } else if (borderRadius != null) {
      child = ClipRRect(borderRadius: borderRadius!, child: child);
    }

    return child;
  }

  factory BaseAssetImage.circular({
    required double diameter,
    String imageUrl = "",
    ImageProvider? imageProvider,
  }) {
    return BaseAssetImage(
      height: diameter,
      width: diameter,
      fit: BoxFit.cover,
      circular: true,
      imageProvider: imageProvider,
    );
  }
}
