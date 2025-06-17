import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../utils/ui_helpers.dart';
import '../../../painters/dotted_container_widget.dart';
import '../../text/text_widget.dart';

class UploadContainerWidget extends StatelessWidget {
  final int maxFileCount;
  const UploadContainerWidget({super.key, required this.maxFileCount});

  @override
  Widget build(BuildContext context) {
    return DottedContainerWidget(
      strokeColor: AppColors.primary,
      dashWidth: 6,
      gapWidth: 4,
      borderRadius: UIHelpers.xSmallCRadius,
      child: Container(
        width: double.maxFinite,
        padding: UIHelpers.largeAllPadding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 12,
          children: [
            const Icon(
              Icons.cloud_upload_outlined,
              color: AppColors.primary,
              size: 32,
            ),
            const TextWidget("Click here to add files", color: AppColors.black),
            TextWidget(
              "Max $maxFileCount "
              "${maxFileCount > 1 ? "files are" : "file is"} allowed",
              color: AppColors.fade,
              textType: TextType.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
