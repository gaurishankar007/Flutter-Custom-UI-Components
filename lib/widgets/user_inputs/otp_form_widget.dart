import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import '../../utils/app_color.dart';
import '../../utils/ui_helper.dart';

class OTPFormWidget extends StatelessWidget {
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final bool hasError;

  const OTPFormWidget({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.hasError,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: UIHelper.xLargeVPadding,
      child: Pinput(
        controller: controller,
        onChanged: onChanged,
        separatorBuilder: (index) => UIHelper.sMediumHSpace,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        defaultPinTheme: PinTheme(
          height: 60,
          decoration: BoxDecoration(
            borderRadius: UIHelper.smallCRadius,
            border: Border.all(
              color: hasError ? AppColor.error : AppColor.border,
            ),
          ),
          textStyle: const TextStyle(fontSize: 14),
        ),
      ),
    );
  }
}
