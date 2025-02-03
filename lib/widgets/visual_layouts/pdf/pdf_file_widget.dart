import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

import '../error_indicator_widget.dart';

class PDFFileWidget extends StatelessWidget {
  final File file;
  final double? height;
  final double? width;
  final bool? swipeHorizontal;
  final bool? pageFling;

  const PDFFileWidget({
    super.key,
    required this.file,
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
        filePath: file.path,
        swipeHorizontal: swipeHorizontal ?? false,
        pageFling: pageFling ?? true,
        onError: (_) => const ErrorIndicatorWidget(),
        onPageError: (_, __) => const ErrorIndicatorWidget(),
      ),
    );
  }
}
