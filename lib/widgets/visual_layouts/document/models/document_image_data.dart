part of 'document_data.dart';

/// Image document's data holder
class DocumentImageData extends DocumentData {
  DocumentImageData({
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

class ImageNetworkData extends DocumentImageData {
  ImageNetworkData({
    required String url,
  }) : super(url: url);

  @override
  Widget build({
    double? height,
    double? width,
    BoxFit? fit,
    BorderRadius? borderRadius,
  }) {
    return ImageCachedNetworkWidget(
      imageUrl: url,
      height: height,
      width: width,
      fit: fit,
      borderRadius: borderRadius,
    );
  }
}

class ImageFileData extends DocumentImageData {
  ImageFileData({
    required File assetFile,
  }) : super(file: assetFile);

  @override
  Widget build({
    double? height,
    double? width,
    BoxFit? fit,
    BorderRadius? borderRadius,
  }) {
    return ImageFileWidget(
      file: file!,
      height: height,
      width: width,
      fit: fit,
      borderRadius: borderRadius,
    );
  }
}

class ImageMemoryData extends DocumentImageData {
  ImageMemoryData({
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

    return ImageMemoryWidget(
      base64: base64Data!,
      height: height,
      width: width,
      fit: fit,
      borderRadius: borderRadius,
    );
  }
}
