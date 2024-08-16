


import 'package:flutter/cupertino.dart';
import 'package:prohealth/app/services/api/repository/sm_repository/patient_data/patient_data_info_repo.dart';

import '../../../../../../data/api_data/api_data.dart';
import '../../../../../../data/api_data/sm_data/patient_data/patient_data_compliance.dart';
import '../../../../../resources/const_string.dart';
import '../../../../token/token_manager.dart';
import '../../../api.dart';

///Get
Future<List<PatientDataComplianceModal>> fetchPatientDataCompliance(BuildContext context,

    ) async {
  List<PatientDataComplianceModal> itemsList = [];
  try {
    final companyId = await TokenManager.getCompanyId();
    final response = await Api(context)
        .get(path: PatientDataInfoRepo.getPatientCompliance(
    ));
    if (response.statusCode == 200 || response.statusCode == 201) {
      // print("Org Document response:::::${itemsList}");
      print("1");
      for(var item in response.data){
        itemsList.add(
            PatientDataComplianceModal(
                complianceId: item['ComplianceId'] ?? 0,
                patientId: item['patientId'] ?? 0,
                docTypeId : item['docTypeId'] ?? 0,
                docName : item['docName'] ?? '',
                docUrl: item['docUrl'] ?? '',
                expDate: item['expDate'] ?? ''
            )
          // CiOrgDocumentCC(
          //     docId: item['document_id'],
          //     createdAt: item['doc_created_at'],
          //     name: item["doc_name"],
          //     expiry: item["expiry_date"],
          //     reminderThreshold: item["expiry_type"],
          //     sucess: true, message: response.statusMessage!, documentTypeId: item['document_type_id'],
          //     documentSubTypeId: item['document_subtype_id'], url: item['url'], expirtReminder: item['expiry_reminder'],
          //     companyId: item['company_id'], officeId: item['office_id']
          // ),
        );
      }
      // print('${response.data['DocumentList']}');
      print("Compliance response:::::${itemsList}");
    } else {
      print('Compliance Data Added');
      return itemsList;
    }
    // print("Org response:::::${response}");
    return itemsList;
  } catch (e) {
    print("Error for add $e");
    return itemsList;
  }
}



///delete api
Future<ApiData> deleteDocumentCompliance(
    BuildContext context, int ComplianceId) async {
  try {
    var response = await Api(context).delete(
        path:PatientDataInfoRepo.deletePDCompliance(ComplianceId: ComplianceId));
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Compliance Document :::${ComplianceId}");
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


///Add Compliance
Future<ApiData> addComplianceDocumentPost({
  required BuildContext context,
  // required String name,
  // required int docTypeID,
  // required int docSubTypeID,
  // required String docCreated,
  // required String url,
  // required String expiryType,
  // required String expiryDate,
  // required String expiryReminder,
  // required String officeId,
   required int patientId,
   required int docTypeId,
   required String docName,
   required String docUrl ,
   required String expDate
}) async {
  try {
    final companyId = await TokenManager.getCompanyId();
    var data = {
      "patientId": patientId,
      "docTypeId": docTypeId,
      "docName": docName,
      "docUrl": docUrl,
      "expDate": expDate
    };
    print(' Post Intake Compliance $data');
    var response = await Api(context).post(
        path: PatientDataInfoRepo.postPDCompliance(),
        data: data);
    print('Compliance Add ::::$response ');
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

Future<List<PatientDataComplianceDoc>> getpatientDataComplianceDoc(BuildContext context,

    ) async {
  List<PatientDataComplianceDoc> itemsList = [];
  try {
    final companyId = await TokenManager.getCompanyId();
    final response = await Api(context)
        .get(path: PatientDataInfoRepo.complianceDocget(
    ));
    if (response.statusCode == 200 || response.statusCode == 201) {
      // print("Org Document response:::::${itemsList}");
      print("1");
      for(var item in response.data){
        itemsList.add(
            PatientDataComplianceDoc(
                docTypeId : item['docTypeId'] ?? 0,
                companyId: item['companyId'] ?? 0,
                docType: item['docType'] ?? 0,
                docName : item['docName'] ?? '',
                expireType: item['expireType'] ?? '',
                expDate: item['expDate'] ?? ''

            )
        );
      }
      // print('${response.data['DocumentList']}');
      print("Compliance response:::::${itemsList}");
    } else {
      print('Compliance Data Added');
      return itemsList;
    }
    // print("Org response:::::${response}");
    return itemsList;
  } catch (e) {
    print("Error for add $e");
    return itemsList;
  }
}