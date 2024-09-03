import 'package:flutter/material.dart';
import 'package:prohealth/app/services/api/api.dart';
import 'package:prohealth/app/services/api/repository/sm_repository/patient_data/patient_data_info_repo.dart';
import 'package:prohealth/app/services/token/token_manager.dart';

import '../../../../../../data/api_data/api_data.dart';
import '../../../../../resources/const_string.dart';

///Get
Future<List<LabReportModal>> GetLabReport(
    BuildContext context,

    int patientId

    ) async {
  List<LabReportModal> itemsList = [];
  try {
    final companyId = await TokenManager.getCompanyId();
    final response = await Api(context)
        .get(path: PatientDataInfoRepo.labReportGet(patientId: patientId));
    if (response.statusCode == 200 || response.statusCode == 201) {
      // print("Org Document response:::::${itemsList}");
      print("1");
      for (var item in response.data) {
        itemsList.add(LabReportModal(
            labReportId: item['labReportId'],
            patientId: item['patientId'],
            docTypeId: item['docTypeId'],
            docType: item['docType'],
            name: item['name'],
            docUrl: item['docUrl'],
            createdAt: item['createdAt'],
            expDate: item['expDate']));
      }
      // print('${response.data['DocumentList']}');
      print("La Report response:::::${itemsList}");
    } else {
      print('Lab Result Added');
      return itemsList;
    }
    // print("Org response:::::${response}");
    return itemsList;
  } catch (e) {
    print("Error for add $e");
    return itemsList;
  }
}




class LabReportModal {
  final int? labReportId;
  final int? patientId;
  final int? docTypeId;
  final String? docType;
  final String? name;
  final String? docUrl;
  final String? createdAt;
  final String? expDate;

  LabReportModal(
      {this.labReportId,
      this.patientId,
      this.docTypeId,
      this.docType,
      this.name,
      this.docUrl,
      this.createdAt,
      this.expDate});
}

///Add Compliance
Future<ApiData> addLabReport(
    {required BuildContext context,

    required int patientId,
    required int docTypeId,
    required String docType,
    required String name,
    required String docUrl,
    required String createdAt,
    required String expDate}) async {
  try {
    final companyId = await TokenManager.getCompanyId();
    var data = {
      "patientId": patientId,
      "docTypeId": docTypeId,
      "docType": docType,
      "name": name,
      "docUrl": docUrl,
      "createdAt": createdAt,
      "expDate": expDate
    };
    print(' Post Intake Compliance $data');
    var response = await Api(context)
        .post(path: PatientDataInfoRepo.labReportAdd(), data: data);
    print('Lab Report Add ::::$response ');
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Compliance addded ");
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
    print("Error 2");
    return ApiData(
        statusCode: 404, success: false, message: AppString.somethingWentWrong);
  }
}



///delete api
Future<ApiData> deleteIntakeLabReport(
    BuildContext context, int labReportId) async {
  try {
    var response = await Api(context).delete(
        path:PatientDataInfoRepo.labReportDelete(labReportId: labReportId));
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Lab Report :::${labReportId}");
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
    print("Error 2");
    return ApiData(
        statusCode: 404, success: false, message: AppString.somethingWentWrong);
  }
}