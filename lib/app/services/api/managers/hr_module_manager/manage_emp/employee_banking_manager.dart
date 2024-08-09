import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/services/api/api.dart';
import 'package:prohealth/app/services/api/repository/hr_module_repository/manage_emp/manage_emp_repo.dart';
import 'package:prohealth/app/services/encode_decode_base64.dart';
import 'package:prohealth/data/api_data/api_data.dart';
import 'package:prohealth/data/api_data/hr_module_data/manage/employee_banking_data.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/whitelabelling/success_popup.dart';

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
        .get(path: ManageReposotory.getBankingEmployee(employeeId: employeeId, approveOnly: 'no'));
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
        itemsData.sort((a, b) => a.empBankingId.compareTo(b.empBankingId));
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
Future<EmployeeBankingPrefillData> getPrefillEmployeeBancking(
    BuildContext context, int empBankingId) async {
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
        .get(path: ManageReposotory.getPrefillBankingEmployee(empBankingId: empBankingId));
    if (response.statusCode == 200 || response.statusCode == 201) {

        String effectiveFormattedDate = convertIsoToDayMonthYear(response.data['effectiveDate']);
        // String issueFormattedDate = convertIsoToDayMonthYear(item['issueDate']);
        itemsData = EmployeeBankingPrefillData(
          percentage: response.data['requestedPercentage']??"--",
            empBankingId: response.data['empBankingId'],
            employeeId: response.data['employeeId'],
            accountNumber: response.data['accountNumber'],
            bankName: response.data['bankName'],
            amountRequested: response.data['amountRequested'],
            checkUrl: response.data['checkUrl'],
            effectiveDate: effectiveFormattedDate,
            routinNumber: response.data['routingNumber'],
            type: response.data['type'],
           // approve: response.data['approve'] ?? true
            );
        print("ItemData${itemsData.toString()}");

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
    String percentage,
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
        "effectiveDate": "${effectiveDate}T00:00:00Z",
        "routingNumber": routingNumber,
        "type": type,
        "requestedPercentage": percentage,
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Banking updated");
      // orgDocumentGet(context);
      // showDialog(
      //   context: context,
      //   builder: (BuildContext context) {
      //     Future.delayed(Duration(seconds: 3), () {
      //       if (Navigator.of(context).canPop()) {
      //         Navigator.of(context).pop();
      //       }
      //     });
      //     return AddSuccessPopup(message: 'Data Updated Successfully',);
      //   },
      // );
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

/// Attach bncking document
Future<ApiData> uploadBanckingDocument(
    BuildContext context,
    int banckingId,
    dynamic documentFile) async {
  try {
    String document = await AppFilePickerBase64.getEncodeBase64(bytes: documentFile);
    var response = await Api(context).post(
      path: ManageReposotory.uploadBanckingDocuments(empBankingId:banckingId),
      data: {
      "base64": document
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Document uploaded");
      return ApiData(
          statusCode: response.statusCode!,
          success: true,
          message: response.statusMessage!);

    } else {
      print("Upload Error 1");
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

/// Reject license
Future<ApiData> rejectBankPatch(BuildContext context, int empBankingId) async {
  try {
    var response = await Api(context).patch(
      path: ManageReposotory.rejectBankingEmployee(empBankingId: empBankingId),
      data: {},
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Bank rejected");
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

/// Approve license
Future<ApiData> approveBankPatch(BuildContext context, int empBankingId) async {
  try {
    var response = await Api(context).patch(
      path: ManageReposotory.approveBankingEmployee(empBankingId: empBankingId),
      data: {},
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Bank Approved");
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