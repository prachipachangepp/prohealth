import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class Base64ImageWidget extends StatelessWidget {
  final String base64String;

  Base64ImageWidget({required this.base64String});

  @override
  Widget build(BuildContext context) {
    // Decode the base64 string into bytes
    Uint8List imageBytes = base64Decode(base64String);

    // Return an Image widget that displays the decoded image
    return Image.memory(
      imageBytes,
      fit: BoxFit.cover,
    );
  }
}
