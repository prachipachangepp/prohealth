import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'dart:html' as html;

Future<void> downloadFile(String url) async {
  final Uri uri = Uri.parse(url);
  print('Url Response : ${uri.data}');
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  } else {
    throw 'Could not launch $url';
  }
}

class PdfDownloadButton extends StatelessWidget {
  final String apiUrl;
  final String documentName;

  PdfDownloadButton({required this.apiUrl, required this.documentName});

  Future<void> _downloadPdf() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final Uint8List pdfBytes = response.bodyBytes;

        final blob = html.Blob([pdfBytes], 'application/pdf');

        final url = html.Url.createObjectUrlFromBlob(blob);

        final anchor = html.AnchorElement(href: url)
          ..setAttribute('download', documentName)
          ..click();

        html.Url.revokeObjectUrl(url);
      } else {
        throw Exception('Failed to load PDF');
      }
    } catch (e) {
      print('Error downloading PDF: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.save_alt_outlined, size: 20, color: Color(0xff1696C8),),
      onPressed: _downloadPdf,
      tooltip: 'Download PDF',
    );
  }
}