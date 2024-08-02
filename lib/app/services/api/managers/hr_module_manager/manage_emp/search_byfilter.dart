
import 'package:flutter/cupertino.dart';
import 'package:prohealth/app/services/api/repository/hr_module_repository/manage_emp/search_byfilter_repo.dart';

import '../../../../../../data/api_data/api_data.dart';
import '../../../../../resources/const_string.dart';
import '../../../api.dart';

/// Add search by employee
Future<ApiData> postSearchByFilter(
    BuildContext context,
    bool patientProfileSearch,
    String profileName,
    bool officeLocationSearch,
    String officeId,
    bool zoneSearch,
    int zoneId,
    bool licenseSearch,
    String licenseStatus,
    bool availabilitySearch,
    String availability

    ) async {
  try {
    var response = await Api(context).post(
      path: SearchByfilterRepo.employeeSearchByFilter(),
      data: {
         "patientProfileSearch":  patientProfileSearch,
         "profileName":profileName,
         "officeLocationSearch": officeLocationSearch,
         "officeId": officeId,
         "zoneSearch": zoneSearch,
         "zoneId": zoneId,
         "licenseSearch": licenseSearch,
         "licenseStatus": licenseStatus,
         "availabilitySearch":availabilitySearch,
         "availability": availability

        // "employeeId": employeeId,
        // "graduate": graduate,
        // "degree": degree,
        // "major": major,
        // "city": city,
        // "college": college,
        // "phone": phone,
        // "state": state,
        // "country": country,
        // "startDate": "${startDate}T00:00:00Z"
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Search By Filter Done");
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