import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../user_inputs/button/icon_button_widget.dart';

class MediaPlayButtonWidget extends StatelessWidget {
  final ValueNotifier<bool> playingNotifier;
  final Function() onPressed;

  const MediaPlayButtonWidget({
    super.key,
    required this.playingNotifier,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: playingNotifier,
      builder: (context, playing, child) {
        return IconButtonWidget(
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
