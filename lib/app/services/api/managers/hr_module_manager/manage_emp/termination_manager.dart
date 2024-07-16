import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prohealth/app/services/api/api.dart';
import 'package:prohealth/app/services/api/repository/hr_module_repository/manage_emp/manage_emp_repo.dart';
import 'package:prohealth/data/api_data/hr_module_data/manage/termination_data.dart';

Future<List<TerminationData>> getTermination(BuildContext context,int companyId) async {
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
    final response =
        await Api(context).get(path: ManageReposotory.getTermination(companyId: companyId));
    if (response.statusCode == 200 || response.statusCode == 201) {
      for (var item in response.data) {

        String dateOfBirthFormattedDate =
            convertIsoToDayMonthYear(item['dateOfBirth']);
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
          dateOfTermination: item['dateofTermination'] ?? "--",
          dateOfResignation: item['dateofResignation'] ?? "--",
          rehirable: item['rehirable'] ?? "--",
          finalAddress: item['finalAddress'] ?? "--",
          type: item['type'] ?? "--",
          reson: item['reason'] ?? "--",
          finalPayCheck: item['finalPayCheck'] ?? 0,
          checkDate: item['checkDate'] ?? "--",
          grossPay: item['grossPay'] ?? 0,
          netPay: item['netPay'] ?? 0,
          methods: item['methods'] ?? "--",
          materials: item['materials'] ?? "--",
        ));
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
