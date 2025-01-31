enum DocumentType {
  images(allowedFileTypes: ["png", "jpg", "jpeg"]),
  imagesAndPDF(allowedFileTypes: ["png", "jpg", "jpeg", "pdf"]);

  final List<String> allowedFileTypes;
  const DocumentType({required this.allowedFileTypes});
}
