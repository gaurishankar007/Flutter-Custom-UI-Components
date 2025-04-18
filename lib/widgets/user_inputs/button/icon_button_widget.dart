import 'package:flutter/material.dart';

import '../../../utils/ui_helper.dart';

class IconButtonWidget extends StatelessWidget {
  final Function() onPressed;
  final Icon icon;
  final EdgeInsets? padding;
  final Size? minimumSize;
  final bool disableSplash;
  final bool disabled;

  const IconButtonWidget({
    super.key,
    required this.onPressed,
    required this.icon,
    this.padding,
    this.minimumSize,
    this.disableSplash = false,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    Widget child = IconButton(
      onPressed: disabled ? null : onPressed,
      style: IconButton.styleFrom(
        padding: padding ?? UIHelper.xSmallAllPadding,
        minimumSize: minimumSize ?? Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        overlayColor: disableSplash ? Colors.transparent : null,
      ),
      icon: icon,
    );

    return child;
  }
}
