import 'package:flutter/material.dart';

import '../../../../../../data/api_data/api_data.dart';
import '../../../../../resources/const_string.dart';
import '../../../api.dart';
import '../../../repository/hr_module_repository/form_repository/form_general_repo.dart';

Future<ApiData> postemploymentscreen(
    BuildContext context,
    int employeeId,
    String employer,
    String city,
    String reason,
    String supervisor,
    String supMobile,
    String title,
    String emgMobile,
    String country
    ) async {
  try {
    var response = await Api(context).post(
      path: ProgressBarRepository.postemploymentscreen(),
      data: {
        "employeeId": employeeId,
        "employer": employer,
        "city": city,
        "reason": reason,
        "supervisor": supervisor,
        "supMobile": supMobile,
        "title": title,
        "dateOfJoining": "2024-07-19T05:04:43.386Z",
        "endDate": "2024-07-19T05:04:43.386Z",
        "emgMobile": emgMobile,
        "country": country
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("employment Added");
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
