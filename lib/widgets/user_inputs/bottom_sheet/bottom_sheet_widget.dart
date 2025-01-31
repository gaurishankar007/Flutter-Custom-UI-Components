import 'package:flutter/cupertino.dart';

import 'bottom_sheet_body_widget.dart';
import 'bottom_sheet_title_widget.dart';

class BottomSheetWidget extends StatelessWidget {
  final String title;
  final Alignment titleAlignment;
  final List<Widget> children;

  const BottomSheetWidget({
    super.key,
    required this.title,
    this.titleAlignment = Alignment.centerLeft,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BottomSheetTitleWidget(
          title: title,
          titleAlignment: titleAlignment,
        ),
        BottomSheetBodyWidget(
          children: children,
        ),
      ],
    );
  }
}
