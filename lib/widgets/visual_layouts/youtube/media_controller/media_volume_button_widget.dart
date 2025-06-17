import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../utils/debounce_time.dart';
import '../../../../utils/ui_helpers.dart';
import '../../slider_widget.dart';

class MediaVolumeButtonWidget extends HookWidget {
  final ValueNotifier<int> volumeNotifier;
  final Function(double) onVolumeChange;

  const MediaVolumeButtonWidget({
    super.key,
    required this.volumeNotifier,
    required this.onVolumeChange,
  });

  @override
  Widget build(BuildContext context) {
    final showVolumeSlider = useState(false);
    final debounceTime = useMemoized(
      () => DebounceTime(delay: Duration(seconds: 3)),
    );
    final showSlider = useCallback(() {
      // Show slider only if it is not shown
      if (!showVolumeSlider.value) showVolumeSlider.value = true;
      debounceTime.run(() => showVolumeSlider.value = false);
    });

    return ValueListenableBuilder(
      valueListenable: volumeNotifier,
      builder: (context, volume, child) {
        IconData icon = Icons.volume_up_sharp;
        if (volume == 0) {
          icon = Icons.volume_off_sharp;
        } else if (volume < 100) {
          icon = Icons.volume_down_sharp;
        }

        return Listener(
          behavior: HitTestBehavior.translucent,
          onPointerDown: (event) => showSlider(),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: AppColors.white, size: 28),
              if (showVolumeSlider.value) ...[
                UIHelpers.xxSmallHSpace,
                SizedBox(
                  width: 60,
                  child: SliderWidget(
                    value: volume.clamp(0, 100).toDouble(),
                    max: 100,
                    activeColor: AppColors.white,
                    inactiveColor: AppColors.black.withAlpha(97),
                    thumbColor: AppColors.white,
                    onChanged: onVolumeChange,
                  ),
                ),
                UIHelpers.xxSmallHSpace,
              ],
            ],
          ),
        );
      },
    );
  }
}
