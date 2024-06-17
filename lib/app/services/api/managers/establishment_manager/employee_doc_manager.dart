import 'package:flutter/cupertino.dart';

import '../../../../../data/api_data/establishment_data/employee_doc/employee_doc_data.dart';
import '../../api.dart';
import '../../repository/establishment_manager/establishment_repository.dart';

/// GET
Future<List<EmployeeDocumentModal>> getEmployeeDoc(BuildContext context,
    int employeeDocTypeSetupId,
    int pageNo,
    int rowsNo
    ) async {
  List<EmployeeDocumentModal> itemsList = [];
  try {
    final response = await Api(context)
        .get(path: EstablishmentManagerRepository.getEmployeeDocSetUpMetaId(
        pageNo: pageNo,
        rowsNo: rowsNo,
        employeeDocTypeSetupId: employeeDocTypeSetupId
    ));
    if (response.statusCode == 200 || response.statusCode == 201) {
      // print("Org Document response:::::${itemsList}");
      print("1");
      for(var item in response.data["DocumentList"]){
        itemsList.add(
          EmployeeDocumentModal(
              name: item["doc_name"],
              expiry: item["expiry_date"],
              reminderThreshold: item["expiry_reminder"],
              pageNo: item["pageNbr"],
              rowsNo: item["NbrofRows"],
              employeeDocTypesetupId: employeeDocTypeSetupId,
              sucess: true,
              message: response.statusMessage!
          ),
        );
      }
      print("Org Sub Document response:::::${itemsList}");
    } else {
      print('Org Api Error');
      return itemsList;
    }
    // print("Org response:::::${response}");
    return itemsList;
  } catch (e) {
    print("Error $e");
    return itemsList;
  }
}


/// GET employee-document-type-meta-data
Future<List<EmployeeDocTabModal>> getEmployeeDocTab(BuildContext context,
    ) async {
  List<EmployeeDocTabModal> itemsList = [];
  try {
    final response = await Api(context)
        .get(path: EstablishmentManagerRepository.getEmployeeDocSetup(

    ));
    if (response.statusCode == 200 || response.statusCode == 201) {
      // print("Org Document response:::::${itemsList}");
      print("1");
      for(var item in response.data){
        itemsList.add(
          EmployeeDocTabModal(
              employeeDocType: item['EmployeeDocumentType'],
              employeeDocMetaDataId: item['EmployeeDocumentTypeMetaDataId'],
              success: true,
              message: response.statusMessage!,
          ),
        );
      }
      print("Org Sub Document response:::::${itemsList}");
    } else {
      print('Org Api Error');
      return itemsList;
    }
    // print("Org response:::::${response}");
    return itemsList;
  } catch (e) {
    print("Error $e");
    return itemsList;
  }
}