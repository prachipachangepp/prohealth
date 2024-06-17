

import 'package:flutter/material.dart';
import 'package:prohealth/app/services/api/api.dart';
import 'package:prohealth/app/services/api/repository/establishment_manager/establishment_repository.dart';
import 'package:prohealth/data/api_data/establishment_data/company_identity/ci_visit_data.dart';

import '../../../../../data/api_data/api_data.dart';
import '../../../../resources/const_string.dart';

/// get
Future<List<CiVisit>> getVisit(BuildContext context,) async {
  List<CiVisit> itemsList = [];
  try {
    final response = await Api(context)
        .get(path: EstablishmentManagerRepository.getCiVisit(
    ));
    if (response.statusCode == 200 || response.statusCode == 201) {
      // print("Org Document response:::::${itemsList}");
      print("1");
      for(var item in response.data){
        itemsList.add(
          CiVisit(
              visitId : item['visitId'],
              typeofVisit: item['typeOfVisit'],
              eligibleClinician: item['eligibleClinician'],
              sucess: true,
              message: response.statusMessage!

          ),
        );
      }
      // print("Org Document response:::::${itemsList}");
    } else {
      print('Org Api Error');
      return itemsList;
    }
    // print("Org response:::::${response}");
    return itemsList;
  } catch (e) {
    print("Error $e");
    return itemsList;
  }
}
/// post
Future<ApiData> addVisitPost(BuildContext context,
    String typeOfVisit,
    String eligibleClinician,
    ) async {
  try {
    var response = await Api(context).post(
        path: EstablishmentManagerRepository.
        postCiVisit(),
        data: {
          "typeOfVisit": typeOfVisit,
          "eligibleClinician": eligibleClinician
           });
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Added request");
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
    print("Error 2");
    return ApiData(
        statusCode: 404, success: false, message: AppString.somethingWentWrong);
  }
}

/// patch