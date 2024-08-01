import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:universal_io/io.dart';

class EncodeDecodeBase64{
  static Future<String> getEncodeBase64({required dynamic bytes}) async {
    String base64Documents = base64Encode(bytes);
    return base64Documents;
  }
  static Future<void> getDecodeBase64({required String fetchedUrl}) async {
    String url = fetchedUrl;
    String fileUrl = "https://symmetry-office-document.s3.us-west-2.amazonaws.com/documents/e7c0ec2f-e346-41dc-90bb-a33b2546da4d-uORbh4Ir0xlsTcArxhByr0O";

    // Get the file name from the URL
    String fileName = fileUrl.split('/').last;

    // Send an HTTP GET request to download the file
    var response = await http.get(Uri.parse(fileUrl));

    // Get the directory to save the file
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String filePath = '${appDocDir.path}/$fileName';

    // Write the file
    File file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);

    print('File saved at: $filePath');

    // Encode the URL to base64
    String base64EncodedUrl = base64.encode(utf8.encode(url));
    print("Encoded url ::${base64EncodedUrl}");
    //return base64EncodedUrl;
  }
}