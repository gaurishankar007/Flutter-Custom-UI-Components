import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedIndicatorWidget extends StatefulWidget {
  /// The number of indicators
  final int length;

  /// Active index
  final int activeIndex;

  /// height of the indicator
  final double height;

  /// Width of the indicator when not selected
  final double width;

  /// Width of the indicator when selected
  final double activeWidth;

  /// Width of the indicator when selected
  final double activeHeight;

  /// Color of the indicator when selected
  final Color? activeColor;

  /// Color of the indicator when not selected
  final Color? inactiveColor;

  /// Border radius of the active indicator
  final BorderRadius? inActiveBorderRadius;

  /// Border radius of the inactive indicator
  final BorderRadius? activeBorderRadius;

  /// space between the indicators
  final double spacing;

  const AnimatedIndicatorWidget({
    super.key,
    required this.length,
    this.activeIndex = 0,
    this.height = 6,
    this.width = 12,
    this.activeWidth = 24,
    this.activeHeight = 6,
    this.activeColor,
    this.inactiveColor,
    this.inActiveBorderRadius,
    this.activeBorderRadius,
    this.spacing = 5,
  });

  @override
  State<AnimatedIndicatorWidget> createState() =>
      _AnimatedIndicatorWidgetState();

  factory AnimatedIndicatorWidget.circular({
    required int length,
    int activeIndex = 0,
    double diameter = 8,
    double activeDiameter = 12,
    Color? activeColor,
    Color? inactiveColor,
    double spacing = 5,
  }) =>
      AnimatedIndicatorWidget(
        length: length,
        activeIndex: activeIndex,
        height: diameter,
        width: diameter,
        activeWidth: activeDiameter,
        activeHeight: activeDiameter,
        activeColor: activeColor,
        inactiveColor: inactiveColor,
        inActiveBorderRadius: BorderRadius.circular(diameter),
        activeBorderRadius: BorderRadius.circular(activeDiameter),
        spacing: spacing,
      );
}

class _AnimatedIndicatorWidgetState extends State<AnimatedIndicatorWidget> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.activeIndex;
  }

  @override
  void didUpdateWidget(covariant AnimatedIndicatorWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.activeIndex != widget.activeIndex) {
      setState(() => selectedIndex = widget.activeIndex);
    }
  }

  @override
  Widget build(BuildContext context) {
    final activeColor =
        widget.activeColor ?? Theme.of(context).colorScheme.primary;
    final inActiveColor = widget.inactiveColor ?? Colors.grey.shade400;

    return SizedBox(
      height: max(widget.height, widget.activeHeight),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: widget.length,
        separatorBuilder: (context, index) => SizedBox(width: widget.spacing),
        itemBuilder: (context, index) {
          Color color = inActiveColor;
          double? newWidth = widget.width;
          double? newHeight = widget.height;
          BorderRadius? borderRadius = widget.inActiveBorderRadius ??
              BorderRadius.circular(widget.height);

          // If it is the active index
          if (selectedIndex == index) {
            color = activeColor;
            newWidth = widget.activeWidth;
            newHeight = widget.activeHeight;
            borderRadius = widget.activeBorderRadius ??
                BorderRadius.circular(widget.activeHeight);
          }

          return Center(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: newHeight,
              width: newWidth,
              decoration: BoxDecoration(
                color: color,
                borderRadius: borderRadius,
              ),
            ),
          );
        },
      ),
    );
  }
}
