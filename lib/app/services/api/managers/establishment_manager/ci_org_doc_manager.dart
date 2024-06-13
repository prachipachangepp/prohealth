import 'package:flutter/cupertino.dart';
import 'package:prohealth/app/services/api/api.dart';
import 'package:prohealth/data/api_data/establishment_data/company_identity/ci_org_document.dart';

import '../../repository/establishment_manager/establishment_repository.dart';

/// get
Future<List<IdentityData>> getOrgDocfetch(BuildContext context, int companyId,
    int docTypeID, int docSubTypeID, int pageNo, int rowsNO) async {
  List<IdentityData> itemsList = [];
  try {
    final response = await Api(context).get(
        path: EstablishmentManagerRepository.getCiOrgDLicense(
            companyId: companyId,
            docTypeID: docSubTypeID,
            docSubTypeID: docSubTypeID,
            pageNo: pageNo,
            rowsNo: rowsNO));
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Org Document Tab bar response:::::${itemsList}");
      print("111");
      for (var item in response.data) {
        itemsList.add(
          IdentityData(
            docId: item["document_type_id"],
            companyId: item["company_id"],
            docSubId: item["document_sub_type_id"],
            pageNo: item["pageNbr"],
            rowsNo: item["NbrofRows"],
            sucess: true,
            message: response.statusMessage!,
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

/// document type GET
Future<List<DocumentTypeData>> documentTypeGet(
  BuildContext context,
) async {
  List<DocumentTypeData> itemsList = [];
  try {
    final response = await Api(context)
        .get(path: EstablishmentManagerRepository.documentTypeGet());
    if (response.statusCode == 200 || response.statusCode == 201) {
      // print("Document type Response:::::${itemsList}");
      for (var item in response.data) {
        itemsList.add(DocumentTypeData(
            docID: item["document_type_id"],
            docType: item["document_type"],
            sucess: true,
            message: response.statusMessage!));
      }
    } else {
      print('Api Error');
      //return itemsList;
    }
    print("Document type Response:::::${itemsList}");
    return itemsList;
  } catch (e) {
    print("Error $e");
    return itemsList;
  }
}

/// Identity document & sub doc type GET
Future<List<IdentityDocumentIdData>> identityDocumentTypeGet(
    BuildContext context, int docID) async {
  List<IdentityDocumentIdData> itemsList = [];
  try {
    final response = await Api(context).get(
        path: EstablishmentManagerRepository.identityDocumentTypeGet(
            docId: docID));
    if (response.statusCode == 200 || response.statusCode == 201) {
      // print("Document type Response:::::${itemsList}");
      for (var item in response.data) {
        itemsList.add(IdentityDocumentIdData(
            docID: item["document_type_id"],
            docType: item["document_type"],
            subDocID: item["document_sub_type_id"],
            subDocType: item["document_sub_type"],
            message: '',
            sucess: true));
      }
    } else {
      print('Api Error');
      //return itemsList;
    }
    print("GetDcoType Response:::::${itemsList}");
    return itemsList;
  } catch (e) {
    print("Error $e");
    return itemsList;
  }
}
