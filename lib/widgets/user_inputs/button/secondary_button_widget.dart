import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../core/constants/app_colors.dart';
import '../../../utils/ui_helpers.dart';
import '../../visual_layouts/loading_circle_widget.dart';
import '../../visual_layouts/text/text_widget.dart';

class SecondaryButtonWidget extends HookWidget {
  final Function()? onTap;
  final String? text;
  final FontWeight? textFontWeight;
  final Widget? icon;
  final bool isPrefixIcon;
  final double? height;
  final double? width;
  final bool expandWidth;
  final bool isLoadable;
  final bool disabled;

  const SecondaryButtonWidget({
    super.key,
    this.onTap,
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
      if (!isLoadable) return onTap?.call();

      loadingNotifier.value = true;
      await onTap?.call();
      // If the widget is disposed, don't update value
      if (context.mounted) loadingNotifier.value = false;
    });

    return SizedBox(
      height: height,
      width: expandWidth ? double.maxFinite : width,
      child: OutlinedButton(
        onPressed: disabled ? null : onPressed.call,
        style: ButtonStyle(
          padding: WidgetStatePropertyAll(_getPadding()),
          minimumSize: WidgetStatePropertyAll(Size.zero),
          overlayColor: WidgetStatePropertyAll(Colors.transparent),
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return AppColors.primary;
            } else if (states.contains(WidgetState.pressed)) {
              return AppColors.primary;
            } else if (states.contains(WidgetState.hovered)) {
              return AppColors.primary;
            }
            return AppColors.black70;
          }),
          side: WidgetStateBorderSide.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return BorderSide(color: AppColors.primary, width: 1.5);
            } else if (states.contains(WidgetState.pressed)) {
              // Always check for pressed before hovered, because hovered is also included inside pressed
              // So it might reflect hovered state instead of pressed state
              return BorderSide(color: AppColors.primary, width: 1.5);
            } else if (states.contains(WidgetState.hovered)) {
              return BorderSide(color: AppColors.primary, width: 1.5);
            }
            return BorderSide(color: AppColors.primary, width: 1.5);
          }),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: UIHelpers.xSmallCRadius),
          ),
        ),
        child: ValueListenableBuilder(
          valueListenable: loadingNotifier,
          builder: (_, loading, __) => _buildChild(loading),
        ),
      ),
    );
  }

  EdgeInsets _getPadding() {
    double verticalPadding = kIsWeb ? 20 : 16;
    double leftPadding = isPrefixIcon && icon != null ? 16 : 24;
    double rightPadding = !isPrefixIcon && icon != null ? 16 : 24;

    return EdgeInsets.only(
      top: verticalPadding,
      bottom: verticalPadding,
      left: leftPadding,
      right: rightPadding,
    );
  }

  Widget _buildChild(bool loading) {
    if (loading) return LoadingCircleWidget.small(AppColors.primary);
    if (text != null && icon == null) return TextWidget(text!);
    if (text != null && icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isPrefixIcon) ...[icon!, UIHelpers.xSmallHSpace],
          TextWidget(text!),
          if (!isPrefixIcon) ...[UIHelpers.xSmallHSpace, icon!],
        ],
      );
    }

    return icon ?? SizedBox.shrink();
  }
}
