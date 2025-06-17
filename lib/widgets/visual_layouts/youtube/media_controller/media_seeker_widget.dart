import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../slider_widget.dart';

class MediaSeekerWidget extends StatelessWidget {
  /// A stream of double between 0 to 1 of the current position of the media player.
  final ValueNotifier<double> positionNotifier;

  /// A stream of double between 0 and 1 that specifying the buffered percentage
  final ValueNotifier<double> bufferedNotifier;

  final Function(double value)? onChanged;
  final Function(double value)? onChangeStart;
  final Function(double value)? onChangeEnd;

  const MediaSeekerWidget({
    super.key,
    required this.positionNotifier,
    required this.bufferedNotifier,
    this.onChanged,
    this.onChangeStart,
    this.onChangeEnd,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        ValueListenableBuilder(
          valueListenable: bufferedNotifier,
          builder: (context, buffered, child) {
            return SliderWidget(
              value: buffered.clamp(0, 1),
              activeColor: AppColors.white.withAlpha(153),
              inactiveColor: kIsWeb ? AppColors.white.withAlpha(97) : AppColors.black.withAlpha(97),
              thumbRadius: 0,
              thumbColor: Colors.transparent,
            );
          },
        ),
        ValueListenableBuilder(
          valueListenable: positionNotifier,
          builder: (context, position, child) {
            return SliderWidget(
              value: position.clamp(0, 1),
              activeColor: AppColors.primary,
              inactiveColor: Colors.transparent,
              thumbColor: AppColors.primary,
              onChanged: onChanged,
              onChangeStart: onChangeStart,
              onChangeEnd: onChangeEnd,
            );
          },
        ),
      ],
    );
  }
}
