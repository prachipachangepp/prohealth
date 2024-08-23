import 'dart:convert';
import 'dart:html' as html;
import 'dart:typed_data';

import 'package:mime/mime.dart';

class DowloadFile {
  void downloadPdfFromBase64(String base64String, String fileName) {
    // Decode the base64 string into bytes (Uint8List)
    Uint8List bytes = base64.decode(base64String);

    // Create a blob from the bytes
    final blob = html.Blob([bytes], 'application/pdf');

    // Create an anchor element
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement(href: url)
      ..setAttribute("download", fileName)
      ..click();

    // Cleanup
    html.Url.revokeObjectUrl(url);
  }
//
  void downloadFileFromBase64(String base64String, String fileName) {
    // Decode the base64 string into bytes (Uint8List)
    Uint8List bytes = base64.decode(base64String);

    // Detect the MIME type using the mime package
    String mimeType = lookupMimeType(fileName, headerBytes: bytes) ??
        'application/octet-stream';

    // Create a blob from the bytes with the detected MIME type
    final blob = html.Blob([bytes], mimeType);

    // Create an anchor element and set the download attribute
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement(href: url)
      ..setAttribute("download", fileName)
      ..click();

    // Cleanup the created URL to free resources
    html.Url.revokeObjectUrl(url);
  }
}
