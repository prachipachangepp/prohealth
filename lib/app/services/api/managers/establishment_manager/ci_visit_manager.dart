import 'package:amplify_core/amplify_core.dart';
import 'package:flutter/material.dart';
import 'package:prohealth/app/services/api/api.dart';
import 'package:prohealth/app/services/api/repository/establishment_manager/establishment_repository.dart';
import 'package:prohealth/app/services/token/token_manager.dart';
import 'package:prohealth/data/api_data/establishment_data/company_identity/ci_visit_data.dart';

import '../../../../../data/api_data/api_data.dart';
import '../../../../resources/const_string.dart';

/// get
Future<List<CiVisit>> getVisit(
  BuildContext context,
  int pageNo,
  int noOfRows,
) async {
  List<CiVisit> itemsList = [];

  try {
    final companyId = await TokenManager.getCompanyId();
    final response = await Api(context).get(
        path: EstablishmentManagerRepository.getCiVisit(
      companyId: companyId,
      pageNo: pageNo,
      noofRows: noOfRows,
    ));
    if (response.statusCode == 200 || response.statusCode == 201) {
      // print("Org Document response:::::${itemsList}");
      print("1");

      for (var item in response.data) {
        List<CiVisitList> clinicians = [];
        for (var clinical in item['eligibleClinician']) {
          try {
            clinicians.add(CiVisitList(
              empTypeId: clinical['employeeTypeId'],
              eligibleClinician: clinical['eligibleClinician'],
              color: clinical['color'],
            ));
          } catch (e) {}
        }
        print("::Item${item}");
        itemsList.add(
          CiVisit(
            visitId: item['visitId'],
            typeofVisit: item['typeOfVisit'],
            eligibleClinician: clinicians,
            sucess: true,
            message: response.statusMessage!,
            // color:  item['color']
          ),
        );
      }
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

/// GET visit List
Future<List<VisitListData>> getVisitList(BuildContext context) async {
  List<VisitListData> itemsList = [];
  try {
    final response = await Api(context)
        .get(path: EstablishmentManagerRepository.getCiVisitList());
    if (response.statusCode == 200 || response.statusCode == 201) {
      // print("Org Document response:::::${itemsList}");
      for (var item in response.data) {
        itemsList.add(VisitListData(
            sucess: true,
            message: response.statusMessage!,
            companyId: item['companyId'] == null ? 1 : item['companyId'],
            visitId: item['visitId'],
            visitType: item['typeOfVisit']));
      }
      print("1");
    } else {
      print('Org Api Error');
      return itemsList;
    }
    return itemsList;
  } catch (e) {
    print("Error $e");
    return itemsList;
  }
}

/// visits get by serviceID
Future<List<VisitListDataByServiceId>> getVisitListByServiceId({required BuildContext context,required String serviceId}) async {
  List<VisitListDataByServiceId> itemsList = [];
  try {
    final response = await Api(context)
        .get(path: EstablishmentManagerRepository.getCiVisitListByServiceId(serviceId: serviceId));
    if (response.statusCode == 200 || response.statusCode == 201) {
      // print("Org Document response:::::${itemsList}");
      for (var item in response.data) {
        itemsList.add(VisitListDataByServiceId(
            sucess: true,
            message: response.statusMessage!,
            visitId: item['visitId'],
            visitType: item['typeOfVisit'], serviceId:item['serviceId']));
      }
      print("1");
    } else {
      print('Org Api Error');
      return itemsList;
    }
    return itemsList;
  } catch (e) {
    print("Error $e");
    return itemsList;
  }
}

/// Get prefill visit
Future<VisitListDataPrefill> getVisitListPrefill(
    BuildContext context, int visitId) async {
  var itemsList;
  try {
    final response = await Api(context).get(
        path:
            EstablishmentManagerRepository.getCiVisitPrefill(visitId: visitId));
    if (response.statusCode == 200 || response.statusCode == 201) {
      // print("Org Document response:::::${itemsList}");
      itemsList = VisitListDataPrefill(
        sucess: true,
        message: response.statusMessage!,
        visitId: response.data['visitId'] ?? 0,
        visitType: response.data['typeOfVisit']??"",
        serviceId: response.data['serviceId']??"--",
        eligibleClinicia:
            (response.data['eligibleClinician'] as List<dynamic>?)?.map((item) {
                  return EligibleClinician(
                      employeeTypeId: item['employeeTypeId'],
                      eligibleClinician: item['eligibleClinician'],
                      color: item['color']);
                }).toList() ??
                [],
      );
    } else {
      return itemsList;
    }
    return itemsList;
  } catch (e) {
    print("Error $e");
    return itemsList;
  }
}

/// post
Future<ApiData> addVisitPost({
  required BuildContext context,
  required String typeOfVisit,
  required List<int> eligibleClinician,
  required String serviceId
}
) async {
  try {
    final companyId = await TokenManager.getCompanyId();
    var response = await Api(context)
        .post(path: EstablishmentManagerRepository.postCiVisit(), data: {
      "typeOfVisit": typeOfVisit,
      "companyId": companyId,
      "employeeTypeId": eligibleClinician,
      "serviceId": serviceId
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
Future<ApiData> updateVisitPatch({required BuildContext context, required int typeVisist,
  required String visitType, required List<int> eligibleClinical,required String serviceId}) async {
  try {
    final companyId = await TokenManager.getCompanyId();
    var dymmyData = {
      'typeOfVisit': visitType,
      'companyId': companyId,
      'employeeTypeId': eligibleClinical,
      'serviceId':serviceId
    };
    print("Updated pre data ${dymmyData}");
    var response = await Api(context).patch(
      path: EstablishmentManagerRepository.updateCiVisit(typeVisit: typeVisist),
      data: {
        'typeOfVisit': visitType,
        'companyId': companyId,
        'employeeTypeId': eligibleClinical,
        'serviceId':serviceId
      },
    );
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
// Future<ApiData> deleteVisitDelete(BuildContext context,int visitId) async {
//   try {
//     var response = await Api(context).delete(path:
//     EstablishmentManagerRepository.deleteCiVisit(visitId: visitId));
//     if (response.statusCode == 200 || response.statusCode == 201) {
//       print("visit data deleted");
//       // orgDocumentGet(context);
//       return ApiData(
//           statusCode: response.statusCode!,
//           success: true,
//           message: response.statusMessage!);
//     } else {
//       print("Error 1");
//       return ApiData(
//           statusCode: response.statusCode!,
//           success: false,
//           message: response.data['message']);
//     }
//   } catch (e) {
//     print("Error $e");
//     print("Error 2");
//     return ApiData(
//         statusCode: 404, success: false, message: AppString.somethingWentWrong);
//   }
// }

Future<ApiData> deleteVisit(BuildContext context, int visitId) async {
  try {
    var response = await Api(context).delete(
        path: EstablishmentManagerRepository.deleteCiVisit(visitId: visitId));
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Deleted visit :::${visitId}");
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
