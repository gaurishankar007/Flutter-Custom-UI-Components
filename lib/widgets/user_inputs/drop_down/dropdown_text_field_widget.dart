import 'package:flutter/material.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../utils/ui_helpers.dart';
import '../../visual_layouts/text/text_widget.dart';
import '../form/text_field_widget.dart';
import '../overlay/overlay_decoration_widget.dart';

/// A text field widget with a dropdown menu overlay for selecting items.
///
/// Displays a read-only text field that, when tapped, shows a dropdown overlay with selectable items.
/// The overlay appears below the field and is dismissed when an item is selected or tapped on the text field again.
/// The selected item's label is shown in the text field, and a callback is triggered on selection.
/// Supports custom title, hint text, prefix icon, max menu height/width, and item list.
class DropdownButtonWidget<T> extends StatefulWidget {
  final String? title;
  final String hintText;
  final Widget? prefixIcon;
  final double menuMaxHeight;
  final double? menuMaxWidth;
  final DropdownItem<T>? selectedItem;
  final List<DropdownItem<T>> items;
  final Function(T value) onChanged;

  const DropdownButtonWidget({
    super.key,
    this.title,
    this.hintText = "Choose an option",
    this.prefixIcon,
    this.menuMaxHeight = double.infinity,
    this.menuMaxWidth,
    required this.items,
    required this.onChanged,
    this.selectedItem,
  });

  @override
  State<DropdownButtonWidget<T>> createState() =>
      _DropdownButtonWidgetState<T>();
}

class _DropdownButtonWidgetState<T> extends State<DropdownButtonWidget<T>> {
  late final TextEditingController _controller;
  final GlobalKey _textFieldKey = GlobalKey();
  final LayerLink _layerLink = LayerLink();
  final _menuVisibilityNotifier = ValueNotifier(false);
  OverlayEntry? _overlayEntry;
  DropdownItem<T>? _selectedItem;
  List<DropdownItem<T>> _items = [];

  @override
  void initState() {
    super.initState();
    _selectedItem = widget.selectedItem;
    _items = widget.items;
    _controller = TextEditingController(text: _selectedItem?.label);
  }

  @override
  void dispose() {
    _controller.dispose();
    _hideOverlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget child = CompositedTransformTarget(
      link: _layerLink,
      child: TextFieldWidget(
        key: _textFieldKey,
        controller: _controller,
        readOnly: true,
        onTap: _showOverlay,
        hintText: widget.hintText,
        prefixIcon: widget.prefixIcon,
        suffixIcon: ValueListenableBuilder(
          valueListenable: _menuVisibilityNotifier,
          builder: (context, isMenuShowed, child) {
            return Icon(
              isMenuShowed
                  ? Icons.keyboard_arrow_up
                  : Icons.keyboard_arrow_down,
              size: 24,
              color: AppColors.black.withAlpha(222),
            );
          },
        ),
      ),
    );

    if (widget.title == null) return child;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 4,
      children: [TextWidget(widget.title!), child],
    );
  }

  /// Show overlay entry if the items are not empty
  void _showOverlay() {
    if (_items.isEmpty) return;
    if (_overlayEntry != null) {
      _hideOverlay();
      return;
    }

    _overlayEntry = _buildOverlay();
    Overlay.of(context).insert(_overlayEntry!);
  }

  /// Remove and dispose the overlay entry
  void _hideOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
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

    final height = renderBox.size.height;
    final width = renderBox.size.width;
    final maxWidth = widget.menuMaxWidth?.clamp(width * .1, width) ?? width;

    return OverlayEntry(
      builder: (context) {
        return Positioned(
          width: maxWidth,
          child: CompositedTransformFollower(
            link: _layerLink,
            showWhenUnlinked: false,
            offset: Offset(0, height + 4),
            child: _buildOverlayContainer(),
          ),
        );
      },
    );
  }

  /// Build the overlay container that shows the overlay items
  Widget _buildOverlayContainer() {
    return OverlayDecorationWidget(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: widget.menuMaxHeight),
        child: Material(
          color: Colors.transparent,
          child: ListView.separated(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: widget.items.length,
            separatorBuilder: (context, index) => UIHelpers.xxSmallVSpace,
            itemBuilder: (context, index) {
              final item = widget.items[index];
              return InkWell(
                onTap: () => _onDropdownItemSelect(item),
                child: Padding(
                  padding: UIHelpers.sMediumHSmallVPadding,
                  child: TextWidget(item.label),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _onDropdownItemSelect(DropdownItem<T> item) {
    _hideOverlay();
    if (_selectedItem == item) return;

    _controller.text = item.label;
    _selectedItem = item;
    if (item.value != null) widget.onChanged(item.value as T);
  }
}

/// Holds dropdown visible text and value associated with it.
/// Value will be returned on changing dropdown item.
/// [label] is the text which will be displayed.
class DropdownItem<T> {
  final T? value;
  final String label;

  const DropdownItem({required this.value, required this.label});

  @override
  String toString() => 'DropDownItem(value: $value, label: $label)';

  @override
  bool operator ==(covariant DropdownItem<T> other) {
    if (identical(this, other)) return true;
    return other.value == value && other.label == label;
  }

  @override
  int get hashCode => value.hashCode ^ label.hashCode;
}
