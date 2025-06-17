import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../cupertino_loading_widget.dart';
import '../error_indicator_widget.dart';

class CachedNetworkImageWidget extends StatelessWidget {
  final String? url;
  final double? width;
  final double? height;
  final int? cacheHeight;
  final int? cacheWidth;
  final BoxShape boxShape;
  final BoxFit? fit;
  final BorderRadius? borderRadius;

  const CachedNetworkImageWidget({
    super.key,
    this.url,
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
    if (url != null && url?.isNotEmpty == true) {
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
        imageUrl: url!,
        placeholder: (context, url) => CupertinoLoadingWidget(),
        errorWidget: (_, __, ___) => const ErrorIndicatorWidget(),
      ),
    );
  }
}
