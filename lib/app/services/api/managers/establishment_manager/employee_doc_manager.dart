import 'package:flutter/cupertino.dart';
import 'package:prohealth/app/services/api/repository/establishment_manager/employee_doc_repository.dart';

import '../../../../../data/api_data/api_data.dart';
import '../../../../../data/api_data/establishment_data/employee_doc/employee_doc_data.dart';
import '../../../../resources/const_string.dart';
import '../../../token/token_manager.dart';
import '../../api.dart';
import '../../repository/establishment_manager/all_from_hr_repository.dart';
import '../../repository/establishment_manager/establishment_repository.dart';

/// GET employee-document-type-meta-data in tab bar
Future<List<EmployeeDocTabModal>> getEmployeeDocTab(BuildContext context,
    ) async {
  List<EmployeeDocTabModal> itemsList = [];
  try {
    final response = await Api(context)
        .get(path: EstablishmentManagerRepository.getEmployeeDocSetup(
    ));
    if (response.statusCode == 200 || response.statusCode == 201) {
      // print("Org Document response:::::${itemsList}");
      print("1212");
      for(var item in response.data){
        itemsList.add(
          EmployeeDocTabModal(
            employeeDocType: item['EmployeeDocumentType']== null ?"null" :item['EmployeeDocumentType'],
            employeeDocMetaDataId: item['EmployeeDocumentTypeMetaDataId']== null ? 0 :item['EmployeeDocumentTypeMetaDataId'],
            success: true,
            message: response.statusMessage!,
          ),
        );
      }
      print("Employee Document Response:::::${itemsList}");
    } else {
      print('Employee Document');
      return itemsList;
    }
    // print("Org response:::::${response}");
    return itemsList;
  } catch (e) {
    print("Error $e");
    return itemsList;
  }
}

/// Get employee document setup drop down
Future<List<EmployeeDocSetupModal>> getEmployeeDocSetupDropDown(BuildContext context,
    ) async {
  List<EmployeeDocSetupModal> itemsList = [];
  try {
    final response = await Api(context)
        .get(path: EstablishmentManagerRepository.getEmployeDocSetupDropdown(
    ));
    if (response.statusCode == 200 || response.statusCode == 201) {
      // print("Org Document response:::::${itemsList}");
      print("1212");
      for(var item in response.data){
        itemsList.add(
          EmployeeDocSetupModal(
            employeeDocMetaDataId: item['EmployeeDocumentTypeMetaDataId']?? 0,
            success: true,
            message: response.statusMessage!,
            employeeDocTypeSetupId: item['EmployeeDocumentTypeSetupId'],
            documentName: item['DocumentName'],
            expiry: item['Expiry'],
            reminderThreshould: item['ReminderThreshold'],
          ),
        );
      }
    } else {
      print('Employee Document Setup drop down');
      return itemsList;
    }
    // print("Org response:::::${response}");
    return itemsList;
  } catch (e) {
    print("Error $e");
    return itemsList;
  }
}
/// GET employee-document-type-setup/{EmployeeDocumentTypeMetaDataId}/{pageNbr}/{NbrofRows}
Future<List<EmployeeDocumentModal>> getEmployeeDoc(BuildContext context,
    // int metaDocID
    int employeeDocTypeMetataId,
    int pageNo,
    int rowsNo
    ) async {
  List<EmployeeDocumentModal> itemsList = [];
  try {
    final companyId = await TokenManager.getCompanyId();
    final response = await Api(context)
        .get(path: EstablishmentManagerRepository.getEmployeeDocSetUpMetaId(
         // metaDocId: metaDocID
        pageNo: pageNo,
        rowsNo: rowsNo,
        employeeDocTypeMetaDataId:  employeeDocTypeMetataId,
    ));
    if (response.statusCode == 200 || response.statusCode == 201) {
      // print("Org Document response:::::${itemsList}");
      print("1");
      for(var item in response.data){
        itemsList.add(EmployeeDocumentModal(
              docName: item["DocumentName"],
              expiry: item["Expiry"],
              reminderThreshold: item["ReminderThreshold"],
              employeeDocTypesetupId: item['EmployeeDocumentTypeSetupId'],
              employeeDocTypeMetaId: item['EmployeeDocumentTypeMetaDataId'],
              idOfDocument: item['idOfDocument'],
              companyId: companyId,
              sucess: true,
              message: response.statusMessage!
          ),
        );
      }
      print("Employee setup Response:::::${response.data}");
    } else {
      print('Employee Document Error');
      return itemsList;
    }
    // print("Org response:::::${response}");
    return itemsList;
  } catch (e) {
    print("Error $e");
    return itemsList;
  }
}

///Add employee doc type setup Id
Future<ApiData> addEmployeeDocSetup(
    BuildContext context,
    int empDocMetaDataId,
    String docName,
    String reminerThreshild,
    String expiry,
    String idOfDoc,
    ) async {
  try {
    var response = await Api(context).post(path: EstablishmentManagerRepository.addEmployeDocSetup(),
        data:
    {
      "DocumentName": docName,
      "Expiry": expiry,
      "ReminderThreshold": reminerThreshild,
      "EmployeeDocumentTypeMetaDataId": empDocMetaDataId,
      "idOfDocument": idOfDoc,
    });
    print('Post Emp doc ::::$response ');
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Employee Document Addded");
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

///DELETE employee doc type setup Id
Future<ApiData> employeedoctypeSetupIdDelete(
    BuildContext context,
    int employeeDocTypeSetupId
    ) async {
  try {
    var response = await Api(context).delete(path:
    EstablishmentManagerRepository.deleteEmployeedoctypesetup(
         employeeDoctypeSetupId: employeeDocTypeSetupId
    ));
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Employee Document Deleted");
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
///POST employee doc type setup
Future<ApiData> employeeDocTypeSetupIDPost(
    BuildContext context,
    int employeeDoctypeSetupId

    ) async {
  try {
    var response = await Api(context).post(path:
    EstablishmentManagerRepository.postEmployeedocTypesetup(
        employeeDoctypeSetupId: employeeDoctypeSetupId
    ), data:
    {

    });
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Employee type Added");
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

/// GET Prefill employee-document-type-Setuo-data
Future<GetEmployeeSetupPrefillData> getPrefillEmployeeDocTab(BuildContext context,
   int  empDocTypeId) async {
  var itemsList;
  try {
    final companyId = await TokenManager.getCompanyId();
    final response = await Api(context)
        .get(path: EstablishmentManagerRepository.getPrefillEmployeDocSetup(empDocTypeId: empDocTypeId));
    if (response.statusCode == 200 || response.statusCode == 201) {
      // print("Org Document response:::::${itemsList}");
      print("1212");

        itemsList =
            GetEmployeeSetupPrefillData(
              docName: response.data["DocumentName"],
              expiry: response.data["Expiry"],
              reminderThreshold: response.data["ReminderThreshold"],
              employeeDocTypesetupId: response.data['EmployeeDocumentTypeSetupId'],
              employeeDocTypeMetaId: response.data['EmployeeDocumentTypeMetaDataId'],
                idOfDocument: response.data['idOfDocument'] ?? "--",
              companyId: companyId,
              sucess: true,
              message: response.statusMessage!
          );
    } else {
      print('Employee Document');
      return itemsList;
    }
    // print("Org response:::::${response}");
    return itemsList;
  } catch (e) {
    print("Error $e");
    return itemsList;
  }
}
