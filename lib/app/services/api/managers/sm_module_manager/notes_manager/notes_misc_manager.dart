///Get
import 'package:flutter/material.dart';

import '../../../../../../data/api_data/api_data.dart';
import '../../../../../../data/api_data/sm_data/Intake_deta/notes_data/intake_misc_note_data.dart';
import '../../../../../resources/const_string.dart';
import '../../../../token/token_manager.dart';
import '../../../api.dart';
import '../../../repository/sm_repository/notes_repo/notes_repository.dart';
import '../../../repository/sm_repository/patient_data/patient_data_info_repo.dart';

///get
Future<List<IntakeNotesMiscData>> getIntakeNoteMiscByPatientsID(BuildContext context, {required int patientId}) async {
  List<IntakeNotesMiscData> itemsList = [];
  try {
    final companyId = await TokenManager.getCompanyId();
    final response = await Api(context).get(
      path: NotesRepository.getMiscNoteByPatientId(patientId: patientId),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      for (var item in response.data) {
        itemsList.add(
          IntakeNotesMiscData(
            miscNoteId: item['miscNoteId'] ?? 0,
            patientId: item['patientId'] ?? 0,
            docTypeId: item['docTypeId'] ?? 0,
            docType: item['docType'] ?? '',
            docUrl: item['docUrl'] ?? '',
            name: item['name'] ?? '',
            createdAt: item['createdAt'] ?? '',
            expDate: item['expDate'] ?? '',
          ),
        );
      }
      print("Misc Notes response:::::${itemsList}");
    } else {
      print('Failed to fetch Misc Notes');
      return itemsList;
    }
    return itemsList;
  } catch (e) {
    print("Error fetching Misc Notes: $e");
    return itemsList;
  }
}

///post notes misc
Future<ApiData> addNotesMiscPost({
  required BuildContext context,
  required int patientId,
  required int docTypeId,
  required String docName,
  required String docUrl ,
  required String createdAt ,
  required String docType ,
  required String expDate
}) async {
  try {
    final companyId = await TokenManager.getCompanyId();
    var data = {
      "patientId": patientId,
      "docTypeId": docTypeId,
      "docType": docType,
      "docUrl": docUrl,
      "name": docName,
      "createdAt": createdAt,
      "expDate": expDate
    };
    print(' Post Intake Notes Misc $data');
    var response = await Api(context).post(
        path: NotesRepository.addMiscNote(),
        data: data);
    print('Compliance Add ::::$response ');
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Misc addded ");
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
Future<ApiData> deleteMiscNoteAPI(
    BuildContext context, int miscNoteId) async {
  try {
    var response = await Api(context).delete(
        path: NotesRepository.deleteMiscNote(miscNoteId: miscNoteId));
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Misc Document :::${miscNoteId}");
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
