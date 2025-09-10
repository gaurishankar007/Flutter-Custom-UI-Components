import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../utils/extensions/duration_extension.dart';
import '../../base_text.dart';

class MediaProgress extends StatelessWidget {
  final int positionInSeconds;
  final int durationInSeconds;

  const MediaProgress({
    super.key,
    required this.positionInSeconds,
    required this.durationInSeconds,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        BaseText(
          Duration(seconds: positionInSeconds).formatDuration(),
          color: AppColors.white,
        ),
        BaseText(
          " / ${Duration(seconds: durationInSeconds).formatDuration()}",
          color: AppColors.white,
        ),
      ],
    );
  }
}
