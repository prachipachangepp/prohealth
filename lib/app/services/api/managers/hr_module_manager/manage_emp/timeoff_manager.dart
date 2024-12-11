import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/services/api/api.dart';
import 'package:prohealth/app/services/api/repository/hr_module_repository/manage_emp/manage_emp_repo.dart';
import 'package:prohealth/app/services/token/token_manager.dart';
import 'package:prohealth/data/api_data/api_data.dart';
import 'package:prohealth/data/api_data/hr_module_data/manage/timeoff_data.dart';

Future<List<TimeOfffData>> getEmployeeTimeOff(
    BuildContext context,) async {
  String convertIsoToDayMonthYear(String isoDate) {
    // Parse ISO date string to DateTime object
    DateTime dateTime = DateTime.parse(isoDate);

    // Create a DateFormat object to format the date
    DateFormat dateFormat = DateFormat('MM-dd-yyyy');

    // Format the date into "dd mm yy" format
    String formattedDate = dateFormat.format(dateTime);

    return formattedDate;
  };
  String convertedTime(String isoDate ){
    DateTime utcTime = DateTime.parse(isoDate);
    DateTime localTime = utcTime.toLocal(); // Convert to local time if needed

    // Format with AM/PM
    //String utcTimeFormatted = DateFormat('hh:mm a').format(utcTime);
    String localTimeFormatted = DateFormat('hh:mm a').format(localTime);

  print('Local Time (hh:mm a): $localTimeFormatted');
    return localTimeFormatted ;

  }

  List<TimeOfffData> itemsData = [];
  try {
    final companyId = await TokenManager.getCompanyId();
    final response = await Api(context)
        .get(path: ManageReposotory.getEmployeeTimeOff(companyId: companyId));
    if (response.statusCode == 200 || response.statusCode == 201) {
      for (var item in response.data) {
        String startFormattedDate = convertIsoToDayMonthYear(item['startTime']);
        String endFormattedDate = convertIsoToDayMonthYear(item['endTime']);
        String convertedSickTime = convertedTime( item['sickTime']);
        itemsData.add(TimeOfffData(
            imageUrl: item['imageUrl']??"",
          approved: item['approve'],
            employeeId: item['employeeId'],
            employeeName: item['employeeName'],
            timeOffRequest: item['timeOffRequest'],
            reson: item['reason'],
            startTime: startFormattedDate,
            endTime: endFormattedDate,
            sickTime: convertedSickTime,
            hours: item['Hours'], employeeTimeOffId: item['employeeTimeOffId']));
        itemsData.sort((a, b) => a.employeeName.compareTo(b.employeeName));
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
    String timeOffRequest,
    String reson,
    String startTime,
    String endTime,
    String sickTime,
    String hours
    ) async {
  try {
    final companyId = await TokenManager.getCompanyId();
    var response = await Api(context).patch(path: ManageReposotory.patchEmployeeTimeOff(employeeTimeOffId: employeeTimeOffId), data: {
      "employeeId": employeeID,
      "companyId": companyId,
      "timeOffRequest": timeOffRequest,
      "reason": reson,
      "startTime": "${startTime}T00:00:00Z",
      "endTime":"${endTime}T00:00:00Z",
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
    DateFormat dateFormat = DateFormat('yyyy-MM-dd');

    // Format the date into "dd mm yy" format
    String formattedDate = dateFormat.format(dateTime);

    return formattedDate;
  }

  var itemsData;
  try {
    final response = await Api(context)
        .get(path: ManageReposotory.getEmployeePrefillTimeOff(employeeTimeOffId: employeeTimeOffId));
    if (response.statusCode == 200 || response.statusCode == 201) {
        // String startFormattedDate = convertIsoToDayMonthYear(response.data['startTime']);
        // String endFormattedDate = convertIsoToDayMonthYear(response.data['endTime']);
        itemsData = TimeOfPrefillData(
            employeeId: response.data['employeeId'],
            employeeName: response.data['employeeName'],
            timeOffRequest: response.data['timeOffRequest'],
            reson: response.data['reason'],
            startTime: response.data['startTime'],
            endTime: response.data['endTime'],
            sickTime: response.data['sickTime'],
            hours: response.data['Hours'], employeeTimeOffId: response.data['employeeTimeOffId']);

    } else {
      print("TimeOff prefill");
    }
    return itemsData;
  } catch (e) {
    print("error${e}");
    return itemsData;
  }
}

/// Reject TimeOff
Future<ApiData> rejectTimeOffPatch(BuildContext context, int employeeTimeOffId) async {
  try {
    var response = await Api(context).patch(
      path: ManageReposotory.rejectTimeOffPatch(employeeTimeOffId: employeeTimeOffId),
      data: {},
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("TimeOff rejected");
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

/// Approve TimeOff
Future<ApiData> approveTimeOffPatch(BuildContext context, int employeeTimeOffId) async {
  try {
    var response = await Api(context).patch(
      path: ManageReposotory.approveTimeOffPatch(employeeTimeOffId: employeeTimeOffId),
      data: {},
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("TimeOff Approved");
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
