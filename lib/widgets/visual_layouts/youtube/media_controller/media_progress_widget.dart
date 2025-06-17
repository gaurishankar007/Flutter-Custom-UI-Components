import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../utils/extensions/duration_extension.dart';
import '../../text/text_widget.dart';

class MediaProgressWidget extends StatelessWidget {
  final int positionInSeconds;
  final int durationInSeconds;

  const MediaProgressWidget({
    super.key,
    required this.positionInSeconds,
    required this.durationInSeconds,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextWidget(
          Duration(seconds: positionInSeconds).formatDuration(),
          color: AppColors.white,
        ),
        TextWidget(
          " / ${Duration(seconds: durationInSeconds).formatDuration()}",
          color: AppColors.white,
        ),
      ],
    );
  }
}
