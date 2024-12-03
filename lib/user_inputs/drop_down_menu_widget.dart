import 'package:flutter/material.dart';

/// The [width] of the dropdown menu will also decide
/// the width of the popup container.
class DropDownMenuWidget<T> extends StatelessWidget {
  final double? width;
  final Widget? label;
  final String? hintText;
  final bool enableFilter;
  final bool enableSearch;
  final TextEditingController? controller;
  final T? initialSelection;
  final Function(T?)? onSelected;
  final FilterCallback<T>? filterCallback;
  final SearchCallback<T>? searchCallback;
  final List<DropdownMenuEntry<T>> entries;

  const DropDownMenuWidget({
    super.key,
    this.width,
    this.label,
    this.hintText,
    this.enableFilter = false,
    this.enableSearch = true,
    this.controller,
    this.initialSelection,
    this.onSelected,
    this.filterCallback,
    this.searchCallback,
    required this.entries,
  });

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      alignedDropdown: true,
      child: DropdownMenu<T>(
        width: width,
        label: label,
        hintText: hintText,
        enableFilter: enableFilter,
        enableSearch: enableSearch,
        controller: controller,
        initialSelection: initialSelection,
        onSelected: onSelected,
        requestFocusOnTap: true,
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        menuStyle: const MenuStyle(
          backgroundColor: WidgetStatePropertyAll(Colors.lightBlue),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
          ),
        ),
        filterCallback: filterCallback,
        searchCallback: searchCallback,
        dropdownMenuEntries: entries
            .map<DropdownMenuEntry<T>>(
              (dropDownItem) => DropdownMenuEntry<T>(
                value: dropDownItem.value,
                label: dropDownItem.label,
              ),
            )
            .toList(),
      ),
    );
  }
}

/// Holds dropdown visible text and value associated with it.
/// Value will be returned on changing dropdown item.
/// [label] is the text which will be displayed.
class DropDownEntry<T> {
  final T value;
  final String label;

  const DropDownEntry({
    required this.value,
    required this.label,
  });

  @override
  String toString() => 'DropDownItem(value: $value, label: $label)';

  @override
  bool operator ==(covariant DropDownEntry<T> other) {
    if (identical(this, other)) return true;

    return other.value == value && other.label == label;
  }

  @override
  int get hashCode => value.hashCode ^ label.hashCode;
}
