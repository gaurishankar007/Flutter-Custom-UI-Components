import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../error_indicator_widget.dart';
import '../../images/cached_network_image_widget.dart';
import '../../images/file_image_widget.dart';
import '../../images/memory_image_widget.dart';
import '../../pdf/pdf_file_widget.dart';
import '../../pdf/pdf_memory_widget.dart';

part 'document_image_data.dart';
part 'document_pdf_data.dart';

/// Holds document data sources
abstract class DocumentData {
  final String id;

  /// document url
  final String? url;

  /// document bytes data
  final Uint8List? uint8List;

  /// document file
  final File? file;

  DocumentData({
    this.url,
    this.uint8List,
    this.file,
  }) : id = const Uuid().v4();

  Widget build({
    double? height,
    double? width,
    BoxFit? fit,
    BorderRadius? borderRadius,
  });
}

extension DocumentDataExtension on DocumentData {
  IconData getIcon() {
    if (this is PDFFileData || this is PDFMemoryData) {
      return Icons.description_outlined;
    } else if (this is ImageFileData ||
        this is ImageNetworkData ||
        this is ImageMemoryData) {
      return Icons.broken_image_outlined;
    }

    return Icons.description_rounded;
  }
}
