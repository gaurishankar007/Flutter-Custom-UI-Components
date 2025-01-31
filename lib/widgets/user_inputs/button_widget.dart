import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../animations/explicit/loading_circle_widget.dart';
import '../visual_layouts/text/text_widget.dart';

class ButtonWidget extends HookWidget {
  final double? height;
  final double? width;
  final Function() onPressed;
  final String text;
  final Widget? icon;

  /// Background color for elevated button
  /// and border color for outlined button.
  final Color? color;
  final Color textColor;
  final TextType textType;
  final FontWeight textFontWeight;

  /// Align icon at centerLeft, center, and centerRight position.
  /// Alignment centerLeft and centerRight will expand the width of the button.
  final Alignment iconAlignment;
  final EdgeInsets? padding;
  final bool outlined;

  /// The disable button's onPressed is null
  final bool disabled;

  /// Show circular loading when the button is pressed.
  final bool loadableButton;
  final double? elevation;

  /// Expand the width of the button as much as possible.
  final bool expandWidth;

  const ButtonWidget({
    super.key,
    this.height,
    this.width,
    required this.onPressed,
    required this.text,
    this.icon,
    this.color,
    this.textColor = Colors.white,
    this.textType = TextType.bodyLarge,
    this.textFontWeight = FontWeight.normal,
    this.iconAlignment = Alignment.center,
    this.padding,
    this.outlined = false,
    this.disabled = false,
    this.loadableButton = false,
    this.elevation,
    this.expandWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    final loadingNotifier = useValueNotifier(false);
    final onTap = useCallback(() async {
      /// If the button is not loadable
      if (!loadableButton) return onPressed();

      loadingNotifier.value = true;
      await onPressed();
      loadingNotifier.value = false;
    });

    return SizedBox(
      height: height ?? 50,
      width: expandWidth ? double.maxFinite : width,
      child: ValueListenableBuilder(
        valueListenable: loadingNotifier,
        builder: (builderContext, loading, setState) {
          if (outlined) {
            return OutlinedButton(
              onPressed: disabled ? null : onTap,
              style: _buttonStyle(),
              child: _buttonChildWidget(loading),
            );
          }

          return ElevatedButton(
            onPressed: disabled ? null : onTap,
            style: _buttonStyle(),
            child: _buttonChildWidget(loading),
          );
        },
      ),
    );
  }

  TextWidget _textWidget() {
    return TextWidget(
      text,
      color: textColor,
      textType: textType,
      fontWeight: textFontWeight,
    );
  }

  Widget _buttonChildWidget(bool loading) {
    if (loading) return LoadingCircleWidget.small(color: Colors.white);
    if (icon == null) return _textWidget();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Align icon at center left
        if (iconAlignment == Alignment.centerLeft) ...[
          icon!,
          const Spacer(),
          _textWidget(),
          const Spacer(),
        ]
        // Align icon at center right
        else if (iconAlignment == Alignment.centerRight) ...[
          const Spacer(),
          _textWidget(),
          const Spacer(),
          icon!,
        ]
        // Align icon at center
        else ...[
          icon!,
          const SizedBox(height: 8),
          _textWidget(),
        ]
      ],
    );
  }

  ButtonStyle _buttonStyle() {
    if (outlined) {
      return OutlinedButton.styleFrom(
        foregroundColor: WidgetStateColor.resolveWith(
          (states) => const Color(0XFF99B0BF),
        ),
        padding: padding,
        shape: const StadiumBorder(),
        side: BorderSide(color: color ?? const Color(0XFF002D4D)),
        elevation: elevation,
        splashFactory: InkRipple.splashFactory,
      );
    }

    return ElevatedButton.styleFrom(
      padding: padding,
      backgroundColor: color ?? const Color(0xFF0A990A),
      disabledBackgroundColor: disabled ? const Color(0XFF717A80) : null,
      shape: const StadiumBorder(),
      elevation: elevation,
    );
  }
}
