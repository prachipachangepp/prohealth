import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/services/api/api.dart';
import 'package:prohealth/app/services/api/repository/hr_module_repository/manage_emp/manage_emp_repo.dart';
import 'package:prohealth/data/api_data/api_data.dart';
import 'package:prohealth/data/api_data/hr_module_data/manage/employeement_data.dart';

import '../../../../base64/encode_decode_base64.dart';

Future<List<EmployeementData>> getEmployeement(
    BuildContext context, int employeeId) async {
  String convertIsoToDayMonthYear(String isoDate) {
    // Parse ISO date string to DateTime object
    DateTime dateTime = DateTime.parse(isoDate);

    // Create a DateFormat object to format the date
    DateFormat dateFormat = DateFormat('yyyy-MM-dd');

    // Format the date into "dd mm yy" format
    String formattedDate = dateFormat.format(dateTime);

    return formattedDate;
  }

  List<EmployeementData> itemsData = [];
  try {
    final response = await Api(context)
        .get(path: ManageReposotory.getEmployeement(employeeId: employeeId, approveOnly: 'no'));
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
            approved: item['approved'],
            emgMobile: item['emgMobile'],
            country: item['country'],
            sucess: true, message: response.statusMessage!));
        itemsData.sort((a, b) => a.employmentId.compareTo(b.employmentId));
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
    int employeeId,String employer,String city,String reason,String supervisor,String supMobile,
    String title,String dateOfJoining,String endDate,String emgMobile,String country
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
      "endDate":"${endDate}T00:00:00Z",
      "emgMobile": emgMobile,
      "country": country
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


/// Patch employeement
Future<ApiData> updateEmployeementPatch(BuildContext context,
    int employeeIdupdate,int employeeId,String employer,String city,String reason,String supervisor,String supMobile,
    String title,String dateOfJoining,String endDate,String emgMobile,String country
    ) async {
  try {
    var response = await Api(context).patch(path: ManageReposotory.updateEmployeement(employeementId: employeeIdupdate), data: {
      "employeeId": employeeId,
      "employer": employer,
      "city": city,
      "reason": reason,
      "supervisor": supervisor,
      "supMobile": supMobile,
      "title": title,
      "dateOfJoining": "${dateOfJoining}T00:00:00Z",
      "endDate": "${endDate}T00:00:00Z",
      "emgMobile": emgMobile,
      "country": country
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

/// Prefill get employeement
Future<EmployeementPrefillData> getPrefillEmployeement(
    BuildContext context, int employeementId) async {
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
        .get(path: ManageReposotory.updateEmployeement(employeementId: employeementId));
    if (response.statusCode == 200 || response.statusCode == 201) {
        String joiningFormattedDate =
        convertIsoToDayMonthYear(response.data['dateOfJoining']);
        String endFormattedDate = convertIsoToDayMonthYear(response.data['endDate']);
        itemsData = EmployeementPrefillData(
            employmentId: response.data['employmentId'],
            employeeId: response.data['employeeId'],
            employer: response.data['employer'],
            city: response.data['city'],
            reason: response.data['reason'],
            supervisor: response.data['supervisor'],
            supMobile: response.data['supMobile'],
            title: response.data['title'],
            dateOfJoining: joiningFormattedDate,
            endDate: endFormattedDate,
            approved: response.data['approved'],
            sucess: true,
            message: response.statusMessage!,
            emgMobile: response.data['emgMobile'],
            country: response.data['country']);
    } else {
      print("Employee Employeement");
    }
    return itemsData;
  } catch (e) {
    print("error${e}");
    return itemsData;
  }
}


///upload resume


Future<ApiData> uploadEmployeeResume({
  required BuildContext context,

  required int employeementId,
  required dynamic documentFile,
  required String documentName
}) async {
  try {
    String documents = await AppFilePickerBase64.getEncodeBase64(bytes: documentFile);
    print("File :::${documents}" );
    var response = await Api(context).post(
      path:ManageReposotory.updateEmployeementresume(employeementId: employeementId),
      data: {
        'base64':documents
      },
    );
    print("Response ${response.toString()}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(" Employee Resume uploded");
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


///upload photo general form screen
///
Future<ApiData> uploadphoto({
  required BuildContext context,

  required int employeeid,
  required dynamic documentFile,
  required String documentName
}) async {
  try {
    String documents = await AppFilePickerBase64.getEncodeBase64(bytes: documentFile);
    print("File :::${documents}" );
    var response = await Api(context).post(
      path:ManageReposotory.uploadphoto(employeeid: employeeid),
      data: {
        'base64':documents
      },
    );
    print("Response ${response.toString()}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(" Employee Resume uploded");
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




/// linceses uploaded
///

Future<ApiData> uploadlinceses({
  required BuildContext context,


  required int employeeid,
  required int licensedId,
  required dynamic documentFile,
  required String documentName
}) async {
  try {
    String documents = await AppFilePickerBase64.getEncodeBase64(bytes: documentFile);
    print("File :::${documents}" );
    var response = await Api(context).post(
      path:ManageReposotory.uploadlinceses(licensedId:licensedId),
      data: {
        'base64':documents
      },
    );
    print("Response ${response.toString()}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(" license uploded");
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

///////
////////
//////
///upload check




