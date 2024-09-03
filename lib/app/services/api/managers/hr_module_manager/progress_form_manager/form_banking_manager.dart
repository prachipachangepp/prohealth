import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/services/api/api_offer.dart';
import 'package:prohealth/app/services/api/repository/hr_module_repository/manage_emp/manage_emp_repo.dart';
import 'package:prohealth/app/services/base64/encode_decode_base64.dart';

import '../../../../../../data/api_data/api_data.dart';
import '../../../../../../data/api_data/hr_module_data/progress_form_data/form_banking_data.dart';
import '../../../../../resources/const_string.dart';
import '../../../api.dart';
import '../../../repository/hr_module_repository/form_repository/form_general_repo.dart';

Future<ApiDataRegister> postbankingscreenData(
    BuildContext context,
    int employeeId,
    String accountNumber,
    String bankName,
    int amountRequested,
    String checkUrl,
    String effectiveDate,
    String routingNumber,
    String type,
    String requestedPercentage
    ) async {
  try {
    var response = await ApiOffer(context).post(
      path: ProgressBarRepository.postbankingscreen(),
      data: {
        "employeeId": employeeId,
        "accountNumber": accountNumber,
        "bankName": bankName,
        "amountRequested": amountRequested,
        "checkUrl": checkUrl,
        "effectiveDate": "${effectiveDate}T00:00:00Z",  //"${dateOfBirth}T00:00:00Z"
        "routingNumber": routingNumber,
        "type": type,
        "requestedPercentage": requestedPercentage
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("banking Added");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Banking data saved"),backgroundColor: Colors.green,),
      );
      var bankResponse = response.data;
      var banckingId = bankResponse['empBankingId'];
      // orgDocumentGet(context);
      return ApiDataRegister(
          statusCode: response.statusCode!,
          success: true,
          banckingId: banckingId,
          message: response.statusMessage!);
    } else {
      print("Error 1");
      return ApiDataRegister(
          statusCode: response.statusCode!,
          success: false,
          message: response.data['message']);
    }
  } catch (e) {
    print("Error $e");
    return ApiDataRegister(
        statusCode: 404, success: false, message: AppString.somethingWentWrong);
  }
}

Future<ApiData> uploadcheck({
  required BuildContext context,
  required int employeeid,
  required int empBankingId,
  required dynamic documentFile,
  required String documentName
}) async {
  try {
    String documents = await AppFilePickerBase64.getEncodeBase64(bytes: documentFile);
    print("File :::${documents}" );
    var response = await Api(context).post(
      path:ManageReposotory.uploadcheck(empBankingId: empBankingId),
      data: {
        'base64':documents
      },
    );
    print("Response ${response.toString()}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(" Employee Check uploded");
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






///get prifill api
Future<List<BankingDataForm>> getBankingForm(
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

//var itemList ;
  List<BankingDataForm> itemsData = [];
  try {
    final response = await ApiOffer(context).get(
        path: ProgressBarRepository
            .getBankingByEmpID(employeeID: employeeId));
    if (response.statusCode == 200 || response.statusCode == 201) {
      for (var item in response.data) {
        //String startDateFormattedDate = item['startDate'] == null ? "--" :convertIsoToDayMonthYear(item['expDate']);
        String FormattedDate = convertIsoToDayMonthYear(item['effectiveDate']);
        itemsData.add(BankingDataForm(
          empBankingId: item['empBankingId']??00,
          employeeId: item['employeeId']??00,
          accountNumber: item['accountNumber']??"--",
          bankName: item['bankName']??"--",
          amountRequested: item['amountRequested']??00,
          checkUrl: item['checkUrl']??"--",
          effectiveDate: FormattedDate,
          routingNumber: item['routingNumber']??"--",
          type: item['type']??"--",
          requestedPercentage: item['requestedPercentage']??"--",

        ));
        // itemsData.sort((a, b) => a.educationId.compareTo(b.educationId));
      }
    } else {
      print("Employee Banking");
    }
    return itemsData;
  } catch (e) {
    print("error${e}");
    return itemsData;
  }
}
