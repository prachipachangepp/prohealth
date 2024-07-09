import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/services/api/api.dart';
import 'package:prohealth/app/services/api/repository/hr_module_repository/manage_emp/manage_emp_repo.dart';
import 'package:prohealth/data/api_data/api_data.dart';
import 'package:prohealth/data/api_data/hr_module_data/manage/employeement_data.dart';

Future<List<EmployeementData>> getEmployeement(
    BuildContext context, int employeeId) async {
  String convertIsoToDayMonthYear(String isoDate) {
    // Parse ISO date string to DateTime object
    DateTime dateTime = DateTime.parse(isoDate);

    // Create a DateFormat object to format the date
    DateFormat dateFormat = DateFormat('dd MMM yyyy');

    // Format the date into "dd mm yy" format
    String formattedDate = dateFormat.format(dateTime);

    return formattedDate;
  }

  List<EmployeementData> itemsData = [];
  try {
    final response = await Api(context)
        .get(path: ManageReposotory.getEmployeement(employeeId: employeeId));
    if (response.statusCode == 200 || response.statusCode == 201) {
      for (var item in response.data) {
        String joiningFormattedDate =
            convertIsoToDayMonthYear(item['dateOfJoining']);
        String endFormattedDate = convertIsoToDayMonthYear(item['endDate']);
        itemsData.add(EmployeementData(
            employmentId: item['employmentId'],
            employeeId: item['employeeId'],
            employer: item['employer'],
            city: item['city'],
            reason: item['reason'],
            supervisor: item['supervisor'],
            supMobile: item['supMobile'],
            title: item['title'],
            dateOfJoining: joiningFormattedDate,
            endDate: endFormattedDate,
            approved: item['approved']));
      }
    } else {
      print("Employee Employeement");
    }
    return itemsData;
  } catch (e) {
    print("error${e}");
    return itemsData;
  }
}

/// Add employeement
Future<ApiData> addEmployeement(BuildContext context,
    String country,int employeeId,String employer,String city,String reason,String supervisor,String supMobile,
    String title,String dateOfJoining,String endDate
    ) async {
  try {
    var response = await Api(context).post(path: ManageReposotory.addEmployeement(), data: {
      "employeeId": employeeId,
      "employer": employer,
      "city": city,
      "reason": reason,
      "supervisor": supervisor,
      "supMobile": supMobile,
      "title": title,
      "dateOfJoining": "${dateOfJoining}T00:00:00Z",
      "endDate":"${endDate}T00:00:00Z"
    },);
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Employeement Added");
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
    return ApiData(
        statusCode: 404, success: false, message: AppString.somethingWentWrong);
  }
}
