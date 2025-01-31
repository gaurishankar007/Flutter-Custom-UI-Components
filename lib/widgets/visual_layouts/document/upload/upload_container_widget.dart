import 'package:flutter/material.dart';

import '../../../painters/dotted_container_widget.dart';
import '../../../../utils/app_color.dart';
import '../../../../utils/ui_helper.dart';
import '../../text/text_widget.dart';

class UploadContainerWidget extends StatelessWidget {
  final int maxFileCount;
  const UploadContainerWidget({super.key, required this.maxFileCount});

  @override
  Widget build(BuildContext context) {
    return DottedContainerWidget(
      strokeColor: AppColor.primary,
      dashWidth: 6,
      gapWidth: 4,
      borderRadius: UIHelper.xSmallCRadius,
      child: Container(
        width: double.maxFinite,
        padding: UIHelper.largeAllPadding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 12,
          children: [
            const Icon(
              Icons.cloud_upload_outlined,
              color: AppColor.primary,
              size: 32,
            ),
            const TextWidget(
              "Click here to add files",
              color: AppColor.black,
            ),
            TextWidget(
              "Max $maxFileCount "
              "${maxFileCount > 1 ? "files are" : "file is"} allowed",
              color: AppColor.fade,
              textType: TextType.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
