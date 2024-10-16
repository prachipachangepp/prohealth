import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:printing/printing.dart';

Future<void> downloadFile(String url) async {
  final Uri uri = Uri.parse(url);
  print('Url Response : ${uri.data}');
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  } else {
    throw 'Could not launch $url';
  }
}

/// pdf viewer code of ack
// Future<void> openPdfViewer(String url) async {
//   try {
//     // Download the PDF data from the URL
//     final response = await http.get(Uri.parse(url));
//
//     if (response.statusCode == 200) {
//       Uint8List pdfData = response.bodyBytes;
//
//       // Open the PDF in the print preview or PDF viewer
//       await Printing.layoutPdf(
//         onLayout: (PdfPageFormat format) async => pdfData,
//       );
//     } else {
//       throw 'Failed to load PDF: ${response.statusCode}';
//     }
//   } catch (e) {
//     print('Error opening PDF: $e');
//   }
// }

///given by sir
// Future<String> fetchBase64FromS3(String url) async {
//
//   final response = await http.get(Uri.parse(url));
//
//   if (response.statusCode == 200) {
//
//     return response.body; // Assuming the response body is Base64-encoded
//
//   } else {
//
//     throw Exception("Failed to fetch Base64 data from S3");
//
//   }
//
// } //Pick base 64 from this function
