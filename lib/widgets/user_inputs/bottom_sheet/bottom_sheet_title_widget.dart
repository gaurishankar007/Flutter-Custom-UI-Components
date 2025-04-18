import 'package:flutter/material.dart';

import '../../visual_layouts/text/text_widget.dart';

class BottomSheetTitleWidget extends StatelessWidget {
  final String title;
  final Alignment titleAlignment;
  final Color? titleColor;

  const BottomSheetTitleWidget({
    super.key,
    required this.title,
    this.titleAlignment = Alignment.centerLeft,
    this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Align(
                  alignment: titleAlignment,
                  child: TextWidget.bodyLarge(
                    title,
                    color: titleColor ?? Colors.blueAccent,
                  ),
                ),
              ),
              InkWell(
                onTap: () => Navigator.pop(context),
                customBorder: const CircleBorder(),
                child: const Icon(Icons.close, size: 30),
              ),
            ],
          ),
        ),
        const Divider(height: 1, color: Colors.grey),
      ],
    );
  }
}
