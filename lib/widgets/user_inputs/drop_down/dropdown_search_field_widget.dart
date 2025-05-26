import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/ui_helpers.dart';
import '../form/text_field_widget.dart';

/// A dropdown search field widget that combines a text field with a dropdown overlay for item selection.
///
/// This widget allows users to type in a text field and displays a dropdown overlay with selectable items.
/// It supports features like custom item widgets, separators, and dynamic updates to the overlay content.
/// The overlay is automatically shown or hidden based on the provided list of items.
class DropdownSearchFieldWidget<T> extends StatefulWidget {
  final TextEditingController? controller;
  final Function(String?)? onChanged;
  final String hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  /// Whenever this list changes, the overlay will be updated.
  /// Overlay will be shown only when the list is not empty.
  final List<T> overlayItems;
  final Widget Function(T) overlayItemWidget;
  final Widget? overlayItemSeparatorWidget;

  /// The gap between the overlay and the text field;
  final double overlayGap;
  final double? overlayHeight;
  final EdgeInsets? overlayPadding;

  const DropdownSearchFieldWidget({
    super.key,
    this.controller,
    this.onChanged,
    this.hintText = "",
    this.prefixIcon,
    this.suffixIcon,
    required this.overlayItems,
    required this.overlayItemWidget,
    this.overlayItemSeparatorWidget,
    this.overlayGap = 8,
    this.overlayHeight,
    this.overlayPadding,
  });

  @override
  State<DropdownSearchFieldWidget<T>> createState() =>
      _SearchDropdownFieldWidgetState<T>();
}

class _SearchDropdownFieldWidgetState<T>
    extends State<DropdownSearchFieldWidget<T>> {
  final GlobalKey _textFieldKey = GlobalKey();
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  List<T> _items = [];

  @override
  void initState() {
    super.initState();
    _items = widget.overlayItems;
    safeCallback(_showOverlay);
  }

  @override
  void didUpdateWidget(covariant DropdownSearchFieldWidget<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    /// Update overlay if the items are changed
    if (oldWidget.overlayItems != widget.overlayItems) {
      _items = widget.overlayItems;
      safeCallback(_updateOverlay);
    }
  }

  @override
  void dispose() {
    _hideOverlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: TextFieldWidget(
        key: _textFieldKey,
        controller: widget.controller,
        onChanged: widget.onChanged,
        hintText: widget.hintText,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon,
      ),
    );
  }

  /// Show overlay entry if the items are not empty
  void _showOverlay() {
    if (_items.isEmpty) return;
    _overlayEntry = _buildOverlay();
    Overlay.of(context).insert(_overlayEntry!);
  }

  /// Update overlay entry if the items are changed
  void _updateOverlay() {
    if (_items.isEmpty) return _hideOverlay();
    if (_overlayEntry == null) return _showOverlay();
    _overlayEntry?.markNeedsBuild();
  }

  /// Remove and dispose the overlay entry
  void _hideOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  /// This method is called only after the widget is laid out.
  void safeCallback(Function() callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) => callback.call());
  }

  /// Build the popup widget ath the right position with the provided items
  OverlayEntry _buildOverlay() {
    final renderBox =
        _textFieldKey.currentContext?.findRenderObject() as RenderBox?;

    /// Check condition if widget hasn't been laid out yet or
    /// the layout might have completed yet and size is not available yet
    if (renderBox == null || !renderBox.hasSize) {
      return OverlayEntry(builder: (_) => UIHelpers.nothing);
    }

    final size = renderBox.size;

    return OverlayEntry(
      builder: (context) {
        return Positioned(
          width: size.width,
          child: CompositedTransformFollower(
            link: _layerLink,
            showWhenUnlinked: false,
            offset: Offset(0, size.height + widget.overlayGap),
            child: Material(child: _buildOverlayContainer()),
          ),
        );
      },
    );
  }

  /// Build the overlay container that shows the overlay items
  Widget _buildOverlayContainer() {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: UIHelpers.xSmallCRadius,
        border: Border.all(color: AppColors.black25),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 1),
            blurRadius: 20,
            color: AppColors.black.withAlpha(25),
          ),
        ],
      ),
      child: SizedBox(
        height: widget.overlayHeight,
        child: ListView.separated(
          padding: widget.overlayPadding ?? UIHelpers.smallAllPadding,
          shrinkWrap: true,
          itemCount: widget.overlayItems.length,
          separatorBuilder: (context, index) {
            return widget.overlayItemSeparatorWidget ?? UIHelpers.xSmallVSpace;
          },
          itemBuilder: (context, index) {
            return widget.overlayItemWidget(widget.overlayItems[index]);
          },
        ),
      ),
    );
  }
}
