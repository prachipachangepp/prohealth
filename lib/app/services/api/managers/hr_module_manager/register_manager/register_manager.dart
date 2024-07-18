import 'package:flutter/material.dart';
import 'package:prohealth/app/services/api/repository/hr_module_repository/Register/register.dart';
import 'package:prohealth/data/api_data/hr_module_data/register_data/register_data.dart';
import '../../../api.dart';

///register enroll
Future<List<RegisterEnrollData>> RegisterGetData(BuildContext context,) async {
  List<RegisterEnrollData> itemsList = [];
  try {
    final response = await Api(context)
        .get(path: AllRegisterRepository.getEmployeeEnroll());
    if (response.statusCode == 200 || response.statusCode == 201) {
      for (var item in response.data) {
        itemsList.add(
       RegisterEnrollData(
           empEnrollId: item["employeeEnrollId"],
           compId: item["companyId"],
           empId: item["employeeId"],
           userId: item["userId"],
           code: item["code"],
         firstName: item["firstName"],
         lastName: item["lastName"],
         phoneNbr: item["phoneNbr"],
         email: item["email"],
         link: item["link"],
         status: item["status"],
       )
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

Future<List<RegisterEnrollData>> RegisterEmpEnrollGetById(BuildContext context, int empEnrollId) async {
  List<RegisterEnrollData> itemsList = [];
  try{
    final response = await Api(context).get(path:
    AllRegisterRepository.getEmpEnrollByEnrollId(empEnrollId: empEnrollId));
    if (response.statusCode == 200 || response.statusCode == 201) {
      for (var item in response.data) {
        itemsList.add(
            RegisterEnrollData(
              empEnrollId: item["employeeEnrollId"],
              compId: item["companyId"],
              empId: item["employeeId"],
              userId: item["userId"],
              code: item["code"],
              firstName: item["firstName"],
              lastName: item["lastName"],
              phoneNbr: item["phoneNbr"],
              email: item["email"],
              link: item["link"],
              status: item["status"],
            )
        );
      }
    } else {
      print('Api Error');
    }
    print("Response:::::${response}");
    return itemsList;
  }catch (e) {
    print("Error $e");
    return itemsList;
  }
}