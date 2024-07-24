import 'package:flutter/material.dart';

import '../../../../../../data/api_data/api_data.dart';
import '../../../../../resources/const_string.dart';
import '../../../api.dart';
import '../../../repository/hr_module_repository/form_repository/form_general_repo.dart';

Future<ApiData> postbankingscreen(
    BuildContext context,
    int employeeId,
    String accountNumber,
    String bankName,
    int amountRequested,
    String checkUrl,
    String routingNumber,
    String type,
    String requestedPercentage
    ) async {
  try {
    var response = await Api(context).post(
      path: ProgressBarRepository.postbankingscreen(),
      data: {
        "employeeId": employeeId,
        "accountNumber": accountNumber,
        "bankName": bankName,
        "amountRequested": amountRequested,
        "checkUrl": checkUrl,
        "effectiveDate": "2024-07-19T06:06:32.687Z",
        "routingNumber": routingNumber,
        "type": type,
        "requestedPercentage": requestedPercentage
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("banking Added");
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
