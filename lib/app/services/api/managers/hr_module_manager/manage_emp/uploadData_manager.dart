
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/multipart/form_data.dart';
import 'package:get/get_connect/http/src/multipart/multipart_file.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/services/api/api.dart';
import 'package:prohealth/app/services/api/repository/hr_module_repository/manage_emp/upload_repo.dart';
import 'package:prohealth/app/services/token/token_manager.dart';
import 'package:prohealth/data/api_data/api_data.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<ApiData> uploadDocuments({
  required BuildContext context,
  required int employeeDocumentMetaId,
  required int employeeDocumentTypeSetupId,
  required int employeeId,
  required dynamic documentFile,
  required String documentName
}) async {
  try {
    print("File ${documentFile}");
    var fileDocuments = MultipartFile(
      documentFile,
      filename: documentName,
    );
    print("file Doc ${fileDocuments}");
    var data = FormData({
      'files': [
        await fileDocuments
      ],

    });
    var response = await Api(context).post(
      path: UploadDocumentRepository.uploadEmployeeDocumentGet(employeeDocumentTypeMetaDataId: employeeDocumentMetaId, employeeDocumentTypeSetupId: employeeDocumentTypeSetupId, employeeId: employeeId),
      data: {

      },
    );
    print("Response ${response.toString()}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Documents uploded");
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






Future<void> uploadHttpDocuments({
  required BuildContext context,
  required int employeeDocumentMetaId,
  required int employeeDocumentTypeSetupId,
  required int employeeId,
  required dynamic documentFile,
  required String documentName
}) async {
  try {
    var headers = {
  'accept': 'application/json',
  'Content-Type': 'application/json',
  'Authorization':  TokenManager.getAccessToken().toString(),
};
var request = http.MultipartRequest('POST',
    Uri.parse('http://50.112.139.35:3000/employee-documents/uploadDocument/$employeeDocumentMetaId/$employeeDocumentTypeSetupId/$employeeId'));
request.files.add(http.MultipartFile.fromBytes('file', documentFile));
request.headers.addAll(headers);

http.StreamedResponse response = await request.send();
if (response.statusCode == 200) {
  print("Uploded");
print(await response.stream.bytesToString());
}
else {
print(response.reasonPhrase);
}
  } catch (e) {
    print("Error $e");
  }
}

