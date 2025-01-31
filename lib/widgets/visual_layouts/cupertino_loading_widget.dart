import 'package:flutter/cupertino.dart';

class CupertinoLoadingWidget extends StatelessWidget {
  final double? dimension;
  final Color? indicatorColor;

  const CupertinoLoadingWidget({
    super.key,
    this.dimension,
    this.indicatorColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: dimension,
      child: const Center(child: CupertinoActivityIndicator()),
    );
  }
}
