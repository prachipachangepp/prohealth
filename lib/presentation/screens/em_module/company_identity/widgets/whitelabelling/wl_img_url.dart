//
// import 'dart:convert';
// import 'dart:nativewrappers/_internal/vm/lib/typed_data_patch.dart';
// import 'package:http/http.dart' as http;
//
// class GenerateImageUrl {
//   late bool success;
//   late String message;
//
//   late bool isGenerated;
//   late String uploadUrl;
//   late String downloadUrl;
//
//   Future<void> call(String fileType) async {
//     try {
//       Map body = {"fileType": fileType};
//
//       var response = await http.post(
//         'http://${Platform.isIOS ? 'localhost' : '10.0.2.2'}:5000/generatePresignedUrl',
//         body: body,
//       );
//
//       var result = jsonDecode(response.body);
//
//       if (result['success'] != null) {
//         success = result['success'];
//         message = result['message'];
//
//         if (response.statusCode == 201) {
//           isGenerated = true;
//           uploadUrl = result["uploadUrl"];
//           downloadUrl = result["downloadUrl"];
//         }
//       }
//     } catch (e) {
//       throw ('Error getting url');
//     }
//   }
// }
//
// class UploadFile {
//   late bool success;
//   late String message;
//
//   late bool isUploaded;
//
//   Future<void> call(String url, PickedFile image) async {
//     try {
//       Uint8List bytes = await image.readAsBytes();
//       var response = await http.put(url, body: bytes);
//       if (response.statusCode == 200) {
//         isUploaded = true;
//       }
//     } catch (e) {
//       throw ('Error uploading photo');
//     }
//   }
// }