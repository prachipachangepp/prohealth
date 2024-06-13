
import 'package:flutter/cupertino.dart';
import 'package:prohealth/app/services/api/api.dart';
import 'package:prohealth/data/api_data/establishment_data/company_identity/ci_org_document.dart';

import '../../repository/establishment_manager/establishment_repository.dart';

// /// get
// Future<List<OrgDocModal>> getOrgDocfetch(BuildContext context,) async {
//   List<OrgDocModal> itemsList = [];
//   try {
//     final response = await Api(context)
//         .get(path: EstablishmentManagerRepository.getCiOrgDLicense(
//         companyId: null,
//         docTypeID: null,
//         docSubTypeID: null,
//         pageNo: null,
//         rowsNo: null
//     ));
//     if (response.statusCode == 200 || response.statusCode == 201) {
//       // print("Org Document response:::::${itemsList}");
//       print("1");
//       for(var item in response.data){
//         itemsList.add(
//           OrgDocModal(
//               docId: ,
//               name: ,
//               expiry: ,
//               reminderThreshold: ,
//               sucess: true,
//               message: response.statusMessage!
//
//           ),
//         );
//       }
//       // print("Org Document response:::::${itemsList}");
//     } else {
//       print('Org Api Error');
//       return itemsList;
//     }
//     // print("Org response:::::${response}");
//     return itemsList;
//   } catch (e) {
//     print("Error $e");
//     return itemsList;
//   }
// }