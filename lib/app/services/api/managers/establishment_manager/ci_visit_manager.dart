

import 'package:flutter/material.dart';
import 'package:prohealth/app/services/api/api.dart';
import 'package:prohealth/app/services/api/repository/establishment_manager/establishment_repository.dart';
import 'package:prohealth/data/api_data/establishment_data/company_identity/ci_visit_data.dart';

import '../../../../../data/api_data/api_data.dart';
import '../../../../resources/const_string.dart';

/// get
Future<List<CiVisit>> getVisit(BuildContext context,int pageNo,int noOfRows) async {
  List<CiVisit> itemsList = [];
  try {
    final response = await Api(context)
        .get(path: EstablishmentManagerRepository.
    getCiVisit(
        pageNo: pageNo, noofRows: noOfRows
    ));
    if (response.statusCode == 200 || response.statusCode == 201) {
      // print("Org Document response:::::${itemsList}");
      print("1");

      for(var item in response.data){
        itemsList.add(
          CiVisit(
             // visitId : item['visitId'],
              typeofVisit: item['typeOfVisit'],
              eligibleClinician: item['eligibleClinician'],
              sucess: true,
              message: response.statusMessage!

          ),
        );
      }
      // for(var item in response.data){
      //   eligibalList.add(CiVisit(
      //     // visitId : item['visitId'],
      //       eligibleClinician: item['eligibleClinician'],
      //       sucess: true,
      //       message: response.statusMessage!
      //
      //   ),);
      //   print(":::::::<><>${eligibalList}");
      //   print(":::::::<><>${response.data}");
      // }
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
    List eligibleClinician,
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
    print("Error ${e}");
    return ApiData(
        statusCode: 404, success: false, message: AppString.somethingWentWrong);
  }
}

/// patch
Future<ApiData> updateVisitPatch(BuildContext context, String typeVisist,String visitType, List eligibleClinical) async {
  try {
    var response = await Api(context).patch(path: EstablishmentManagerRepository.updateCiVisit(typeVisit: typeVisist), data: {
      'typeOfVisit':visitType,
      'eligibleClinician':eligibleClinical
    },);
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Updated visit data");
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

/// Delete visit
Future<ApiData> deleteVisitPatch(BuildContext context,int visitId) async {
  try {
    var response = await Api(context).delete(path:
    EstablishmentManagerRepository.deleteCiVisit(visitId: visitId));
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("visit data deleted");
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