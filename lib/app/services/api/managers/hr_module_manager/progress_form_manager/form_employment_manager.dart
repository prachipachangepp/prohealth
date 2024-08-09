import 'package:flutter/material.dart';
import 'package:prohealth/app/services/api/api_offer.dart';

import '../../../../../../data/api_data/api_data.dart';
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
    String country
    ) async {
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
        "dateOfJoining": "${dateOfJoining}T00:00:00Z", //"${dateOfBirth}T00:00:00Z"
        "endDate": "${endDate}T00:00:00Z",
        "emgMobile": emgMobile,
        "country": country
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("employment Added");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Employment data saved")),
      );
      // orgDocumentGet(context);
      return ApiDataRegister(
          statusCode: response.statusCode!,
          success: true,
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
