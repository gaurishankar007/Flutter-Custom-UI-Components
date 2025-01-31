part of 'document_data.dart';

/// PDF document's data holder
class DocumentPDFData extends DocumentData {
  DocumentPDFData({
    super.url,
    super.uint8List,
    super.base64Data,
    super.file,
  });

  @override
  Widget build({
    double? height,
    double? width,
    BoxFit? fit,
    BorderRadius? borderRadius,
  }) =>
      SizedBox.shrink();
}

class PDFMemoryData extends DocumentPDFData {
  PDFMemoryData({
    required String base64Data,
  }) : super(base64Data: base64Data);

  @override
  Widget build({
    double? height,
    double? width,
    BoxFit? fit,
    BorderRadius? borderRadius,
  }) {
    if (base64Data?.isNotEmpty != true) {
      return ErrorIndicatorWidget(dimension: height, iconSize: 64);
    }

    return SizedBox(
      height: height,
      width: width,
      child: PDFView(
        pdfData: base64Decode(base64Data ?? ""),
        swipeHorizontal: true,
      ),
    );
  }
}

class PDFFileData extends DocumentPDFData {
  PDFFileData({
    required File file,
  }) : super(file: file);

  @override
  Widget build({
    double? height,
    double? width,
    BoxFit? fit,
    BorderRadius? borderRadius,
  }) {
    if (file?.path.isNotEmpty != true) {
      return ErrorIndicatorWidget(dimension: height, iconSize: 64);
    }

    return SizedBox(
      height: height,
      width: width,
      child: PDFView(
        filePath: file?.path,
        swipeHorizontal: true,
      ),
    );
  }
}
