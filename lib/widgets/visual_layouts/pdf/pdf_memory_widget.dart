import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

import '../error_indicator_widget.dart';

class PDFMemoryWidget extends StatelessWidget {
  final Uint8List pdfData;
  final double? height;
  final double? width;
  final bool? swipeHorizontal;
  final bool? pageFling;

  const PDFMemoryWidget({
    super.key,
    required this.pdfData,
    this.height,
    this.width,
    this.swipeHorizontal,
    this.pageFling,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: PDFView(
        pdfData: pdfData,
        swipeHorizontal: swipeHorizontal ?? false,
        pageFling: pageFling ?? true,
        onError: (_) => const ErrorIndicatorWidget(),
        onPageError: (_, __) => const ErrorIndicatorWidget(),
      ),
    );
  }
}
