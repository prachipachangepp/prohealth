import 'package:flutter/material.dart';

import '../../../../../data/api_data/establishment_data/role_manager/role_manager_data.dart';
import '../../api.dart';
import '../../repository/establishment_manager/establishment_repository.dart';

Future<List<RoleManagerData>> roleManagerDataGet(BuildContext context) async {
  List<RoleManagerData> itemsData = [];
  try {
    final response = await Api(context)
        .get(path: EstablishmentManagerRepository.companyDepartment());
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(":::::LIST${response.data}");
      for (var item in response.data) {
        itemsData.add(
            RoleManagerData(
                deptID: item['DepartmentId'],
                deptName: item['departmentName'],
                description: item['description']
               ));
      }
    } else {
      print("Api Role Manager Data Error");
    }
    return itemsData;
  } catch (e) {
    print("error${e}");
    return itemsData;
  }
}
