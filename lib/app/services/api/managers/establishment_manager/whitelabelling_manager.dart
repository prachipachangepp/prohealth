

import 'package:flutter/cupertino.dart';

import '../../../../../data/api_data/api_data.dart';
import '../../../../resources/const_string.dart';
import '../../api.dart';
import '../../repository/establishment_manager/establishment_repository.dart';
import 'org_doc_ccd.dart';



Future<ApiData> postWhitelabellingAdd(
    BuildContext context,
    int companyId,
    String officeId,
    String primaryNo,
    String secondaryNo,
    String primFax,
    String secondaryFax,
    String email,
    String name,
    String address,

    ) async{
  try {
    var response = await Api(context).post(
        path: EstablishmentManagerRepository.
        postCompanyOffice(),
        data: {
          "company_id": 0,
          "office_id": officeId,
          "primary_phone": primaryNo,
          "secondary_phone": secondaryNo,
          "primary_fax": primFax,
          "secondary_fax": secondaryFax,
          "email": email,
          "name": name,
          "address": address,
        });
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Updated request");
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
    print("Error 2");
    return ApiData(
        statusCode: 404, success: false, message: AppString.somethingWentWrong);
  }
}