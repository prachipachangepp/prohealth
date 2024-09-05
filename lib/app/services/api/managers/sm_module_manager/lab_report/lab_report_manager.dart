import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prohealth/app/services/api/api.dart';
import 'package:prohealth/app/services/api/repository/sm_repository/notes_repo/notes_repository.dart';
import 'package:prohealth/app/services/api/repository/sm_repository/patient_data/patient_data_info_repo.dart';
import 'package:prohealth/app/services/base64/encode_decode_base64.dart';
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
    required DateTime createdAt,
    required String expDate}) async {
  try {
    final companyId = await TokenManager.getCompanyId();
    var formatedDate = DateFormat('yyyy-MM-dd');
    var actualCurrentDate = formatedDate.format(createdAt);
    var data = {
      "patientId": patientId,
      "docTypeId": docTypeId,
      "docType": docType,
      "name": name,
      "docUrl": docUrl,
      "createdAt": actualCurrentDate,
      "expDate": expDate
    };
    print(' Post Intake Compliance $data');
    var response = await Api(context)
        .post(path: PatientDataInfoRepo.labReportAdd(), data: {
      "patientId": patientId,
      "docTypeId": docTypeId,
      "docType": docType,
      "name": name,
      "docUrl": docUrl,
      "createdAt": "${actualCurrentDate}T00:00:00Z",
      "expDate": expDate
    });
    print('Lab Report Add ::::$response ');
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Compliance addded ");
      var responseData = response.data;
      var labId = responseData['labReportId'];
      return ApiData(
          statusCode: response.statusCode!,
          success: true,
          message: response.statusMessage!,
      labReportId: labId);
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


///upload base 64
Future<ApiData> uploadDocumentsMiscNotes({
  required BuildContext context,
  required dynamic documentFile,
  required int miscNoteId,
}) async {
  try {
    String documents = await AppFilePickerBase64.getEncodeBase64(bytes: documentFile);
    print("File :::${documents}" );
    var response = await Api(context).post(
      path: NotesRepository.uploadDocPost(
          miscNoteId: miscNoteId
      ),
      data: {
        'base64':documents
      },
    );
    print("Response ${response.toString()}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Misc Notes Documents uploded");
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
