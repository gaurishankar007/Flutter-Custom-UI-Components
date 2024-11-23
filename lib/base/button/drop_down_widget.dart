import 'package:flutter/material.dart';

import '../text/text_widget.dart';

class DropDownWidget<T> extends StatelessWidget {
  final T? selectedValue;
  final List<DropDownItem> items;
  final Function(T?)? onChanged;

  const DropDownWidget({
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
          iconEnabledColor: Colors.black.withOpacity(.6),
          iconSize: 25,
          underline: const SizedBox(),
          onChanged: onChanged,
          dropdownColor: Colors.white,
          borderRadius: BorderRadius.circular(12),
          items: items.map<DropdownMenuItem<T>>(
            (DropDownItem dropDownValue) {
              return DropdownMenuItem<T>(
                value: dropDownValue.value,
                child: TextWidget(
                  dropDownValue.text,
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
class DropDownItem<T> {
  final T? value;
  final String text;

  const DropDownItem({
    required this.value,
    required this.text,
  });
}
