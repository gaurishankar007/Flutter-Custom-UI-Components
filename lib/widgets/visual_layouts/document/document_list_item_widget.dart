import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/ui_helpers.dart';
import '../text/text_widget.dart';

class DocumentListItemWidget extends StatelessWidget {
  final VoidCallback? onTap;
  final IconData documentIconData;
  final String title;
  final Widget? trailing;

  const DocumentListItemWidget({
    super.key,
    this.onTap,
    required this.documentIconData,
    required this.title,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      dense: true,
      minVerticalPadding: 1,
      horizontalTitleGap: 8,
      contentPadding: UIHelpers.sMediumHSmallVPadding,
      visualDensity: const VisualDensity(vertical: -2),
      tileColor: AppColors.highlight,
      shape: RoundedRectangleBorder(
        borderRadius: UIHelpers.smallCRadius,
        side: const BorderSide(color: AppColors.containerBorder),
      ),
      leading: Container(
        padding: UIHelpers.xSmallAllPadding,
        decoration: const BoxDecoration(
          color: AppColors.primary,
          shape: BoxShape.circle,
        ),
        child: Icon(documentIconData, color: AppColors.white, size: 18),
      ),
      title: TextWidget(title),
      trailing: trailing,
    );
  }
}
