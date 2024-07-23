import 'package:flutter/material.dart';

import '../../../../../../data/api_data/api_data.dart';
import '../../../../../resources/const_string.dart';
import '../../../api.dart';
import '../../../repository/hr_module_repository/form_repository/form_general_repo.dart';

Future<ApiData> posteducationscreen(
    BuildContext context,
    int employeeId,
    String graduate,
    String degree,
    String major,
    String city,
    String college,
    String phone,
    String state,
    String country,

    ) async {
  try {
    var response = await Api(context).post(
      path: ProgressBarRepository.posteducationscreen(),
      data: {
        "employeeId": employeeId,
        "graduate": graduate,
        "degree": degree,
        "major": major,
        "city": city,
        "college": college,
        "phone": phone,
        "state": state,
        "country": country,
        "startDate": "2024-07-19T05:39:30.593Z"
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("education Added");
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
