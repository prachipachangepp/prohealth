import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/services/api/api.dart';
import 'package:prohealth/app/services/api/repository/hr_module_repository/manage_emp/manage_emp_repo.dart';
import 'package:prohealth/data/api_data/api_data.dart';
import 'package:prohealth/data/api_data/hr_module_data/manage/employee_banking_data.dart';

Future<List<EmployeeBankingData>> getEmployeeBanking(
    BuildContext context, int employeeId) async {
  String convertIsoToDayMonthYear(String isoDate) {
    // Parse ISO date string to DateTime object
    DateTime dateTime = DateTime.parse(isoDate);

    // Create a DateFormat object to format the date
    DateFormat dateFormat = DateFormat('dd-MM-yyyy');

    // Format the date into "dd mm yy" format
    String formattedDate = dateFormat.format(dateTime);

    return formattedDate;
  }

  List<EmployeeBankingData> itemsData = [];
  try {
    final response = await Api(context)
        .get(path: ManageReposotory.getBankingEmployee(employeeId: employeeId));
    if (response.statusCode == 200 || response.statusCode == 201) {
      for (var item in response.data!) {
        //String effectiveFormattedDate = convertIsoToDayMonthYear(item['effectiveDate']);
        // String issueFormattedDate = convertIsoToDayMonthYear(item['issueDate']);
        itemsData.add(EmployeeBankingData(
            empBankingId: item['empBankingId'],
            employeeId: item['employeeId'],
            accountNumber: item['accountNumber'],
            bankName: item['bankName'],
            amountRequested: item['amountRequested'],
            checkUrl: item['checkUrl'],
            effectiveDate: item['effectiveDate'],
            routinNumber: item['routingNumber'],
            type: item['type'],
            approve: item['approved'] ?? false,
            ));
      }
    } else {
      print("Employee Bancking");
    }
    return itemsData;
  } catch (e) {
    print("error ${e}");
    return itemsData;
  }
}

/// Banking employee prefill Get
Future<EmployeeBankingData> getPrefillEmployeeBancking(
    BuildContext context, int employeeId) async {
  String convertIsoToDayMonthYear(String isoDate) {
    // Parse ISO date string to DateTime object
    DateTime dateTime = DateTime.parse(isoDate);

    // Create a DateFormat object to format the date
    DateFormat dateFormat = DateFormat('dd-MM-yy');

    // Format the date into "dd mm yy" format
    String formattedDate = dateFormat.format(dateTime);

    return formattedDate;
  }

  var itemsData;
  try {
    final response = await Api(context)
        .get(path: ManageReposotory.getBankingEmployee(employeeId: employeeId));
    if (response.statusCode == 200 || response.statusCode == 201) {

        String effectiveFormattedDate = convertIsoToDayMonthYear(response.data['effectiveDate']);
        // String issueFormattedDate = convertIsoToDayMonthYear(item['issueDate']);
        itemsData = EmployeeBankingPrefillData(
            empBankingId: response.data['empBankingId'],
            employeeId: response.data['employeeId'],
            accountNumber: response.data['accountNumber'],
            bankName: response.data['bankName'],
            amountRequested: response.data['amountRequested'],
            checkUrl: response.data['checkUrl'],
            effectiveDate: effectiveFormattedDate,
            routinNumber: response.data['routingNumber'],
            type: response.data['type'],
            );

    } else {
      print("Employee Prefill Bancking");
    }
    return itemsData;
  } catch (e) {
    print("error${e}");
    return itemsData;
  }
}

/// Banking patch api
Future<ApiData> PatchEmployeeBanking(
    BuildContext context,
    int bankingId,
    int employeeId,
    String accountNumber,
    String bankName,
    int amountRequested,
    String checkUrl,
    String effectiveDate,
    String routingNumber,
    String type) async {
  try {
    var response = await Api(context).patch(
      path: ManageReposotory.updateBankingEmployee(empBankingId:bankingId),
      data: {
        "employeeId": employeeId,
        "accountNumber": accountNumber,
        "bankName": bankName,
        "amountRequested": amountRequested,
        "checkUrl": checkUrl,
        "effectiveDate": effectiveDate,
        "routingNumber": routingNumber,
        "type": type
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Banking updated");
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
