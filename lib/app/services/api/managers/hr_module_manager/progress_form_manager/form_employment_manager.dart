import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prohealth/app/services/api/api_offer.dart';

import '../../../../../../data/api_data/api_data.dart';
import '../../../../../../data/api_data/hr_module_data/progress_form_data/form_employment_data.dart';
import '../../../../../resources/const_string.dart';
import '../../../api.dart';
import '../../../repository/hr_module_repository/form_repository/form_general_repo.dart';

Future<ApiDataRegister> postemploymentscreen(
    BuildContext context,
    int employeeId,
    String employer,
    String city,
    String reason,
    String supervisor,
    String supMobile,
    String title,
    String dateOfJoining,
    String endDate,
    String emgMobile,
    String country) async {
  try {
    var response = await ApiOffer(context).post(
      path: ProgressBarRepository.postemploymentscreen(),
      data: {
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
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("employment Added");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Employment data saved"),
          backgroundColor: Colors.green,),
      );
      // orgDocumentGet(context);
      return ApiDataRegister(
          statusCode: response.statusCode!,
          success: true,
          message: response.statusMessage!);
    } else {
      print("Error 1");
      print("::::::::::::: no data added");

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

///prifill api get
///
Future<List<EmploymentDataForm>> getEmployeeHistoryForm(
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
  List<EmploymentDataForm> itemsData = [];
  try {
    final response = await ApiOffer(context).get(
        path: ProgressBarRepository()
            .getEmploymentByEmpID(employeeID: employeeId));
    if (response.statusCode == 200 || response.statusCode == 201) {
      for (var item in response.data) {
        // String startDateFormattedDate = item['startDate'] == null ? "--" :convertIsoToDayMonthYear(item['expDate']);
        String issueFormattedDate = convertIsoToDayMonthYear(item['dateOfJoining']);
        String endDateFormattedDate = convertIsoToDayMonthYear(item['endDate']);
        itemsData.add(EmploymentDataForm(
            employmentId: item['employmentId']??"--",
            employeeId: item['employeeId']??"--",
            employer: item['employer']??"--",
            city: item['city']??"--",
            reason: item['reason']??"--",
            supervisor: item['supervisor']??"--",
            supMobile: item['supMobile']??"--",
            title: item['title']??"--",
            dateOfJoining: issueFormattedDate??"--",
            endDate: endDateFormattedDate??"--",
            emgMobile: item['emgMobile']??"--",
            country: item['country']??"--",
        ));
         itemsData.sort((a, b) => a.employmentId.compareTo(b.employmentId));
      }
    } else {
      print("Employee Education");
    }
    return itemsData;
  } catch (e) {
    print("error${e}");
    return itemsData;
  }
}
