import 'package:flutter/material.dart';
import 'package:prohealth/app/services/token/token_manager.dart';

import '../../../../../../data/api_data/api_data.dart';
import '../../../../../../data/api_data/establishment_data/ci_manage_button/manage_corporate_conpliance_data.dart';
import '../../../../../../data/api_data/establishment_data/company_identity/ci_org_document.dart';
import '../../../../../resources/const_string.dart';
import '../../../api.dart';
import '../../../repository/establishment_manager/establishment_repository.dart';

///post
Future<ApiData> addManageCCVCPPPost({
  required BuildContext context,
  required String name,
  required int docTypeID,
  required int docSubTypeID,
  required String expiryType,
  required String expiryDate,
  required String expiryReminder,
  required String officeId,
  required String idOfDoc,
}) async {
  try {
    final companyId = await TokenManager.getCompanyId();
    var data = {
      "doc_name": name,
      "document_type_id": docTypeID,
      "document_subtype_id": docSubTypeID,
      "expiry_type": expiryType,
      "expiry_date": expiryDate,
      "expiry_reminder": expiryReminder,
      "company_id": companyId,
      "office_id": officeId,
      "idOfDocument": idOfDoc,
    };
    print('Post Manage CCVCPP Doc$data');
    var response = await Api(context).post(
        path: EstablishmentManagerRepository.addManageCCVCPPPost(),
        data: data);
    print('Post Manage CCVCPP ::::$response ');
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Post Manage CCVCPP  addded ");
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

///manage cc,vendor,policies,contract get new
Future<List<ManageCCDoc>> getManageCorporate(BuildContext context, String officeId,
    int docTypeID, int docSubTypeID, int pageNo, int rowsNO) async {
  List<ManageCCDoc> itemsList = [];
  try {
    final companyId =await TokenManager.getCompanyId();
    final response = await Api(context).get(
        path: EstablishmentManagerRepository.corporateGetListbyCompany(
            companyId: companyId,
            officeId: officeId,
            docTypeID: docTypeID,
            docSubTypeID: docSubTypeID,
            pageNo: pageNo,
            rowsNo: rowsNO, ));
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Manage CC response:::::${itemsList}");
      print("111");
      for (var item in response.data["DocumentList"]) {
        itemsList.add(
          ManageCCDoc(
            docId: item["document_id"],
            documentTypeId: item["document_type_id"],
            documentSubTypeId: item["document_subtype_id"],
            docname: item["doc_name"] ?? "",
            doccreatedAt: item["doc_created_at"] ?? "--",
            url: item["url"] ?? "--",
            expiryType: item["expiry_type"],
            expiryDate: item["expiry_date"],
            expiryReminder: item["expiry_reminder"] ?? "--",
            companyId: companyId,
            officeId: item["office_id"],
            idOfDoc: item["idOfDocument"] ?? "--",
            sucess: true,
            message: response.statusMessage!,
          ),
        );
      }
      // print("Org Document response:::::${itemsList}");
    } else {
      print('Manage CC Api Error');
      return itemsList;
    }
    // print("Org response:::::${response}");
    return itemsList;
  } catch (e) {
    print("Error $e");
    return itemsList;
  }
}

/// Get prefill visit
Future<CorporatePrefillCCVVPP> getManageCCPrefill(BuildContext context, int docId) async {
  var itemsList;
  try {
    final companyId = await TokenManager.getCompanyId();
    final response = await Api(context)
        .get(path: EstablishmentManagerRepository.updatePrefillPatchCCVCPP(docId: docId));
    if (response.statusCode == 200 || response.statusCode == 201) {
      // print("Org Document response:::::${itemsList}");
      itemsList = CorporatePrefillCCVVPP(
          sucess: true,
          message: response.statusMessage!,
          docName: response.data['doc_name'] ?? "--",
          documentTypeId: response.data['document_type_id'],
          documentSubTypeId: response.data['document_subtype_id'],
          url: response.data['url'] ?? "--",
          expiryType: response.data['expiry_type'] ?? "--",
          expiryDate: response.data['expiry_date'],
          expiryReminder: response.data['expiry_reminder'] ?? "--",
          companyId: companyId,
          officeId: response.data['office_id'],
          docCreated: response.data['doc_created_at'] ?? "--",
          documentId: response.data['document_id'],
          idOfDoc: response.data['idOfDocument']) ?? "--";
    } else {
      return itemsList;
    }
    return itemsList;
  } catch (e) {
    print("Error $e");
    return itemsList;
  }
}

///patch
// Future<ApiData> updateManageCorporate(
//     BuildContext context,
//     int docId,
//     int docTypeId,
//     int docSubTypeId,
//     String docName,
//     String docDate,
//     String expiryType,
//     String officeId,
//     String expiryReminder) async{
//   try {
//     final companyId = await TokenManager.getCompanyId();
//     var response = await Api(context).patch(
//         path: EstablishmentManagerRepository.
//         updatePrefillPatchCCVCPP(docId: docId),
//         data: {
//           "doc_name": docName,
//           "document_type_id":docTypeId,
//           "document_subtype_id":docSubTypeId,
//           "expiry_type": expiryType,
//           "expiry_date": docDate,
//           "expiry_reminder": expiryReminder,
//           "company_id" :companyId,
//           "office_id" : officeId,
//         });
//     if (response.statusCode == 200 || response.statusCode == 201) {
//       print("Updated request");
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
Future<ApiData> updateManageCCVVPP({
  required BuildContext context,
  required int docId,
  required String name,
  required int docTypeID,
  required int docSubTypeID,
  required String docCreated,
  required String url,
  required String expiryType,
  required String expiryDate,
  required String expiryReminder,
  required String officeId,
  required String idOfDoc,
}) async {
  try {
    final companyId = await TokenManager.getCompanyId();
    var response = await Api(context).patch(
        path: EstablishmentManagerRepository.updateCorporateDocumentPost(
            docID: docId),
        data: {
          "doc_name": name,
          "document_type_id": docTypeID,
          "document_subtype_id": docSubTypeID,
          "doc_created_at": docCreated,
          "url": url,
          "expiry_type": expiryType,
          "expiry_date": expiryDate,
          "expiry_reminder": expiryReminder,
          "company_id": companyId,
          "office_id": officeId,
          "idOfDocument": idOfDoc
        });
    print('::::$response');
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Document edited ");
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

///delete
Future<ApiData> deleteManageCorporate(
    BuildContext context, int docId) async {
  try {
    var response = await Api(context).delete(
        path: EstablishmentManagerRepository.updatePrefillPatchCCVCPP(docId: docId));
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Deleted Document :::${docId}");
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