import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/screen_util/screen_util.dart';
import '../../../utils/ui_helpers.dart';
import '../text/text_widget.dart';

/// A flexible, reusable widget that displays a draggable bottom sheet with dynamic sizing.
///
/// ## Use Cases:
/// - Use this widget when you want to present content in a bottom sheet that can be expanded or collapsed by the user.
/// - The widget is ideal for scenarios where you have a set of content that should always be visible (e.g., a summary or header),
///   and additional content that is only shown when the sheet is expanded (e.g., details, forms, or actions).
/// - The widget automatically calculates its minimum and maximum heights based on the content provided, ensuring a smooth UX.
/// - The bottom copyright widget is always shown at the bottom of the sheet.
class DraggableContentWidget extends StatefulWidget {
  /// Widgets that are always visible in the sheet, regardless of expansion state.
  final List<Widget> alwaysVisibleChildren;

  /// Widgets that are only visible when the sheet is expanded.
  final List<Widget> expandedOnlyChildren;

  const DraggableContentWidget({
    super.key,
    required this.alwaysVisibleChildren,
    required this.expandedOnlyChildren,
  });

  @override
  State<DraggableContentWidget> createState() => _DraggableContentWidgetState();
}

class _DraggableContentWidgetState extends State<DraggableContentWidget> {
  final _draggableScrollableController = DraggableScrollableController();
  final _alwaysVisibleContentKey = GlobalKey();
  final _copyRightContentKey = GlobalKey();
  final _expandedOnlyContentKey = GlobalKey();
  // Minimum height of the widget
  double _minChildSize = .25;
  // Maximum height of the widget
  double _maxChildSize = 1;

  @override
  void initState() {
    super.initState();
    // After the first frame, measure the content to set min/max sizes dynamically
    WidgetsBinding.instance.addPostFrameCallback((_) => _measureContent());
  }

  /// Measures the heights of the always-visible, expanded-only, and copyright content,
  /// and updates the min/max child sizes for the draggable sheet accordingly.
  void _measureContent() {
    // Get renderBox of each type of content
    final alwaysVisibleContentBox = _getRenderBox(_alwaysVisibleContentKey);
    final copyRightContentBox = _getRenderBox(_copyRightContentKey);
    final expandedOnlyContentBox = _getRenderBox(_expandedOnlyContentKey);

    if (alwaysVisibleContentBox == null ||
        copyRightContentBox == null ||
        expandedOnlyContentBox == null) {
      return;
    }

    // Update min/max child size based on the height of the content
    setState(() {
      final minHeight =
          alwaysVisibleContentBox.size.height + copyRightContentBox.size.height;
      final maxHeight = minHeight + expandedOnlyContentBox.size.height;
      _minChildSize = (minHeight / ScreenUtil.I.height).clamp(0.01, 1);
      _maxChildSize = (maxHeight / ScreenUtil.I.height).clamp(0.01, 1);
    });
  }

  /// Helper to get the RenderBox for a given GlobalKey.
  RenderBox? _getRenderBox(GlobalKey key) =>
      key.currentContext?.findRenderObject() as RenderBox?;

  @override
  void dispose() {
    _draggableScrollableController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      controller: _draggableScrollableController,
      initialChildSize: _maxChildSize,
      minChildSize: _minChildSize,
      maxChildSize: _maxChildSize,
      snap: true,
      snapSizes: [_minChildSize, _maxChildSize],
      builder: (context, scrollController) {
        return DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: UIHelpers.largeTRadius,
            gradient: LinearGradient(
              colors: [
                AppColors.primary.withAlpha(25),
                AppColors.primary.withAlpha(127),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: [
              Flexible(
                child: ListView(
                  controller: scrollController,
                  padding: UIHelpers.sMediumHPadding,
                  children: [
                    Column(
                      key: _alwaysVisibleContentKey,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        UIHelpers.xSmallVSpace,
                        Center(
                          child: SizedBox(
                            width: 96,
                            height: 6,
                            child: DecoratedBox(
                              decoration: ShapeDecoration(
                                shape: StadiumBorder(),
                                color: AppColors.dashedBorder,
                              ),
                            ),
                          ),
                        ),
                        UIHelpers.largeVSpace,
                        ...widget.alwaysVisibleChildren,
                      ],
                    ),
                    Column(
                      key: _expandedOnlyContentKey,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: widget.expandedOnlyChildren,
                    ),
                  ],
                ),
              ),
              SafeArea(
                top: false,
                minimum: kIsWeb ? EdgeInsets.only(bottom: 16) : EdgeInsets.zero,
                child: TextWidget(
                  "© UI Component 2025",
                  color: AppColors.black60,
                  textType: TextType.bodySmall,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
