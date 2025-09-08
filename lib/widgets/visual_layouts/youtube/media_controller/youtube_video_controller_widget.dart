import 'dart:async';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../../../../../../core/constants/app_colors.dart';
import '../../../../utils/ui_helpers.dart';
import 'media_play_button_widget.dart';
import 'media_play_seek_button_widget.dart';
import 'media_playback_speed_widget.dart';
import 'media_progress_widget.dart';
import 'media_seeker_widget.dart';
import 'media_volume_button_widget.dart';

class YoutubeVideoControllerWidget extends StatefulWidget {
  final YoutubePlayerController controller;
  final ValueNotifier<bool> visibilityNotifier;

  const YoutubeVideoControllerWidget({
    super.key,
    required this.controller,
    required this.visibilityNotifier,
  });

  @override
  State<YoutubeVideoControllerWidget> createState() =>
      _YoutubeVideoControllerWidgetState();
}

class _YoutubeVideoControllerWidgetState
    extends State<YoutubeVideoControllerWidget> {
  late final YoutubePlayerController _controller;
  late final Timer _updateTimer;

  final _playingNotifier = ValueNotifier<bool>(true);
  final _volumeNotifier = ValueNotifier<int>(100);
  final _playbackRateNotifier = ValueNotifier<double>(1.0);
  final _positionNotifier = ValueNotifier<double>(0);
  final _bufferedNotifier = ValueNotifier<double>(0);

  /// The elapsed time in seconds since the video started playing
  double _currentTime = 0;

  /// The duration in seconds of the currently playing video
  double _duration = 0;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller;
    _listenControllerChanges();
  }

  @override
  void dispose() {
    _updateTimer.cancel();
    _playingNotifier.dispose();
    _volumeNotifier.dispose();
    _playbackRateNotifier.dispose();
    _positionNotifier.dispose();
    _bufferedNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget playSeekButtonWidget = MediaPlaySeekButtonWidget(
      playingNotifier: _playingNotifier,
      onPlayPauseTap: _onPlayPause,
      onReplayForward: _onReplayForward,
    );

    Widget controllerWidget = Padding(
      padding: kIsWeb ? UIHelpers.xSmallHPadding : UIHelpers.smallHPadding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MediaSeekerWidget(
            positionNotifier: _positionNotifier,
            bufferedNotifier: _bufferedNotifier,
            onChanged: _onPositionChanged,
          ),
          UIHelpers.xxSmallVSpace,
          Row(
            children: [
              if (kIsWeb)
                playSeekButtonWidget
              else
                MediaPlayButtonWidget(
                  playingNotifier: _playingNotifier,
                  onPressed: _onPlayPause,
                ),
              UIHelpers.xSmallHSpace,
              MediaVolumeButtonWidget(
                volumeNotifier: _volumeNotifier,
                onVolumeChange: _onVolumeChanged,
              ),
              UIHelpers.smallHSpace,
              ValueListenableBuilder(
                valueListenable: _positionNotifier,
                builder: (context, position, child) {
                  return MediaProgressWidget(
                    positionInSeconds: (position * _duration).toInt(),
                    durationInSeconds: _duration.toInt(),
                  );
                },
              ),
              Spacer(),
              MediaPlaybackSpeedWidget(
                playbackRateNotifier: _playbackRateNotifier,
                onRateChanged: _onPlaybackRateChanged,
              ),
            ],
          ),
        ],
      ),
    );

    if (kIsWeb) return controllerWidget;

    // Add visibility option for mobile platforms
    return ValueListenableBuilder(
      valueListenable: widget.visibilityNotifier,
      builder: (context, show, child) {
        if (!show) return UIHelpers.nothing;
        return DecoratedBox(
          decoration: BoxDecoration(color: AppColors.black.withAlpha(127)),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              controllerWidget,
              Align(alignment: Alignment.center, child: playSeekButtonWidget),
            ],
          ),
        );
      },
    );
  }

  /// Updates the player media values periodically
  void _listenControllerChanges() {
    _updateTimer = Timer.periodic(const Duration(milliseconds: 500), (_) async {
      try {
        if (!context.mounted) return;
        if (_duration == 0) _duration = await _controller.duration;

        _bufferedNotifier.value = await _controller.videoLoadedFraction;
        _currentTime = await _controller.currentTime;
        if (_playingNotifier.value) _updatePosition();
      } catch (_) {}
    });
  }

  /// Updates elapsed time
  void _updatePosition() {
    if (!context.mounted || _duration == 0 || _currentTime == 0) return;

    // A number between 0 and 1 that specifies the percentage of time elapsed.
    final elapsedValue = (_currentTime / _duration).clamp(0, 1).toDouble();
    _positionNotifier.value = elapsedValue;
  }

  /// Seeks the player to the given position
  Future<void> _onPositionChanged(double value) async {
    // Update slider value
    _positionNotifier.value = value;
    // Seek to the new position in YouTube Player
    final position = value * _duration;
    await _controller.seekTo(seconds: position, allowSeekAhead: true);
  }

  // Seek to 5 seconds backward or  forward
  Future<void> _onReplayForward(bool isReplay) async {
    int seconds = 5;
    if (isReplay) seconds *= -1;

    // Keeping the position in the range of the duration
    final position = (_currentTime + seconds).clamp(0, _duration).toDouble();
    final seekPosition = (position / _duration).clamp(0, 1).toDouble();
    _positionNotifier.value = seekPosition;
    await _controller.seekTo(seconds: position, allowSeekAhead: true);
  }

  Future<void> _onPlayPause() async {
    _playingNotifier.value
        ? await _controller.pauseVideo()
        : await _controller.playVideo();
    _playingNotifier.value = !_playingNotifier.value;
  }

  Future<void> _onVolumeChanged(double value) async {
    final volume = value.round();
    _volumeNotifier.value = volume;
    await _controller.setVolume(volume);
  }

  Future<void> _onPlaybackRateChanged(double playbackRate) async {
    _playbackRateNotifier.value = playbackRate;
    await _controller.setPlaybackRate(playbackRate);
  }
}
