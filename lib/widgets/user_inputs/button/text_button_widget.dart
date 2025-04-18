import 'package:flutter/material.dart';

import '../../animations/explicit/loading_circle_widget.dart';
import '../../visual_layouts/text/text_widget.dart';

class TextButtonWidget extends StatelessWidget {
  final Function() onPressed;
  final String text;
  final Color foregroundColor;
  final TextType textType;
  final FontWeight textFontWeight;
  final EdgeInsets? padding;
  final VisualDensity? visualDensity;
  final double? elevation;
  final OutlinedBorder? shape;
  final bool expanded;
  final bool disabled;
  final bool loading;

  const TextButtonWidget({
    super.key,
    required this.onPressed,
    required this.text,
    this.foregroundColor = Colors.blue,
    this.textType = TextType.bodyLarge,
    this.textFontWeight = FontWeight.normal,
    this.padding,
    this.visualDensity,
    this.elevation,
    this.shape,
    this.expanded = false,
    this.disabled = false,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    Widget child = TextButton(
      onPressed: disabled ? null : onPressed,
      style: TextButton.styleFrom(
        foregroundColor: foregroundColor,
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 4),
        visualDensity:
            visualDensity ?? const VisualDensity(horizontal: -4, vertical: -4),
        shape: shape ??
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        elevation: elevation,
      ),
      child: TextWidget(
        text,
        textType: textType,
        fontWeight: textFontWeight,
      ),
    );

    if (loading) child = LoadingCircleWidget.small(color: Colors.white);

    if (expanded) {
      child = SizedBox(
        height: 50,
        width: double.maxFinite,
        child: child,
      );
    }

    return child;
  }
}
