// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
//
// import '../../../../../data/api_data/api_data.dart';
// import '../../../../../data/api_data/establishment_data/ci_manage_button/newpopup_data.dart';
// import '../../../../resources/const_string.dart';
// import '../../../base64/encode_decode_base64.dart';
// import '../../../token/token_manager.dart';
// import '../../api.dart';
// import '../../repository/establishment_manager/establishment_repository.dart';
// /// get API list in manage Corporate compliance
// Future<List<MCorporateComplianceModal>> getListMCorporateCompliancefetch(
//     BuildContext context,
//     // String officeId,
//     int DocumentTypeId,
//     int DocumentSubTypeId,
//     int pageNbr,
//     int NbrofRows
//     ) async {
//   List<MCorporateComplianceModal> itemsList = [];
//   try {
//     final companyId = await TokenManager.getCompanyId();
//     final response = await Api(context).get(
//         path: EstablishmentManagerRepository.getListMCorporateCompliance(
//             DocumentTypeId: DocumentTypeId,
//             DocumentSubTypeId: DocumentSubTypeId,
//             pageNbr: pageNbr, NbrofRows: NbrofRows));
//     print(" Prachi Corporate Compliance response:::::${response.data}");
//     if (response.statusCode == 200 || response.statusCode == 201) {
//
//       print("1");
//       for (var item in response.data) {
//         itemsList.add(
//             MCorporateComplianceModal(
//                 orgOfficeDocumentId: item['orgOfficeDocumentId'] ?? 0,
//                 orgDocumentSetupid: item['orgDocumentSetupid']  ?? 0,
//                 idOfDocument: item['idOfDocument'] ?? '',
//                 doc_created_at: item['doc_created_at'] ?? '',
//                 expiry_date: item['expiry_date'] ?? '',
//                 url: item['url'] ?? '',
//                 companyId: item['company_id'] ?? 0,
//                 officeId: item['office_id'] ?? ''
//             // orgDocumentSetupid: item['orgDocumentSetupid'] ?? 0,
//             // documenttypeid: item['document_type_id'] ?? 0,
//             // documentsubtypeid: item['document_subtype_id'] ?? 0,
//             // docname: item['doc_name'] ?? '',
//             // expirytype: item['expiry_type'] ?? '',
//             // threshold: item['threshold'] ?? 0,
//             // expirydate: item['expiry_date'] ?? '',
//             // expiryreminder: item['expiry_reminder'] ?? '',
//             // companyid: item['company_id'] ?? 0,
//             // idOfDocument: item['idOfDocument'] ?? ''
//             )
//         );
//       }
//       // print('${response.data['DocumentList']}');
//       print(" Manage Corporate Compliance Get :::::${itemsList}");
//     } else {
//       print(' Manage Compliance Data Added');
//       return itemsList;
//     }
//     // print("Org response:::::${response}");
//     return itemsList;
//   } catch (e) {
//     print("Error for add $e");
//     return itemsList;
//   }
// }
//
// /// get Type of document Manage(CC,VC,PP) Add Popup
// Future<List<TypeofDocpopup>> getTypeofDoc(
//     BuildContext context, int DocumentTypeId, int DocumentSubTypeId) async {
//   List<TypeofDocpopup> itemsList = [];
//   try {
//     final companyId = await TokenManager.getCompanyId();
//     final response = await Api(context).get(
//         path: EstablishmentManagerRepository.getdocPayratesdropdown(
//             DocumentTypeId: DocumentTypeId,
//             DocumentSubTypeId: DocumentSubTypeId));
//     if (response.statusCode == 200 || response.statusCode == 201) {
//       // print("Org Document response:::::${itemsList}");
//       print("1");
//       for (var item in response.data) {
//         itemsList.add(TypeofDocpopup(
//             orgDocumentSetupid: item['orgDocumentSetupid'] ?? 0,
//             documenttypeid: item['document_type_id'] ?? 0,
//             documentsubtypeid: item['document_subtype_id'] ?? 0,
//             docname: item['doc_name'] ?? '',
//             expirytype: item['expiry_type'] ?? '',
//             threshold: item['threshold'] ?? 0,
//             expirydate: item['expiry_date'] ?? '',
//             expiryreminder: item['expiry_reminder'] ?? '',
//             companyid: item['company_id'] ?? 0,
//             idOfDocument: item['idOfDocument'] ?? ''));
//       }
//       // print('${response.data['DocumentList']}');
//       print("Compliance response:::::${itemsList}");
//     } else {
//       print('Compliance Data Added');
//       return itemsList;
//     }
//     // print("Org response:::::${response}");
//     return itemsList;
//   } catch (e) {
//     print("Error for add $e");
//     return itemsList;
//   }
// }
//
// ///post API Save Button (CC,VC,PP) Add DocType
// Future<ApiData> addOrgDocPPPost({
//   required BuildContext context,
//   required int orgDocumentSetupid,
//   required String idOfDocument,
//   required String expiryDate,
//   required String docCreatedat,
//   required int companyid,
//   required String url,
//   required String officeid,
// }) async {
//   try {
//     final companyId = await TokenManager.getCompanyId();
//     // String formattedExpiryDate = DateFormat('yyyy-MM-dd').format(DateTime.parse(expiryDate));
//
//     var data = {
//       "orgDocumentSetupid": orgDocumentSetupid,
//       "idOfDocument": idOfDocument,
//       // "expiry_date": formattedExpiryDate,
//       //  "expiry_date": expiryDate,
//       "expiry_date": "${expiryDate}T00:00:00Z",
//       "doc_created_at": docCreatedat,
//       "company_id": companyid,
//       "url": url,
//       "office_id": officeid,
//     };
//     print('$data');
//
//     var response = await Api(context)
//         .post(path: EstablishmentManagerRepository.addDocOrg(), data: data);
//     print('Upload Document CCVCPP Added::::$response ');
//
//     if (response.statusCode == 200 || response.statusCode == 201) {
//       var responseData = response.data;
//       var docOfficeID =responseData["orgOfficeDocumentId"];
//       print("Uploaded Document CCVCPP  addded ");
//       return ApiData(
//           orgOfficeDocumentId: docOfficeID,
//           statusCode: response.statusCode!,
//           success: true,
//           message: response.statusMessage!);
//     } else {
//       print("Error 1 Upload Document CCVCPP Failed to add");
//       return ApiData(
//           statusCode: response.statusCode!,
//           success: false,
//           message: response.data['message']);
//     }
//   } catch (e) {
//     print("Error $e");
//     print("Error 2 Upload Document CCVCPP Failed to add");
//     return ApiData(
//         statusCode: 404, success: false, message: AppString.somethingWentWrong);
//   }
// }
//
//
// ///upload base 64 Add DocType(CC,VC, PP) Also use this in Edit
// Future<ApiData> uploadDocumentsoffice({
//   required BuildContext context,
//   required dynamic documentFile,
//   required int orgOfficeDocumentId,
// }) async {
//   try {
//     String documents =
//         await AppFilePickerBase64.getEncodeBase64(bytes: documentFile);
//     print("File :::${documents}");
//     var response = await Api(context).post(
//       path: EstablishmentManagerRepository.uploadedocOffice(
//           orgOfficeDocumentId: orgOfficeDocumentId),
//       data: {'base64': documents},
//     );
//     print("Response ${response.toString()}");
//     if (response.statusCode == 200 || response.statusCode == 201) {
//       print("PP Documents uploded");
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
//     return ApiData(
//         statusCode: 404, success: false, message: AppString.somethingWentWrong);
//   }
// }
//
//
// /// Made by shubham_dev
// /// Patch org document(CC VV PP)
// Future<ApiData> updateOrgDoc({
//   required BuildContext context,
//   required int orgDocId,
//   required int orgDocumentSetupid,
//   required String idOfDocument,
//   required String expiryDate,
//   required String docCreatedat,
//   required String url,
//   required String officeid,
// }) async {
//   try {
//     final companyId = await TokenManager.getCompanyId();
//     // String formattedExpiryDate = DateFormat('yyyy-MM-dd').format(DateTime.parse(expiryDate));
//
//     var data = {
//       "orgDocumentSetupid": orgDocumentSetupid,
//       "idOfDocument": idOfDocument,
//       // "expiry_date": formattedExpiryDate,
//       "expiry_date": "${expiryDate}T00:00:00Z",
//       "doc_created_at": docCreatedat,
//       "company_id": companyId,
//       "url": url,
//       "office_id": officeid,
//     };
//     print('patch Manage CCVCPP Doc $data');
//
//     var response = await Api(context)
//         .patch(path: EstablishmentManagerRepository.patchDocOrg(orgDocID: orgDocId), data: data);
//     print('Patch Manage CCVCPP ::::$response ');
//
//     if (response.statusCode == 200 || response.statusCode == 201) {
//       // var responseData = response.data;
//       // var docOfficeID =responseData["orgOfficeDocumentId"];
//       // print("Uploaded Document CCVCPP  addded ");
//       return ApiData(
//           statusCode: response.statusCode!,
//           success: true,
//           message: response.statusMessage!);
//     } else {
//       print("Error 1 Failed to patch");
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
//
//
//
// /// delete org document(CC VV PP)
// Future<ApiData> deleteOrgDoc({
//   required BuildContext context,
//   required int orgDocId,
// }) async {
//   try {
//     var response = await Api(context)
//         .delete(path: EstablishmentManagerRepository.deleteDocOrg(orgDocID: orgDocId));
//     if (response.statusCode == 200 || response.statusCode == 201) {
//       print('Document deleted');
//       // var responseData = response.data;
//       // var docOfficeID =responseData["orgOfficeDocumentId"];
//       // print("Uploaded Document CCVCPP  addded ");
//       return ApiData(
//           statusCode: response.statusCode!,
//           success: true,
//           message: response.statusMessage!);
//     } else {
//       print("Error 1 Failed to delete");
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
///
import 'package:flutter/material.dart';

import '../../../../../data/api_data/api_data.dart';
import '../../../../../data/api_data/establishment_data/ci_manage_button/newpopup_data.dart';
import '../../../../resources/const_string.dart';
import '../../../base64/encode_decode_base64.dart';
import '../../../token/token_manager.dart';
import '../../api.dart';
import '../../repository/establishment_manager/establishment_repository.dart';

/// get Type of document Manage(CC,VC,PP) Add Popup document type dropdown api prajwal
Future<List<TypeofDocpopup>> getTypeofDoc(
    BuildContext context, int DocumentTypeId, int DocumentSubTypeId) async {
  List<TypeofDocpopup> itemsList = [];
  try {
    final companyId = await TokenManager.getCompanyId();
    final response = await Api(context).get(
        path: EstablishmentManagerRepository.getdocPayratesdropdown(
      DocumentTypeId: DocumentTypeId,
      DocumentSubTypeId: DocumentSubTypeId,
    ));
    if (response.statusCode == 200 || response.statusCode == 201) {

      // print("Org Document response:::::${itemsList}");
      print("1");
      for (var item in response.data) {
        itemsList.add(TypeofDocpopup(
            orgDocumentSetupid: item['orgDocumentSetupid'] ?? 0,
            documenttypeid: item['document_type_id'] ?? 0,
            documentsubtypeid: item['document_subtype_id'] ?? 0,
            docname: item['doc_name'] ?? '',
            expirytype: item['expiry_type'] ?? '',
            threshold: item['threshold'] ?? 0,
            expirydate: item['expiry_date'] ?? '',
            expiryreminder: item['expiry_reminder'] ?? '',
            companyid: item['company_id'] ?? 0,
            idOfDocument: item['idOfDocument'] ?? ''));
      }
      // print('${response.data['DocumentList']}');
      print("Compliance response:::::${itemsList}");
    } else {
      print('Compliance Data Added');
      return itemsList;
    }
    // print("Org response:::::${response}");
    return itemsList;
  } catch (e) {
    print("Error for add $e");
    return itemsList;
  }
}

/// get API list in manage Corporate compliance prajwal
// Future<List<MCorporateComplianceModal>> getListMCorporateCompliancefetch(
//     BuildContext context,
//     // String officeId,
//     int DocumentTypeId,
//     int DocumentSubTypeId,
//     int pageNbr,
//     int NbrofRows
//     ) async {
//   List<MCorporateComplianceModal> itemsList = [];
//   try {
//     final companyId = await TokenManager.getCompanyId();
//     final response = await Api(context).get(
//         path: EstablishmentManagerRepository.getListMCorporateCompliance(
//             DocumentTypeId: DocumentTypeId,
//             DocumentSubTypeId: DocumentSubTypeId, pageNbr: pageNbr, NbrofRows: NbrofRows));
//     print(" Prachi Corporate Compliance response:::::${response.data}");
//     if (response.statusCode == 200 || response.statusCode == 201) {
//
//       print("1");
//       for (var item in response.data) {
//         itemsList.add(
//             MCorporateComplianceModal(
//                 orgOfficeDocumentId: item['orgOfficeDocumentId'] ?? 0,
//                 orgDocumentSetupid: item['orgDocumentSetupid']  ?? 0,
//                 idOfDocument: item['idOfDocument'] ?? '',
//                 doc_created_at: item['doc_created_at'] ?? '',
//                 expiry_date: item['expiry_date'] ?? '',
//                 docurl: item['url'] ?? '',
//                 companyId: companyId,
//                 officeId: item['office_id'] ?? '',
//             )
//         );
//       }
//       // print('${response.data['DocumentList']}');
//       print(" Manage Corporate Compliance Get :::::${itemsList}");
//     } else {
//       print(' Manage Compliance Data Added');
//       return itemsList;
//     }
//     // print("Org response:::::${response}");
//     return itemsList;
//   } catch (e) {
//     print("Error for add $e");
//     return itemsList;
//   }
// }
Future<List<MCorporateComplianceModal>> getListMCorporateCompliancefetch(
    BuildContext context,
    int DocumentTypeId,
    int DocumentSubTypeId,
    int pageNbr,
    int NbrofRows) async {
  List<MCorporateComplianceModal> itemsList = [];
  try {
    final companyId = await TokenManager.getCompanyId();
    final response = await Api(context).get(
        path: EstablishmentManagerRepository.getListMCorporateCompliance(
            DocumentTypeId: DocumentTypeId,
            DocumentSubTypeId: DocumentSubTypeId,
            pageNbr: pageNbr,
            NbrofRows: NbrofRows));

    if (response.statusCode == 200 || response.statusCode == 201) {
      for (var item in response.data) {
        itemsList.add(
          MCorporateComplianceModal(
            orgOfficeDocumentId: item['orgOfficeDocumentId'] ?? 0,
            orgDocumentSetupid: item['orgDocumentSetupid'] ?? 0,
            idOfDocument: item['idOfDocument'] ?? '',
            doc_created_at: item['doc_created_at'] ?? '',
            expiry_date: item['expiry_date'] ?? '',
            docurl: item['url'] ?? '',
            companyId: companyId,
            officeId: item['office_id'] ?? '',
            docName: item['doc_name'] ?? '',
            docHistory: item['docHistory'] ?? [], // Parse docHistory here
          ),
        );
      }
      // print(" Manage Corporate Compliance Get :::::${itemsList}");
    } else {
      print(' Manage Compliance Data Not Added');
      return itemsList;
    }
    return itemsList;
  } catch (e) {
    print("Error for add $e");
    return itemsList;
  }
}

///post API Save Button (CC,VC,PP) Add DocType saloni
Future<ApiData> addOrgDocPPPost({
  required BuildContext context,
  required int orgDocumentSetupid,
  required String idOfDocument,
  required String? expiryDate,
  required String docCreated,
  required String url,
  required String officeId,
}) async {
  try {
    final companyId = await TokenManager.getCompanyId();
    var data = {
      "orgDocumentSetupid": orgDocumentSetupid,
     "idOfDocument": idOfDocument,
      "expiry_date": expiryDate,
      "doc_created_at": docCreated,
      "company_id": companyId,
      "url": url,
      "office_id":
          officeId, //expiryDate?.isNotEmpty == true ? "${expiryDate}" : '',
    };

    // if (expiryDate != null && expiryDate.isNotEmpty) {
    //   data['expiry_Date'] = "${expiryDate}";
    // } else {
    //   data.remove('expiryDate');
    // }

    print('New manage Corporate Doc $data');
    var response = await Api(context)
        .post(path: EstablishmentManagerRepository.addDocOrg(), data: data);
    print('New manage Doc Post::::$response ');
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("New manage Corporate Doc addded ");
      var responseData = response.data;

      var docOfficeID = responseData["orgOfficeDocumentId"];
      print("Post Manage CCVCPP  addded ");
      return ApiData(
          orgOfficeDocumentId: docOfficeID,
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

///upload base 64 Add DocType(CC,VC, PP) Also use this in Edit prajwal
Future<ApiData> uploadDocumentsoffice({
  required BuildContext context,
  required dynamic documentFile,
  required int orgOfficeDocumentId,
}) async {
  try {
    String documents =
        await AppFilePickerBase64.getEncodeBase64(bytes: documentFile);
    print("File :::${documents}");
    var response = await Api(context).post(
      path: EstablishmentManagerRepository.uploadedocOffice(
          orgOfficeDocumentId: orgOfficeDocumentId),
      data: {'base64': documents},
    );
    print("Response ${response.toString()}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("PP Documents uploded");
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

/// Made by shubham_dev patch
Future<ApiData> updateOrgDoc({
  required BuildContext context,
  required int orgDocId,
  required int orgDocumentSetupid,
  required String idOfDocument,
  required String? expiryDate,
  required String docCreatedat,
  required String url,
  required String officeid,
}) async {
  try {
    final companyId = await TokenManager.getCompanyId();
    // String formattedExpiryDate = DateFormat('yyyy-MM-dd').format(DateTime.parse(expiryDate));

    var data = {
      "orgDocumentSetupid": orgDocumentSetupid,
      // "idOfDocument": idOfDocument,
      // "expiry_date": formattedExpiryDate,
      "expiry_date": expiryDate,
      "doc_created_at": docCreatedat,
      "company_id": companyId,
      "url": url,
      "office_id": officeid,
    };
    print('patch Manage CCVCPP Doc $data');

    var response = await Api(context).patch(
        path: EstablishmentManagerRepository.patchDocOrg(orgDocID: orgDocId),
        data: data);
    print('Patch Manage CCVCPP ::::$response ');

    if (response.statusCode == 200 || response.statusCode == 201) {
      var responseData = response.data;
      var docOfficeID = responseData["orgOfficeDocumentId"];
      print("Patch CCVCPP  Updated ");
      return ApiData(
          orgOfficeDocumentId: docOfficeID,
          statusCode: response.statusCode!,
          success: true,
          message: response.statusMessage!);
    } else {
      print("Error 1 Failed to patch");
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

/// GET prefill cc vc pp document prajwal
Future<MCorporateCompliancePreFillModal> getPrefillNewOrgOfficeDocument(
    BuildContext context, int orgDocId) async {
  var itemsList;
  try {
    final companyId = await TokenManager.getCompanyId();
    final response = await Api(context).get(
        path: EstablishmentManagerRepository.prefillDocOfficeOrg(
            orgDocID: orgDocId));
    if (response.statusCode == 200 || response.statusCode == 201) {
      // print("Document type Response:::::${itemsList}");
      itemsList = MCorporateCompliancePreFillModal(
        documentSetupId: response.data['orgDocumentSetupid'],
        idOfDocument: response.data['idOfDocument'] ?? "",
        expiry_date: response.data['expiry_date'] ?? "",
        doc_created_at: response.data['doc_created_at'] ?? "",
        companyId: companyId,
        url: response.data['url'] ?? "",
        officeId: response.data['office_id'],
        threshould: response.data['threshold'] ?? 0,
        expType: response.data['expiry_type'] ?? "",
        docName: response.data['doc_name'] ?? '',
        docSubTypeId: response.data['document_subtype_id'],
        docTypeId: response.data['document_type_id'],
        orgOfficeDocumentId: response.data['orgOfficeDocumentId'],
      );
    } else {
      print('Api Error');
      //return itemsList;
    }
    print("GetDcoType Prefill Response:::::${itemsList}");
    return itemsList;
  } catch (e) {
    print("Error $e");
    return itemsList;
  }
}

///shubham delete org document(CC VV PP)
Future<ApiData> deleteOrgDoc({
  required BuildContext context,
  required int orgDocId,
}) async {
  try {
    var response = await Api(context).delete(
        path: EstablishmentManagerRepository.deleteDocOrg(orgDocID: orgDocId));
    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Document deleted');
      // var responseData = response.data;
      // var docOfficeID =responseData["orgOfficeDocumentId"];
      // print("Uploaded Document CCVCPP  addded ");
      return ApiData(
          statusCode: response.statusCode!,
          success: true,
          message: response.statusMessage!);
    } else {
      print("Error 1 Failed to delete");
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

class dd extends StatelessWidget {
  const dd({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
