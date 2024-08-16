
import 'package:flutter/cupertino.dart';
import 'package:prohealth/app/services/api/repository/hr_module_repository/manage_emp/search_byfilter_repo.dart';

import '../../../../../../data/api_data/api_data.dart';
import '../../../../../resources/const_string.dart';
import '../../../api.dart';

/// Add search by employee
Future<List<ApiDataFilter>?> postSearchByFilter(
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
    String availability,
    bool isDZone,
    int loggedUserId,

    ) async {
  try {
    List<ApiDataFilter> responseList = [];
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
         "availability": availability,
         "isDZone":isDZone,
         "loggedInUserId":loggedUserId

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

      for(var i in response.data){
        var employeID = i['employeeId'];
         responseList.add(ApiDataFilter(
            statusCode: response.statusCode!,
            success: true,
            message: response.statusMessage!,
            employeeId:employeID));
      }

    } else {
      print("Error 1");
    }
    return responseList;
  } catch (e) {
    print("Error $e");
  }
}