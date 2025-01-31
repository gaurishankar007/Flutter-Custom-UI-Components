import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:uuid/uuid.dart';

import '../../error_indicator_widget.dart';
import '../../image/image_cached_network_widget.dart';
import '../../image/image_file_widget.dart';
import '../../image/image_memory_widget.dart';

part 'document_image_data.dart';
part 'document_pdf_data.dart';

/// Holds document data sources
sealed class DocumentData {
  final String id;

  /// document url
  final String? url;

  /// document bytes data
  final Uint8List? uint8List;

  /// encoded document data
  final String? base64Data;

  /// document file
  final File? file;

  DocumentData({
    this.url,
    this.uint8List,
    this.base64Data,
    this.file,
  }) : id = const Uuid().v4();

  Widget build({
    double? height,
    double? width,
    BoxFit? fit,
    BorderRadius? borderRadius,
  });
}
