import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../utils/app_color.dart';
import '../../../utils/screen_util/screen_util.dart';
import '../../../utils/ui_helper.dart';
import '../../visual_layouts/loading_circle_widget.dart';
import '../../visual_layouts/text/text_widget.dart';

class PrimaryButtonWidget extends HookWidget {
  final Function() onTap;
  final String? text;
  final FontWeight? textFontWeight;
  final Widget? icon;
  final bool isPrefixIcon;
  final double? height;
  final double? width;
  final bool expandWidth;
  final bool isLoadable;
  final bool disabled;

  const PrimaryButtonWidget({
    super.key,
    required this.onTap,
    this.text,
    this.textFontWeight,
    this.icon,
    this.isPrefixIcon = true,
    this.height,
    this.width,
    this.expandWidth = false,
    this.isLoadable = false,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    final loadingNotifier = useValueNotifier(false);
    final onPressed = useCallback(() async {
      /// If the button is loading, discard the task
      if (loadingNotifier.value) return;
      // If the button is not loadable
      if (!isLoadable) return onTap();

      loadingNotifier.value = true;
      await onTap();
      // If the widget is disposed, don't update value
      if (context.mounted) loadingNotifier.value = false;
    });

    return SizedBox(
      height: height,
      width: expandWidth ? double.maxFinite : width,
      child: FilledButton(
        onPressed: disabled ? null : onPressed.call,
        style: ButtonStyle(
          padding: WidgetStatePropertyAll(
            ScreenUtil.I.adaptiveBound(
              baseValue: UIHelper.sMediumAllPadding,
              lowerBound: UIHelper.smallAllPadding,
            ),
          ),
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return AppColor.primary;
            } else if (states.contains(WidgetState.hovered)) {
              return AppColor.primary;
            } else if (states.contains(WidgetState.pressed)) {
              return AppColor.primary;
            }
            return AppColor.primary;
          }),
          minimumSize: WidgetStatePropertyAll(Size.zero),
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) return AppColor.white;
            return AppColor.white;
          }),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: UIHelper.xSmallCRadius),
          ),
        ),
        child: ValueListenableBuilder(
          valueListenable: loadingNotifier,
          builder: (builderContext, loading, setState) {
            return _buildChild(loading);
          },
        ),
      ),
    );
  }

  Widget _buildChild(bool loading) {
    if (loading) return LoadingCircleWidget.small(AppColor.white);
    if (text != null && icon == null) return TextWidget(text!);
    if (text != null && icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isPrefixIcon) ...[icon!, UIHelper.xSmallHSpace],
          TextWidget(text!),
          if (!isPrefixIcon) ...[UIHelper.xSmallHSpace, icon!],
        ],
      );
    }

    return icon ?? SizedBox.shrink();
  }
}
