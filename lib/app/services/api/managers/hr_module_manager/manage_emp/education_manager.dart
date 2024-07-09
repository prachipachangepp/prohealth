import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prohealth/app/services/api/api.dart';
import 'package:prohealth/app/services/api/repository/hr_module_repository/manage_emp/manage_emp_repo.dart';
import 'package:prohealth/data/api_data/hr_module_data/manage/education_data.dart';

Future<List<EducationData>> getEmployeeEducation(
    BuildContext context,int employeeId) async {
  String convertIsoToDayMonthYear(String isoDate) {
    // Parse ISO date string to DateTime object
    DateTime dateTime = DateTime.parse(isoDate);

    // Create a DateFormat object to format the date
    DateFormat dateFormat = DateFormat('dd MMM yyyy');

    // Format the date into "dd mm yy" format
    String formattedDate = dateFormat.format(dateTime);

    return formattedDate;
  }
  List<EducationData> itemsData = [];
  try {
    final response = await Api(context)
        .get(path: ManageReposotory.getEmployeeDucation(employeeId: employeeId));
    if (response.statusCode == 200 || response.statusCode == 201) {
      for (var item in response.data) {
        // String expFormattedDate = convertIsoToDayMonthYear(item['expDate']);
        // String issueFormattedDate = convertIsoToDayMonthYear(item['issueDate']);
        itemsData.add(EducationData(educationId: item['educationId'], employeeID: item['employeeId'], graduate: item['graduate'], degree: item['degree'],
            major: item['major'], city: item['city'], college: item['college'], phone: item['phone'], state: item['state'],approved: item['approved']));
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