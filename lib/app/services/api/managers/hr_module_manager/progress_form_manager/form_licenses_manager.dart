import 'package:flutter/material.dart';
import 'package:prohealth/app/services/api/api_offer.dart';

import '../../../../../../data/api_data/api_data.dart';
import '../../../../../resources/const_string.dart';
import '../../../api.dart';
import '../../../repository/hr_module_repository/form_repository/form_general_repo.dart';

Future<ApiDataRegister> postlicensesscreen(
    BuildContext context,
    String country,
    int employeeId,
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
        "expDate": "2024-07-19T05:59:02.929Z",
        "issueDate": "2024-07-19T05:59:02.929Z",
        "licenseUrl": licenseUrl,
        "licensure": licensure,
        "licenseNumber": licenseNumber,
        "org": org,
        "documentType": documentType
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("licenses Added");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Licenses data saved")),
      );
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
