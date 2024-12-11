
import 'package:flutter/material.dart';
import 'package:prohealth/app/services/api/api.dart';
import 'package:prohealth/app/services/api/repository/establishment_manager/establishment_repository.dart';
import 'package:prohealth/app/services/api/repository/hr_module_repository/termination_repo/termnation_repo.dart';
import 'package:prohealth/app/services/token/token_manager.dart';
import 'package:prohealth/data/api_data/api_data.dart';

import '../../../../../resources/const_string.dart';

/// patch
Future<ApiData> terminationPatch(BuildContext context,
    int employeeId,
    String dateofTermination,
    String dateofResignation,
    String dateofHire,
    String rehirable,
    String position,
    String finalAddress,
    String type,
    String reason,
    int finalPayCheck,
    String checkDate,
    String grossPay,
    String netPay,
    String methods,
    String materials




    // int typeVisist,String visitType, List<int> eligibleClinical
    ) async {
  try {
    final companyId = await TokenManager.getCompanyId();
    var response = await Api(context).patch(path: TerminationRepository.terminationPatch( employeeId: employeeId), data: {
      "dateofTermination": dateofTermination,
  "dateofResignation": dateofResignation,
  "dateofHire": dateofHire,
  "rehirable": rehirable,
  "position": position,
  "finalAddress": finalAddress,
  "type": type,
  "reason": reason,
  "finalPayCheck": finalPayCheck,
  "checkDate": checkDate,
  "grossPay": grossPay,
  "netPay": netPay,
  "methods": methods,
  "materials": materials,
      // 'typeOfVisit':visitType,
      // 'companyId':companyId,
      // 'employeeTypeId':eligibleClinical
    },);
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Terminated");
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
    print("Error 2");
    return ApiData(
        statusCode: 404, success: false, message: AppString.somethingWentWrong);
  }
}
