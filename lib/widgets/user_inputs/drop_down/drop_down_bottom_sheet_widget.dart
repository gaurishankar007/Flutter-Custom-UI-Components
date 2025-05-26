import 'package:flutter/material.dart';

import '../../visual_layouts/text/text_widget.dart';
import '../bottom_sheet/bottom_sheet_title_widget.dart';
import '../bottom_sheet/generic_bottom_sheet.dart';
import '../form/text_field_widget.dart';

/// A customizable dropdown widget that displays a list of selectable items in a bottom sheet.
///
/// This widget allows users to select an item from a list, which is displayed in a modal bottom sheet.
/// It includes a title, optional label and hint text, and supports a callback function to handle
/// the selected value. The selected item is visually highlighted, and the widget updates its state
/// accordingly when an item is selected.
class DropdownBottomSheetWidget<T> extends StatefulWidget {
  final String title;
  final String? labelText;
  final String? hintText;
  final DropdownItem<T>? selectedItem;
  final List<DropdownItem<T>> items;
  final Function(T value) onChanged;

  const DropdownBottomSheetWidget({
    super.key,
    required this.title,
    this.labelText,
    this.hintText = "Select",
    required this.items,
    required this.onChanged,
    this.selectedItem,
  });

  @override
  State<DropdownBottomSheetWidget<T>> createState() =>
      _DropdownBottomSheetWidgetState();
}

class _DropdownBottomSheetWidgetState<T>
    extends State<DropdownBottomSheetWidget<T>> {
  DropdownItem<T>? _selectedValue;

  late TextEditingController controller;
  @override
  void initState() {
    super.initState();
    _selectedValue = widget.selectedItem;
    controller = TextEditingController(text: _selectedValue?.label);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          () => showGenericBottomSheet(context, child: _buildDropdownItems()),
      child: ListenableBuilder(
        listenable: controller,
        builder: (context, child) {
          return TextFieldWidget(
            enabled: false,
            controller: controller,
            labelText: widget.labelText,
            hintText: widget.hintText,
            suffixIcon: const Icon(
              Icons.keyboard_arrow_down,
              color: Colors.grey,
            ),
          );
        },
      ),
    );
  }

  Column _buildDropdownItems() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        BottomSheetTitleWidget(title: widget.title),
        SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: StatefulBuilder(
            builder: (builderContext, setState) {
              return ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.items.length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) {
                  final dropDownData = widget.items[index];
                  return GestureDetector(
                    onTap: () {
                      setState(() => _selectedValue = dropDownData);
                      controller.text = dropDownData.label;
                      widget.onChanged(dropDownData.value);
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        color:
                            _selectedValue?.value == dropDownData.value
                                ? Colors.lightBlueAccent
                                : Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextWidget(dropDownData.label),
                          _selectedValue?.value == dropDownData.value
                              ? const Icon(
                                Icons.radio_button_checked,
                                color: Colors.blue,
                              )
                              : const Icon(
                                Icons.radio_button_off,
                                color: Colors.grey,
                              ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class DropdownItem<T> {
  final T value;
  final String label;

  const DropdownItem({required this.value, required this.label});

  @override
  bool operator ==(covariant DropdownItem<T> other) {
    if (identical(this, other)) return true;

    return other.value == value && other.label == label;
  }

  @override
  int get hashCode => value.hashCode ^ label.hashCode;
}
