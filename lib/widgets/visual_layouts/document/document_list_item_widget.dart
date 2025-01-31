import 'package:flutter/material.dart';

import '../../../utils/app_color.dart';
import '../../../utils/ui_helper.dart';
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
      contentPadding: UIHelper.sMediumHSmallVPadding,
      visualDensity: const VisualDensity(vertical: -2),
      tileColor: AppColor.highlight,
      shape: RoundedRectangleBorder(
        borderRadius: UIHelper.smallCRadius,
        side: const BorderSide(color: AppColor.containerBorder),
      ),
      leading: Container(
        padding: UIHelper.xSmallAllPadding,
        decoration: const BoxDecoration(
          color: AppColor.primary,
          shape: BoxShape.circle,
        ),
        child: Icon(
          documentIconData,
          color: AppColor.white,
          size: 18,
        ),
      ),
      title: TextWidget(title),
      trailing: trailing,
    );
  }
}
