import 'package:flutter/material.dart';

import '../cupertino_loading_widget.dart';
import '../error_indicator_widget.dart';

class ImageAssetWidget extends StatelessWidget {
  final ImageProvider? imageProvider;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final BorderRadius? borderRadius;
  final bool circular;

  const ImageAssetWidget({
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
        return CupertinoLoadingWidget();
      },
      errorBuilder: (context, error, stackTrace) => ErrorIndicatorWidget(),
    );

    if (circular) {
      child = ClipOval(child: child);
    } else if (borderRadius != null) {
      child = ClipRRect(
        borderRadius: borderRadius!,
        child: child,
      );
    }

    return child;
  }

  factory ImageAssetWidget.circular({
    required double diameter,
    String imageUrl = "",
    ImageProvider? imageProvider,
  }) {
    return ImageAssetWidget(
      height: diameter,
      width: diameter,
      fit: BoxFit.cover,
      circular: true,
      imageProvider: imageProvider,
    );
  }
}
