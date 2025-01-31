import 'package:flutter/material.dart';

import '../../user_inputs/bottom_sheet/bottom_sheet_title_widget.dart';
import '../../user_inputs/bottom_sheet/generic_bottom_sheet.dart';
import '../../../utils/app_color.dart';
import '../../../utils/ui_helper.dart';
import 'models/document_data.dart';

showDocumentBottomSheet(
  BuildContext context, {
  required DocumentData documentData,
  String? title,
  double? height,
  double? width,
}) =>
    showGenericBottomSheet(
      context,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BottomSheetTitleWidget(title: title ?? "Document"),
          Container(
            width: double.maxFinite,
            padding: UIHelper.sMediumAllPadding,
            color: AppColor.scaffold,
            child: documentData.build(
              width: width,
              height: height ?? 300,
            ),
          ),
        ],
      ),
    );
