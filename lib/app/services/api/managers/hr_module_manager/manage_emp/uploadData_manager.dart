import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/multipart/multipart_file.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/services/api/api.dart';
import 'package:prohealth/app/services/api/repository/hr_module_repository/manage_emp/upload_repo.dart';
import 'package:prohealth/data/api_data/api_data.dart';

Future<ApiData> uploadDocuments({
  required BuildContext context,
  required int employeeDocumentMetaId,
  required int employeeDocumentTypeSetupId,
  required int employeeId,
  required File documentFile,
  required String documentName
}) async {
  try {
    var response = await Api(context).post(
      path: UploadDocumentRepository.uploadEmployeeDocumentGet(employeeDocumentTypeMetaDataId: employeeDocumentMetaId, employeeDocumentTypeSetupId: employeeDocumentTypeSetupId, employeeId: employeeId),
      data: {
        "employeeDocumentMetaId": employeeDocumentMetaId,
        "employeeDocumentTypeSetupId": employeeDocumentTypeSetupId,
        "employeeId": employeeId,
        "documentFile":  MultipartFile(
          documentFile.path,
          filename: documentName,
        ),
      },
    );
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