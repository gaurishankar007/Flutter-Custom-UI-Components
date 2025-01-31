import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../cupertino_loading_widget.dart';
import '../error_indicator_widget.dart';

class ImageCachedNetworkWidget extends StatelessWidget {
  final String? imageUrl;
  final double? width;
  final double? height;
  final int? cacheHeight;
  final int? cacheWidth;
  final BoxShape boxShape;
  final BoxFit? fit;
  final BorderRadius? borderRadius;

  const ImageCachedNetworkWidget({
    super.key,
    this.imageUrl,
    this.fit = BoxFit.contain,
    this.boxShape = BoxShape.circle,
    this.height,
    this.width,
    this.cacheHeight,
    this.cacheWidth,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    if (imageUrl != null && imageUrl?.isNotEmpty == true) {
      return const ErrorIndicatorWidget();
    }

    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: CachedNetworkImage(
        width: width,
        height: height,
        memCacheHeight: cacheHeight,
        memCacheWidth: cacheWidth,
        fit: fit,
        imageUrl: imageUrl!,
        placeholder: (context, url) => CupertinoLoadingWidget(),
        errorWidget: (_, __, ___) => const ErrorIndicatorWidget(),
      ),
    );
  }
}
