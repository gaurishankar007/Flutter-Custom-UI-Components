import 'package:flutter/cupertino.dart';

class BottomSheetBodyWidget extends StatelessWidget {
  final List<Widget> children;
  const BottomSheetBodyWidget({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: children,
        ),
      ),
    );
  }
}
