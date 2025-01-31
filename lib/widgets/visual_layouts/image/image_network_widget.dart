import 'package:flutter/material.dart';

import '../cupertino_loading_widget.dart';
import '../error_indicator_widget.dart';

class ImageNetworkWidget extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final BorderRadius? borderRadius;

  const ImageNetworkWidget({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: Image(
        width: width,
        height: height,
        fit: fit,
        image: NetworkImage(imageUrl),
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return CupertinoLoadingWidget(dimension: width);
        },
        errorBuilder: (context, error, stackTrace) =>
            ErrorIndicatorWidget(dimension: width),
      ),
    );
  }
}
