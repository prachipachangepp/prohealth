
import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/services/api/api.dart';
import 'package:prohealth/app/services/api/repository/establishment_manager/establishment_repository.dart';
import 'package:prohealth/data/api_data/api_data.dart';
import 'package:prohealth/data/api_data/establishment_data/company_identity/ci_org_document.dart';

Future<List<CiOrgDocumentCC>> orgDocumentGet(BuildContext context) async {
  List<CiOrgDocumentCC> itemsList = [];

  try {
    final response = await Api(context)
        .get(path: EstablishmentManagerRepository.orgDocumentGet());
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Org Document response:::::${itemsList}");
      for(var item in response.data){
        itemsList.add(
          CiOrgDocumentCC(
            docId: item['document_id'],
            createdAt: item['doc_created_at'],
              name: item["doc_name"],
              expiry: item["expiry_date"],
              reminderThreshold: item["expiry_reminder"],
              sucess: true, message: response.statusMessage!
          ),

        );
      }
      print("Org Document response:::::${itemsList}");
    } else {
      print('Org Api Error');
      return itemsList;
    }
    print("Org response:::::${response}");
    return itemsList;
  } catch (e) {
    print("Error $e");
    return itemsList;
  }
}


Future<ApiData> addOrgDocumentPost(
    BuildContext context,
    String expiryDate,
    String docName,
    String expiryType,
    String expiryReminder
    ) async {
  try {
    var response = await Api(context).post(
        path: EstablishmentManagerRepository.
        addOrgDocumentPost(), data: {
          'doc_name':docName,
          'expiry_type':expiryType,
          'expiry_date':expiryDate,
          'expiry_reminder':expiryReminder
    });
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Added request");
      orgDocumentGet(context);
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

Future<ApiData> updateOrgDocument(BuildContext context, int docId,String docName,String docDate, String expiryType,String expiryReminder) async{
  try {
    var response = await Api(context).patch(
        path: EstablishmentManagerRepository.
        updateOrgCocument(docId: docId),
        data: {
      'document_id':docId,
      "doc_name": docName,
      "expiry_type": expiryType,
      "expiry_date": docDate,
      "expiry_reminder": expiryReminder
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



Future<ApiData> deleteDocument(
    BuildContext context, int docId) async {
  try {
    var response = await Api(context).delete(
        path: EstablishmentManagerRepository.updateOrgCocument(docId: docId));
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