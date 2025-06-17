import 'package:flutter/material.dart';

import '../../../utils/ui_helpers.dart';
import '../../visual_layouts/text/text_widget.dart';

class OverlayButtonWidget extends StatelessWidget {
  final String label;
  final Function() onTap;
  final TextAlign? labelAlignment;

  const OverlayButtonWidget({
    super.key,
    required this.label,
    required this.onTap,
    this.labelAlignment,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: UIHelpers.sMediumHSmallVPadding,
        child: TextWidget(label, textAlign: labelAlignment),
      ),
    );
  }
}
