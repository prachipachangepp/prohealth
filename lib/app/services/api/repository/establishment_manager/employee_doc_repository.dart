

import 'package:flutter/cupertino.dart';

import '../../../../../data/api_data/api_data.dart';
import '../../../../resources/const_string.dart';
import '../../api.dart';

class EmployeeDocumentRepository{
  static String employeedocSetup = "/employee-document-type-setup";
  ///patch api
  static String patchEmpDocSetUp({
    required int employeeDoctypeSetupId
}){
    return "$employeedocSetup/$employeeDoctypeSetupId";
  }
}
Future<ApiData> editEmployeeDocTypeSetupId(
    BuildContext context,
    String docName,
    String expiry,
    String reminderThreshold,
    int employeeDoctypeSetupId,
    int employeeDocTypeMetaDataId

    ) async {
  try {
    var response = await Api(context).patch(path:
    EmployeeDocumentRepository.patchEmpDocSetUp(
        employeeDoctypeSetupId: employeeDoctypeSetupId
      // empId : employeeTypeId,
    ), data: {
      "DocumentName": docName,
      "Expiry": expiry,
      "ReminderThreshold": reminderThreshold,
      "EmployeeDocumentTypeMetaDataId": employeeDocTypeMetaDataId,
      "EmployeeDocumentTypeSetupId" :employeeDoctypeSetupId
    });
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Employee Doc type Updated");
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
    print("Error 11 $e");
    return ApiData(
        statusCode: 404, success: false, message: AppString.somethingWentWrong);
  }
}