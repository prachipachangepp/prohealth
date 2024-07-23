import 'package:flutter/material.dart';

import '../../../../../../data/api_data/api_data.dart';
import '../../../../../resources/const_string.dart';
import '../../../api.dart';
import '../../../repository/hr_module_repository/form_repository/form_general_repo.dart';

Future<ApiData> postreferencescreen(
    BuildContext context,
    String association,
    String comment,
    String company,
    String email,
    int employeeId,
    String mob,
    String name,
    String references,
    String title) async {
  try {
    var response = await Api(context).post(
      path: ProgressBarRepository.postreferencescreen(),
      data: {
        "association": association,
        "comment": comment,
        "company": company,
        "email": email,
        "employeeId": employeeId,
        "mob": mob,
        "name": name,
        "references": references,
        "title": title
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("reference Added");
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
