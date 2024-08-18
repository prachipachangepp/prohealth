import 'package:flutter/material.dart';
import 'package:prohealth/app/services/token/token_manager.dart';

import '../../../../../../data/api_data/establishment_data/ci_manage_button/manage_corporate_conpliance_data.dart';
import '../../../../../../data/api_data/establishment_data/company_identity/ci_org_document.dart';
import '../../../api.dart';
import '../../../repository/establishment_manager/establishment_repository.dart';

///manage cc,vendor,policies,contract get
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
            docname: item["doc_name"],
            doccreatedAt: item["doc_created_at"],
            url: item["url"],
            expiryType: item["expiry_type"],
            expiryDate: item["expiry_date"],
            expiryReminder: item["expiry_reminder"],
            companyId: item["company_id"],
            officeId: item["office_id"],
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
