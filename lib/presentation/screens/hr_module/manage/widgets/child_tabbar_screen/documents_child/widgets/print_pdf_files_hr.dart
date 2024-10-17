// Function to print PDF from base64 string
import 'dart:convert';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';
import 'dart:convert'; // For base64 encoding/decoding
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:printing/printing.dart'; // For printing functionality
import 'package:pdf/widgets.dart' as pw; // For PDF creation

Future<void> printDocumentFromBase64(String base64String) async {
  // Decode the base64 string
  final pdfData = base64Decode(base64String);

  // Create a PDF document
  final pdf = pw.Document();
  pdf.addPage(
    pw.Page(
      build: (pw.Context context) => pw.Center(
        child: pw.Text('Your document content goes here'), // Replace with your document content
      ),
    ),
  );

  // Print the document
  await Printing.layoutPdf(
    onLayout: (PdfPageFormat format) async => pdfData,
  );
}