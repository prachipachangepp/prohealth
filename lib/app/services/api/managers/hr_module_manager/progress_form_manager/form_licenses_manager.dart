import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/services/api/api_offer.dart';

import '../../../../../../data/api_data/api_data.dart';
import '../../../../../../data/api_data/hr_module_data/progress_form_data/form_licenses_data.dart';
import '../../../../../resources/const_string.dart';
import '../../../api.dart';
import '../../../repository/hr_module_repository/form_repository/form_general_repo.dart';

Future<ApiDataRegister> postlicensesscreenData(
    BuildContext context,
    String country,
    int employeeId,
    String expDate,
    String issueDate,
    String licenseUrl,
    String licensure,
    String licenseNumber,
    String org,
    String documentType) async {
  try {
    var response = await ApiOffer(context).post(
      path: ProgressBarRepository.postlicensesscreen(),
      data: {
        "country": country,
        "employeeId": employeeId,
        "expDate":   "${expDate}T00:00:00Z",
        "issueDate":"${issueDate}T00:00:00Z",
        "licenseUrl": licenseUrl,
        "licensure": licensure,
        "licenseNumber": licenseNumber,
        "org": org,
        "documentType": documentType
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("licenses Added");
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text("Licenses data saved"),backgroundColor: Colors.green,),
      // );
      var data = response.data;
      var liscenseIdget = data['licenseId'];
      // orgDocumentGet(context);
      return ApiDataRegister(
          statusCode: response.statusCode!,
          success: true,
          licenses: liscenseIdget,
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






////get prifill api

Future<List<LicensesDataForm>> getLicensesForm(
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
  List<LicensesDataForm> itemsData = [];
  try {
    final response = await ApiOffer(context).get(
        path: ProgressBarRepository
            .getLicensesByEmpID(employeeID: employeeId));
    if (response.statusCode == 200 || response.statusCode == 201) {
      for (var item in response.data) {
        //String startDateFormattedDate = item['startDate'] == null ? "--" :convertIsoToDayMonthYear(item['expDate']);
        String issueFormattedDate = convertIsoToDayMonthYear(item['issueDate']);
        String expFormattedDate = convertIsoToDayMonthYear(item['expDate']);
        itemsData.add(LicensesDataForm(
          licenseId: item['licenseId']??0,
          country: item['country']??"--",
          employeeId: item['employeeId']??2,
          expDate: expFormattedDate,
          issueDate: issueFormattedDate,
          licenseUrl: item['licenseUrl']??"--",
          licensure: item['licensure']??"--",
          licenseNumber: item['licenseNumber']??"--",
          org: item['org']??"--",
          documentType: item['documentType']??"--",

        ));
        // itemsData.sort((a, b) => a.educationId.compareTo(b.educationId));
      }
    } else {
      print("Employee licenses");
    }
    return itemsData;
  } catch (e) {
    print("error${e}");
    return itemsData;
  }
}
