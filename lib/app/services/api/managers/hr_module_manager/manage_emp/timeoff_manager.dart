import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/services/api/api.dart';
import 'package:prohealth/app/services/api/repository/hr_module_repository/manage_emp/manage_emp_repo.dart';
import 'package:prohealth/data/api_data/api_data.dart';
import 'package:prohealth/data/api_data/hr_module_data/manage/timeoff_data.dart';

Future<List<TimeOfffData>> getEmployeeTimeOff(
    BuildContext context, int companyId) async {
  String convertIsoToDayMonthYear(String isoDate) {
    // Parse ISO date string to DateTime object
    DateTime dateTime = DateTime.parse(isoDate);

    // Create a DateFormat object to format the date
    DateFormat dateFormat = DateFormat('MM-dd-yyyy');

    // Format the date into "dd mm yy" format
    String formattedDate = dateFormat.format(dateTime);

    return formattedDate;
  }

  List<TimeOfffData> itemsData = [];
  try {
    final response = await Api(context)
        .get(path: ManageReposotory.getEmployeeTimeOff(companyId: companyId));
    if (response.statusCode == 200 || response.statusCode == 201) {
      for (var item in response.data) {
        String startFormattedDate = convertIsoToDayMonthYear(item['startTime']);
        String endFormattedDate = convertIsoToDayMonthYear(item['endTime']);
        itemsData.add(TimeOfffData(
            employeeId: item['employeeId'],
            employeeName: item['employeeName'],
            timeOffRequest: item['timeOffRequest'],
            reson: item['reason'],
            startTime: startFormattedDate,
            endTime: endFormattedDate,
            sickTime: item['sickTime'],
            hours: item['Hours']));
      }
    } else {
      print("TimeOff");
    }
    return itemsData;
  } catch (e) {
    print("error${e}");
    return itemsData;
  }
}
/// TimeOfff edit
Future<ApiData> updateEmployeeTimeOffPatch(BuildContext context,
    int employeeTimeOffId,
    int employeeID,
    int companyId,
    String timeOffRequest,
    String reson,
    String startTime,
    String endTime,
    String sickTime,
    String hours
    ) async {
  try {
    var response = await Api(context).patch(path: ManageReposotory.patchEmployeeTimeOff(employeeTimeOffId: employeeTimeOffId), data: {
      "employeeId": employeeID,
      "companyId": companyId,
      "timeOffRequest": timeOffRequest,
      "reason": reson,
      "startTime": startTime,
      "endTime":endTime,
      "sickTime": sickTime,
      "Hours": hours
    });
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Timeoff updated");
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

/// Get time off prefill
Future<TimeOfPrefillData> getEmployeePrefillTimeOff(
    BuildContext context, int employeeTimeOffId) async {
  String convertIsoToDayMonthYear(String isoDate) {
    // Parse ISO date string to DateTime object
    DateTime dateTime = DateTime.parse(isoDate);

    // Create a DateFormat object to format the date
    DateFormat dateFormat = DateFormat('MM-dd-yyyy');

    // Format the date into "dd mm yy" format
    String formattedDate = dateFormat.format(dateTime);

    return formattedDate;
  }

  var itemsData;
  try {
    final response = await Api(context)
        .get(path: ManageReposotory.getEmployeePrefillTimeOff(employeeTimeOffId: employeeTimeOffId));
    if (response.statusCode == 200 || response.statusCode == 201) {
        String startFormattedDate = convertIsoToDayMonthYear(response.data['startTime']);
        String endFormattedDate = convertIsoToDayMonthYear(response.data['endTime']);
        itemsData = TimeOfPrefillData(
            employeeId: response.data['employeeId'],
            //employeeName: item['employeeName'],
            timeOffRequest: response.data['timeOffRequest'],
            reson: response.data['reason'],
            startTime: startFormattedDate,
            endTime: endFormattedDate,
            sickTime: response.data['sickTime'],
            hours: response.data['Hours'], employeeTimeOffId: response.data['employeeTimeOffId'], companyId: response.data['companyId']);

    } else {
      print("TimeOff prefill");
    }
    return itemsData;
  } catch (e) {
    print("error${e}");
    return itemsData;
  }
}
