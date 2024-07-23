import 'package:flutter/material.dart';

import '../../../../../../data/api_data/api_data.dart';
import '../../../../../resources/const_string.dart';
import '../../../api.dart';
import '../../../repository/hr_module_repository/form_repository/form_general_repo.dart';

//
// Future<void> sendOTP(String email) async {
//   // Replace with your API endpoint
//   var apiUrl = 'https://your-api-url/send_otp';
//
//   var response = await http.post(Uri.parse(apiUrl), body: {'email': email});
//
//   if (response.statusCode == 200) {
//     // OTP sent successfully, handle UI accordingly
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('OTP Sent to $email')),
//     );
//   } else {
//     // Error sending OTP
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('Failed to send OTP')),
//     );
//   }
// }


Future<ApiData> postverifyuser(
    BuildContext context,
    String email,

    ) async {
  try {
    var response = await Api(context).post(
      path: ProgressBarRepository.postverifyuser(),
      data: {
        "email": email


      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(" Verify user");
      // orgDocumentGet(context);
      return ApiData(
          statusCode: response.statusCode!,
          success: true,
          message: response.statusMessage!);
    } else {
      print("Error 1");
      return ApiData(
          statusCode: response.statusCode!,
          success: false,
          message: response.data['message']);
    }
  } catch (e) {
    print("Error $e");
    return ApiData(
        statusCode: 404, success: false, message: AppString.somethingWentWrong);
  }
 }
