import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../../../core/constants/app_colors.dart';
import '../images/base_cached_network_image.dart';

class YoutubeThumbnail extends StatelessWidget {
  final Function()? onTap;
  final String videoUrl;
  final double? height;
  final double? width;

  const YoutubeThumbnail({
    super.key,
    this.onTap,
    required this.videoUrl,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          BaseCachedNetworkImage(
            url: _getThumbnailUrl(),
            height: height,
            width: width,
            fit: BoxFit.cover,
          ),
          LayoutBuilder(
            builder: (context, constraints) {
              return Icon(
                Icons.play_arrow_rounded,
                color: AppColors.white,
                size: constraints.maxWidth * .45,
              );
            },
          ),
        ],
      ),
    );
  }

  String _getThumbnailUrl() {
    try {
      final videoId = YoutubePlayerController.convertUrlToId(videoUrl) ?? "";
      return YoutubePlayerController.getThumbnail(videoId: videoId);
    } catch (_) {
      return "";
    }
  }
}
