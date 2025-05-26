import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/ui_helpers.dart';
import '../../visual_layouts/text/text_widget.dart';

class LinkButtonWidget extends HookWidget {
  final Function() onTap;
  final String? text;
  final FontWeight? textFontWeight;
  final Widget? icon;
  final bool isPrefixIcon;
  final double? height;
  final double? width;
  final EdgeInsets? padding;

  /// Whether the button color should be changed or not based on the widget state.
  final bool fixedColor;
  final bool isLoadable;
  final bool disabled;

  const LinkButtonWidget({
    super.key,
    required this.onTap,
    this.text,
    this.textFontWeight,
    this.icon,
    this.isPrefixIcon = true,
    this.height,
    this.width,
    this.padding,
    this.fixedColor = false,
    this.isLoadable = false,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorNotifier = useValueNotifier(AppColors.primary);

    return TextButton(
      onPressed: disabled ? null : onTap.call,
      style: ButtonStyle(
        padding: WidgetStatePropertyAll(EdgeInsets.zero),
        minimumSize: WidgetStatePropertyAll(Size.zero),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        overlayColor: WidgetStatePropertyAll(Colors.transparent),
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (fixedColor) return colorNotifier.value;
          if (states.contains(WidgetState.disabled)) {
            colorNotifier.value = AppColors.black25;
          } else if (states.contains(WidgetState.pressed)) {
            colorNotifier.value = AppColors.primary;
          } else if (states.contains(WidgetState.hovered)) {
            colorNotifier.value = AppColors.primary;
          } else {
            colorNotifier.value = AppColors.black70;
          }

          return colorNotifier.value;
        }),
      ),
      child: ValueListenableBuilder(
        valueListenable: colorNotifier,
        builder: (builderContext, color, setState) {
          return _buildChild(color);
        },
      ),
    );
  }

  Widget _buildChild(Color decorationColor) {
    if (text != null && icon == null) {
      return TextWidget(text!, decorationColor: decorationColor);
    }
    if (text != null && icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isPrefixIcon) ...[icon!, UIHelpers.xSmallHSpace],
          TextWidget(text!, decorationColor: decorationColor),
          if (!isPrefixIcon) ...[UIHelpers.xSmallHSpace, icon!],
        ],
      );
    }

    return icon ?? SizedBox.shrink();
  }
}
