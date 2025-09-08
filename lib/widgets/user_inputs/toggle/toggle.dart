import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../utils/ui_helpers.dart';
import '../../visual_layouts/text/base_text.dart';

class Toggle extends HookWidget {
  final bool value;
  final Function(bool)? onChanged;
  final String? label;

  const Toggle({
    super.key,
    this.value = false,
    this.onChanged,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    final switchState = useState(value);
    final callback = useCallback((bool value) {
      switchState.value = value;
      onChanged?.call(value);
    });
    final isDisabled = onChanged == null;

    Widget child = UnconstrainedBox(
      child: SizedBox(
        width: 40,
        child: FittedBox(
          fit: BoxFit.fitWidth,
          child: Switch(
            value: switchState.value,
            onChanged: isDisabled ? null : callback,
          ),
        ),
      ),
    );

    if (label == null) return child;
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        child,
        UIHelpers.xSmallHSpace,
        BaseText(
          label!,
          color:
              isDisabled
                  ? AppColors.black.withAlpha(97)
                  : AppColors.black.withAlpha(222),
        ),
      ],
    );
  }
}
