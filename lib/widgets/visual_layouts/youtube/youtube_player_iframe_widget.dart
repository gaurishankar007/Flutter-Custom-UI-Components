import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../utils/debounce_time.dart';
import '../error_icon_widget.dart';
import 'media_controller/youtube_video_controller_widget.dart';

class YoutubePlayerIframeWidget extends StatefulWidget {
  final String videoUrl;
  final double aspectRatio;
  final double? width;
  final Function(YoutubePlayerController controller)? onControllerReady;

  const YoutubePlayerIframeWidget({
    super.key,
    required this.videoUrl,
    this.aspectRatio = 16 / 9,
    this.width,
    this.onControllerReady,
  });

  @override
  State<YoutubePlayerIframeWidget> createState() =>
      _YoutubePlayerIframeWidgetState();
}

class _YoutubePlayerIframeWidgetState extends State<YoutubePlayerIframeWidget> {
  late final YoutubePlayerController _controller;
  final _debounceTime = DebounceTime(delay: Duration(seconds: 3));
  final _visibilityNotifier = ValueNotifier(true);
  String _videoId = "";

  @override
  void initState() {
    super.initState();

    // Initialize the controller with the video Id
    _videoId = YoutubePlayerController.convertUrlToId(widget.videoUrl) ?? "";
    _controller = YoutubePlayerController.fromVideoId(
      videoId: _videoId,
      params: YoutubePlayerParams(
        strictRelatedVideos: true,
        loop: true,
        showVideoAnnotations: false,
        showControls: false,
        enableCaption: false,
        pointerEvents: PointerEvents.none,
      ),
      autoPlay: true,
    );
    // Notify when the controller is ready
    widget.onControllerReady?.call(_controller);
    // Hide the controller after a delay
    _hideController();
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_videoId.isEmpty) return ErrorIconWidget(width: widget.width);

    Widget videoPlayerWidget = YoutubePlayer(
      controller: _controller,
      aspectRatio: widget.aspectRatio,
    );
    Widget controllerWidget = YoutubeVideoControllerWidget(
      controller: _controller,
      visibilityNotifier: _visibilityNotifier,
    );

    if (kIsWeb) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(child: videoPlayerWidget),
          DecoratedBox(
            decoration: BoxDecoration(color: AppColors.black.withAlpha(51)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: controllerWidget,
            ),
          ),
        ],
      );
    }
    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerDown: (event) => _showController(),
      child: Stack(
        children: [
          IgnorePointer(child: videoPlayerWidget),
          AspectRatio(aspectRatio: widget.aspectRatio, child: controllerWidget),
        ],
      ),
    );
  }

  // Show the controller only if it is not shown
  void _showController() {
    if (!_visibilityNotifier.value) _visibilityNotifier.value = true;
    _hideController();
  }

  void _hideController() =>
      _debounceTime.run(() => _visibilityNotifier.value = false);
}
