import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../user_inputs/button/base_icon_button.dart';

class MediaPlayButton extends StatelessWidget {
  final ValueNotifier<bool> playingNotifier;
  final Function() onPressed;

  const MediaPlayButton({
    super.key,
    required this.playingNotifier,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: playingNotifier,
      builder: (context, playing, child) {
        return BaseIconButton(
          onPressed: onPressed,
          icon: Icon(
            playing ? Icons.pause : Icons.play_arrow,
            size: 28,
            color: AppColors.white,
          ),
          padding: EdgeInsets.zero,
          disableSplash: true,
        );
      },
    );
  }
}
