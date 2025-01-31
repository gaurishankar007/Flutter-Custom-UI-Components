import 'dart:io';

import 'package:flutter/material.dart';

import '../../../user_inputs/bottom_sheet/generic_bottom_sheet.dart';
import '../../../../utils/app_color.dart';
import '../../../../utils/ui_helper.dart';
import '../../text/text_widget.dart';
import '../models/document_type.dart';
import 'document_upload_bottom_sheet_widget.dart';
import 'upload_container_widget.dart';

class DocumentUploadWidget extends StatelessWidget {
  /// A callback functions for providing list of selected images
  final Function(List<File> imageFiles) onSelection;
  final bool multiSelector;
  final int maxFileCount;

  /// Allows to pick specific file types
  final DocumentType documentType;

  const DocumentUploadWidget({
    super.key,
    this.multiSelector = true,
    required this.onSelection,
    required this.maxFileCount,
    required this.documentType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: () => showGenericBottomSheet(
            context,
            child: DocumentUploadBottomSheetWidget(
              multiSelector: multiSelector,
              onSelection: onSelection,
              documentType: documentType,
            ),
          ),
          borderRadius: UIHelper.xSmallCRadius,
          splashFactory: InkSplash.splashFactory,
          splashColor: AppColor.highlight,
          child: UploadContainerWidget(maxFileCount: maxFileCount),
        ),
        UIHelper.xSmallVSpace,
        TextWidget(
          "Only support "
          "${documentType.allowedFileTypes.join(", ")} files.",
          color: AppColor.fade,
          textType: TextType.bodySmall,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
