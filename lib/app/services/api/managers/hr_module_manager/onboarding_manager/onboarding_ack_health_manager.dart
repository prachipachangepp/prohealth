import 'package:flutter/material.dart';
import 'package:prohealth/data/api_data/hr_module_data/onboarding_data/onboarding_ack_health_data.dart';

import '../../../api.dart';
import '../../../repository/hr_module_repository/onboarding/onboarding_qualification.dart';

Future<List<OnboardingAckHealthData>> getAckHealthRecord(BuildContext context,
    int EmpDocTypeMetaDataId,int EmpDocTypeSetupId ,int employeeId
    ) async {
  List<OnboardingAckHealthData> itemsList = [];
  try {
    final response = await Api(context)
        .get(path: OnboardingQualificationRepo.getAckHealthRecord(
        EmpDocTypeMetaDataId: EmpDocTypeMetaDataId,
        EmpDocTypeSetupId: EmpDocTypeSetupId,
        employeeId: employeeId
    ));
    if (response.statusCode == 200 || response.statusCode == 201) {
      // print("Org Document response:::::${itemsList}");
      print("1212");
      for(var item in response.data){
        itemsList.add(
          OnboardingAckHealthData(
              employeeDocumentId: item['employeeDocumentId'] ?? 1,
              EmployeeDocumentTypeMetaDataId: item['EmployeeDocumentTypeMetaDataId'] ?? 10,
              EmployeeDocumentTypeSetupId: item['EmployeeDocumentTypeSetupId'] ?? 2,
              employeeId: item['employeeId'] ?? 1,
              DocumentUrl: item['DocumentUrl'] ?? 'null',
              UploadDate: item['UploadDate'] ?? '--',
              approved: item['approved'] ?? false)
          // EmployeeDocTabModal(
          //   employeeDocType: item['EmployeeDocumentType']== null ?"null" :item['EmployeeDocumentType'],
          //   employeeDocMetaDataId: item['EmployeeDocumentTypeMetaDataId']== null ? 0 :item['EmployeeDocumentTypeMetaDataId'],
          //   success: true,
          //   message: response.statusMessage!,
          // ),
        );
        print(".....Saloni......$response");
      }
      print("onboarding Document Response:::::${itemsList}");
    } else {
      print('onboarding Document');
      return itemsList;
    }
    // print("Org response:::::${response}");
    return itemsList;
  } catch (e) {
    print("Error $e");
    return itemsList;
  }
}
