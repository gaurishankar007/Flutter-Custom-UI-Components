import 'package:flutter/cupertino.dart';

class BottomSheetBody extends StatelessWidget {
  final List<Widget> children;
  const BottomSheetBody({super.key, required this.children});

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
