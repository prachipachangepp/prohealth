


import 'package:flutter/cupertino.dart';

import '../../../../../../data/api_data/hr_module_data/add_employee/clinical.dart';
import '../../../api.dart';
import '../../../repository/establishment_manager/all_from_hr_repository.dart';
import '../../../repository/hr_module_repository/add_employee/clinical.dart';



Future<List<AEClinical>> HrAddEmplyClinicalApi(BuildContext context, int deptID) async {
  List<AEClinical> itemsList = [];
  try {
    final response = await Api(context)
        .get(path: HRModuleAEClinicalRepository.getEmployeeTypeDept(deptID));
    if (response.statusCode == 200 || response.statusCode == 201) {
      for (var item in response.data) {
        itemsList.add(
          AEClinical(
            employeeTypesId: item['employeeTypeId'],
            empType: item['employeeType'],
            deptID: item['DepartmentId'],
            abbrivation: item['abbreviation'],
            color: item['color'],
          ),
        );
      }
    } else {
      print('Api Error');
    }
    print("Response:::::${response}");
    return itemsList;
  } catch (e) {
    print("Error $e");
    return itemsList;
  }
}