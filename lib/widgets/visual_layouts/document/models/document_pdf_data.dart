part of 'document_data.dart';

class PDFMemoryData extends DocumentData {
  PDFMemoryData({required Uint8List uint8List}) : super(uint8List: uint8List);

  @override
  Widget build({
    double? height,
    double? width,
    BoxFit? fit,
    BorderRadius? borderRadius,
  }) {
    if (uint8List?.isNotEmpty != true) {
      return ErrorIndicator(dimension: height, iconSize: 64);
    }

    return PDFMemory(
      pdfData: uint8List!,
      height: height,
      width: width,
      swipeHorizontal: true,
    );
  }
}

class PDFFileData extends DocumentData {
  PDFFileData({required File file}) : super(file: file);

  @override
  Widget build({
    double? height,
    double? width,
    BoxFit? fit,
    BorderRadius? borderRadius,
  }) {
    if (file?.path.isNotEmpty != true) {
      return ErrorIndicator(dimension: height, iconSize: 64);
    }

    return PDFFile(
      file: file!,
      height: height,
      width: width,
      swipeHorizontal: true,
    );
  }
}
