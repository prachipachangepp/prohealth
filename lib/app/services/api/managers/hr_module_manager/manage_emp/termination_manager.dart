import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/services/api/api.dart';
import 'package:prohealth/app/services/api/repository/hr_module_repository/manage_emp/manage_emp_repo.dart';
import 'package:prohealth/app/services/token/token_manager.dart';
import 'package:prohealth/data/api_data/api_data.dart';
import 'package:prohealth/data/api_data/hr_module_data/manage/termination_data.dart';

Future<List<TerminationData>> getTermination(BuildContext context) async {
  String convertIsoToDayMonthYear(String isoDate) {
    // Parse ISO date string to DateTime object
    DateTime dateTime = DateTime.parse(isoDate);

    // Create a DateFormat object to format the date
    DateFormat dateFormat = DateFormat('MM-dd-yyyy');

    // Format the date into "dd mm yy" format
    String formattedDate = dateFormat.format(dateTime);

    return formattedDate;
  }

  List<TerminationData> itemsData = [];
  try {
    final companyId = await TokenManager.getCompanyId();
    final response =
        await Api(context).get(path: ManageReposotory.getTermination(companyId: companyId));
    if (response.statusCode == 200 || response.statusCode == 201) {
      for (var item in response.data) {

        String dateOfBirthFormattedDate =
            convertIsoToDayMonthYear(item['dateOfBirth']);
        String terminationDate =
        convertIsoToDayMonthYear(item['dateofTermination']);
        String resignationDate =
        convertIsoToDayMonthYear(item['dateofResignation']);
        String checkDate =
        convertIsoToDayMonthYear(item['checkDate']);
        itemsData.add(TerminationData(
          employeeId: item['employeeId'],
          code: item['code'],
          userId: item['userId'],
          firstName: item['firstName'],
          lastName: item['lastName'],
          deptId: item['departmentId'],
          employeeTypeId: item['employeeTypeId'],
          expertise: item['expertise'],
          cityId: item['cityId'],
          countyId: item['countryId'] ?? 0,
          zoinId: item['zoneId'] ?? 0,
          SSNNbr: item['SSNNbr'],
          primaryPhoneNo: item['primaryPhoneNbr'],
          secoundayPhoneNo: item['secondryPhoneNbr'],
          workPhoneNo: item['workPhoneNbr'],
          regOfficeId: item['regOfficId'],
          personalEmail: item['personalEmail'],
          workEmail: item['workEmail'],
          address: item['address'],
          dateOdBirth: dateOfBirthFormattedDate,
          emergencyContact: item['emergencyContact'],
          covrage: item['covreage'],
          employment: item['employment'],
          gender: item['gender'],
          status: item['status'],
          service: item['service'],
          imgUrl: item['imgurl'],
          resumeUrl: item['resumeurl'],
          onbordinStatus: item['onboardingStatus'],
          createdAt: item['createdAt'] ?? "--",
          companyId: item['companyId'],
          terminationFlag: item['terminationFlag'],
          approved: item['approved'] ?? true,
          dateOfTermination: terminationDate ?? "--",
          dateOfResignation: resignationDate ?? "--",
          rehirable: item['rehirable'] ?? "--",
          finalAddress: item['finalAddress'] ?? "--",
          type: item['type'] ?? "--",
          reson: item['reason'] ?? "--",
          finalPayCheck: item['finalPayCheck'] ?? 0,
          checkDate: checkDate ?? "--",
          grossPay: item['grossPay'] ?? 0,
          netPay: item['netPay'] ?? 0,
          methods: item['methods'] ?? "--",
          materials: item['materials'] ?? "--",
        ));
        itemsData.sort((a, b) => a.userId.compareTo(b.userId));
      }
    } else {
      print("Termination error");
    }
    return itemsData;
  } catch (e) {
    print("error${e}");
    return itemsData;
  }
}

/// Get termination data employee Id wise prefill
Future<TerminateEmployeePrefillData> getTerminationEmployeePerfill({required BuildContext context,required int employeeId}) async {
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
    final companyId = await TokenManager.getCompanyId();
    final response =
    await Api(context).get(path: ManageReposotory.getTerminationPreFillEmp(employeeId: employeeId));
    if (response.statusCode == 200 || response.statusCode == 201) {
        String dateofTermination =
        convertIsoToDayMonthYear(response.data['dateofTermination'] ?? "0000-00-00");
        String dateofResignation =
        convertIsoToDayMonthYear(response.data['dateofResignation'] ?? "0000-00-00");
        String dateofHire =
        convertIsoToDayMonthYear(response.data['dateofHire'] ?? "0000-00-00");
        String checkDate =
        convertIsoToDayMonthYear(response.data['checkDate'] ?? "0000-00-00");
        itemsData = TerminateEmployeePrefillData(
          employeeId: response.data['employeeId'],
          firstName: response.data['firstName']??"--",
          lastName: response.data['lastName']??"--",
          status: response.data['status'],
          rehirable: response.data['rehirable'] ?? "--",
          finalAddress: response.data['finalAddress'] ?? "--",
          type: response.data['type'] ?? "--",
          finalPayCheck: response.data['finalPayCheck'] ?? 0,
          checkDate: checkDate ?? "0000-00-00",
          grossPay: response.data['grossPay'] ?? 0,
          netPay: response.data['netPay'] ?? 0,
          methods: response.data['methods'] ?? "--",
          materials: response.data['materials'] ?? "--",
          primaryPhoneNbr: response.data['primaryPhoneNbr']??"--",
          terminationFlag: response.data['terminationFlag']??false,
          dateofTermination: dateofTermination??"--",
          dateofResignation: dateofResignation??"--",
          dateofHire: dateofHire??"--",
          position: response.data['position']??"--",
          reason: response.data['reason']??"--",
        );
    } else {
      print("Termination Prefill error");
    }
    return itemsData;
  } catch (e) {
    print("error${e}");
    return itemsData;
  }
}


/// Terminate employee Patch
Future<ApiData> patchEmployeeTermination({required BuildContext context, required int employeeId,
  required String dateofTermination,required String dateofResignation,required String dateofHire,
  required String rehirable, required String position, required String finalAddress,required String type,
  required String reason, required double finalPayCheck, required String checkDate, required double grossPay,
  required double netPay, required String methods, required String materials ,required String status}) async {
  try {
    var response = await Api(context).patch(path: ManageReposotory.patchTerminateEmployee(employeeId: employeeId), data: {
  "dateofTermination": "${dateofTermination}T00:00:00Z",
  "dateofResignation": "${dateofResignation}T00:00:00Z",
  "dateofHire": "${dateofHire}T00:00:00Z",
  "rehirable": rehirable,
  "position": position,
  "finalAddress": finalAddress,
  "type": type,
  "reason": reason,
  "finalPayCheck": finalPayCheck,
  "checkDate": "${checkDate}T00:00:00Z",
  "grossPay": grossPay,
  "netPay": netPay,
  "methods": methods,
  "materials": materials,
  "status": status
},);
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Employee Terminated");
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


