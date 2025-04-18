import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../utils/app_color.dart';
import '../../../utils/ui_helper.dart';
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
    final colorNotifier = useValueNotifier(AppColor.primary);

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
            colorNotifier.value = AppColor.black25;
          } else if (states.contains(WidgetState.pressed)) {
            colorNotifier.value = AppColor.primary;
          } else if (states.contains(WidgetState.hovered)) {
            colorNotifier.value = AppColor.primary;
          } else {
            colorNotifier.value = AppColor.black70;
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
          if (isPrefixIcon) ...[icon!, UIHelper.xSmallHSpace],
          TextWidget(text!, decorationColor: decorationColor),
          if (!isPrefixIcon) ...[UIHelper.xSmallHSpace, icon!],
        ],
      );
    }

    return icon ?? SizedBox.shrink();
  }
}
