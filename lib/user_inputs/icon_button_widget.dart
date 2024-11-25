import 'package:flutter/material.dart';

class IconButtonWidget extends StatelessWidget {
  final Function() onPressed;
  final Icon icon;
  final EdgeInsets? padding;
  final VisualDensity? visualDensity;
  final bool disableSplash;
  final double? containerSize;
  final Color? containerColor;

  const IconButtonWidget({
    super.key,
    required this.onPressed,
    required this.icon,
    this.padding,
    this.visualDensity,
    this.disableSplash = false,
    this.containerSize,
    this.containerColor,
  });

  @override
  Widget build(BuildContext context) {
    Widget child = IconButton(
      onPressed: onPressed,
      focusColor: Colors.transparent,
      padding: padding ?? EdgeInsets.zero,
      visualDensity: visualDensity,
      highlightColor: disableSplash ? Colors.transparent : null,
      icon: icon,
    );

    if (disableSplash) child = noSplashWidget(child);
    if (containerSize != null) child = containerWidget(child);

    return child;
  }

  factory IconButtonWidget.container({
    required Function() onPressed,
    required IconData iconData,
    EdgeInsets? padding,
    VisualDensity? visualDensity,
    bool disableSplash = false,
    double? containerSize,
    Color? containerColor,
  }) {
    return IconButtonWidget(
      onPressed: onPressed,
      icon: Icon(
        iconData,
        size: 16,
        color: Colors.white,
      ),
      padding: padding,
      visualDensity: visualDensity,
      disableSplash: disableSplash,
      containerSize: containerSize ?? 30,
      containerColor: containerColor ?? Colors.grey.withOpacity(.6),
    );
  }

  Theme noSplashWidget(Widget child) => Theme(
        data: ThemeData(splashFactory: NoSplash.splashFactory),
        child: child,
      );

  Container containerWidget(Widget child) {
    BoxDecoration? decoration;
    if (containerColor != null) {
      decoration = BoxDecoration(
        color: containerColor,
        shape: BoxShape.circle,
      );
    }

    return Container(
      height: containerSize,
      width: containerSize,
      decoration: decoration,
      child: child,
    );
  }
}
