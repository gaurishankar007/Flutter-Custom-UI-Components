import 'package:flutter/material.dart';

import '../../../../utils/app_color.dart';
import '../../../../utils/ui_helper.dart';
import '../../text/text_widget.dart';

class UploadIconContainerWidget extends StatelessWidget {
  final IconData iconData;
  final String text;
  final VoidCallback onTap;

  const UploadIconContainerWidget({
    super.key,
    required this.iconData,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        onTap.call();
      },
      borderRadius: UIHelper.smallCRadius,
      child: Ink(
        padding: UIHelper.xLargeAllPadding,
        decoration: BoxDecoration(
          color: AppColor.highlight,
          borderRadius: UIHelper.smallCRadius,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 54,
              width: 54,
              decoration: const BoxDecoration(
                  color: AppColor.primary, shape: BoxShape.circle),
              child: Icon(iconData, color: AppColor.white),
            ),
            UIHelper.xSmallVSpace,
            TextWidget.bodyLarge(text)
          ],
        ),
      ),
    );
  }
}
