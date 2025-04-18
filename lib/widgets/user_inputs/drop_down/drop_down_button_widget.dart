import 'package:flutter/material.dart';

import '../../visual_layouts/text/text_widget.dart';

class DropDownButtonWidget<T> extends StatelessWidget {
  final T? selectedValue;
  final List<DropdownItem<T>> items;
  final Function(T?)? onChanged;

  const DropDownButtonWidget({
    super.key,
    required this.selectedValue,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0XFF002D4D)),
      ),
      alignment: Alignment.center,
      child: ButtonTheme(
        alignedDropdown: true,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: DropdownButton<T>(
          value: selectedValue,
          isExpanded: true,
          icon: const Icon(
            Icons.keyboard_arrow_down,
            color: Colors.black,
          ),
          iconEnabledColor: Colors.black.withAlpha(153),
          iconSize: 25,
          underline: const SizedBox(),
          onChanged: onChanged,
          dropdownColor: Colors.white,
          borderRadius: BorderRadius.circular(12),
          items: items.map<DropdownMenuItem<T>>(
            (dropDownItem) {
              return DropdownMenuItem<T>(
                value: dropDownItem.value,
                child: TextWidget(
                  dropDownItem.label,
                  overflow: TextOverflow.ellipsis,
                  fontWeight: FontWeight.w500,
                ),
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}

/// Holds dropdown visible text and value associated with it.
/// Value will be returned on changing dropdown item.
/// [label] is the text which will be displayed.
class DropdownItem<T> {
  final T? value;
  final String label;

  const DropdownItem({
    required this.value,
    required this.label,
  });

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
