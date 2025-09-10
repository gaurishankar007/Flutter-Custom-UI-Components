import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../utils/ui_helpers.dart';
import '../../base_text.dart';

class UploadIconContainer extends StatelessWidget {
  final IconData iconData;
  final String text;
  final VoidCallback onTap;

  const UploadIconContainer({
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
      borderRadius: UIHelpers.smallCRadius,
      child: Ink(
        padding: UIHelpers.xLargeAllPadding,
        decoration: BoxDecoration(
          color: AppColors.highlight,
          borderRadius: UIHelpers.smallCRadius,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 54,
              width: 54,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: Icon(iconData, color: AppColors.white),
            ),
            UIHelpers.xSmallVSpace,
            BaseText(text, fontSize: 16),
          ],
        ),
      ),
    );
  }
}
