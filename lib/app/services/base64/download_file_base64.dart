import 'dart:convert';
import 'dart:html' as html;
import 'dart:typed_data';

import 'package:mime/mime.dart';
//
// class DowloadFile {
//   void downloadPdfFromBase64(String base64String, String fileName) {
//     // Decode the base64 string into bytes (Uint8List)
//     Uint8List bytes = base64.decode(base64String);
//
//     // Create a blob from the bytes
//     final blob = html.Blob([bytes], 'application/pdf');
//
//     // Create an anchor element
//     final url = html.Url.createObjectUrlFromBlob(blob);
//     final anchor = html.AnchorElement(href: url)
//       ..setAttribute("download", fileName)
//       ..click();
//
//     // Cleanup
//     html.Url.revokeObjectUrl(url);
//   }
// //
//   void downloadFileFromBase64(String base64String, String fileName) {
//     // Decode the base64 string into bytes (Uint8List)
//     Uint8List bytes = base64.decode(base64String);
//
//     // Detect the MIME type using the mime package
//     String mimeType = lookupMimeType(fileName, headerBytes: bytes) ??
//         'application/octet-stream';
//
//     // Create a blob from the bytes with the detected MIME type
//     final blob = html.Blob([bytes], mimeType);
//
//     // Create an anchor element and set the download attribute
//     final url = html.Url.createObjectUrlFromBlob(blob);
//     final anchor = html.AnchorElement(href: url)
//       ..setAttribute("download", fileName)
//       ..click();
//
//     // Cleanup the created URL to free resources
//     html.Url.revokeObjectUrl(url);
//   }
// }
///
import 'dart:typed_data';
import 'dart:convert';
import 'package:mime/mime.dart';
import 'dart:html' as html;

import 'dart:typed_data';
import 'dart:convert';
import 'package:mime/mime.dart';
import 'dart:html' as html;

class DowloadFile {
  String sanitizeBase64(String base64String) {
    // Remove any invalid Base64 characters
    base64String = base64String.replaceAll(RegExp(r'[^A-Za-z0-9+/=]'), '');
    return base64String;
  }

  void downloadPdfFromBase64(String base64String, String fileName) {
    try {
      // Sanitize the Base64 string
      base64String = sanitizeBase64(base64String);

      // Decode the base64 string into bytes (Uint8List)
      Uint8List bytes = base64.decode(base64String);

      // Detect the MIME type using the mime package based on the file extension
      String? mimeType = lookupMimeType(fileName, headerBytes: bytes);

      // Fallback to a default MIME type if detection fails
      mimeType ??= 'application/octet-stream';

      // Create a blob from the bytes with the detected or fallback MIME type
      final blob = html.Blob([bytes], mimeType);

      // Create an anchor element and set the download attribute
      final url = html.Url.createObjectUrlFromBlob(blob);
      final anchor = html.AnchorElement(href: url)
        ..setAttribute("download", fileName)
        ..click();

      // Cleanup the created URL to free resources
      html.Url.revokeObjectUrl(url);
    } catch (e) {
      print("Error decoding base64: $e");
    }
  }
}
