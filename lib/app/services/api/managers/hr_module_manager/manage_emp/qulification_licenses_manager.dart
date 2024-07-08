import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prohealth/app/services/api/api.dart';
import 'package:prohealth/app/services/api/repository/hr_module_repository/manage_emp/manage_emp_repo.dart';
import 'package:prohealth/data/api_data/hr_module_data/manage/qualification_licenses.dart';

Future<List<QulificationLicensesData>> getEmployeeLicenses(
    BuildContext context,int employeeId  ) async {
  List<QulificationLicensesData> itemsData = [];
  try {
    final response = await Api(context)
        .get(path: ManageEmployeeReposotory.getEmployeeLicenses(employeeid: employeeId));
    if (response.statusCode == 200 || response.statusCode == 201) {
      for (var item in response.data) {
        itemsData.add(
            QulificationLicensesData(licenseId: item['licenseId'],
                country: item['country'], employeeId: item['employeeId'], expData: DateFormat('mm-dd-yyyy').format(item['expDate']),
              issueDate: item['issueDate'], licenseUrl: item['licenseUrl'], licenure: item['licensure'],
              licenseNumber: item['licenseNumber'], org: item['org'], documentType: item['documentType'],
              approved: item['approved']??false, sucess: true, message: response.statusMessage!,
            ));
      }
    } else {
      print("Employee Licenses");
    }
    return itemsData;
  } catch (e) {
    print("error${e}");
    return itemsData;
  }
}