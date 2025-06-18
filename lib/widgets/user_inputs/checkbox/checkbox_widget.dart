import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../utils/ui_helpers.dart';
import '../../visual_layouts/text/text_widget.dart';

class CheckboxWidget extends HookWidget {
  final bool? value;
  final Function(bool?)? onChanged;
  final String? label;

  const CheckboxWidget({super.key, this.value, this.onChanged, this.label});

  @override
  Widget build(BuildContext context) {
    final checkboxState = useState(value);
    final callback = useCallback((bool? value) {
      checkboxState.value = value;
      onChanged?.call(value);
    });
    final isDisabled = onChanged == null;

    Widget child = UnconstrainedBox(
      child: Transform.scale(
        scale: 1.3,
        child: Checkbox(
          value: checkboxState.value,
          tristate: true,
          onChanged: isDisabled ? null : callback,
        ),
      ),
    );

    if (label == null) return child;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        child,
        UIHelpers.xSmallHSpace,
        TextWidget(
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
