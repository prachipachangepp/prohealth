

import 'package:flutter/cupertino.dart';
import 'package:prohealth/app/services/encode_decode_base64.dart';
import 'package:prohealth/app/services/token/token_manager.dart';

import '../../../../../data/api_data/api_data.dart';
import '../../../../../data/api_data/establishment_data/whitelabelling_modal/whitelabelling_modal_.dart';
import '../../../../resources/const_string.dart';
import '../../api.dart';
import '../../repository/establishment_manager/establishment_repository.dart';
import 'org_doc_ccd.dart';


///post
Future<ApiData> postWhitelabellingAdd(
    BuildContext context,
    String officeId,
    String primaryNo,
    String secondaryNo,
    String primFax,
    String secondaryFax,
    String alternativeNo,
    String email,
    String name,
    String address,

    ) async{
  try {
    final companyId = await TokenManager.getCompanyId();
    var response = await Api(context).post(
        path: EstablishmentManagerRepository.
        postCompanyOffice(),
        data: {
          "company_id": companyId,
          "office_id": officeId,
          "primary_phone": primaryNo,
          "secondary_phone": secondaryNo,
          "primary_fax": primFax,
          "secondary_fax": secondaryFax,
          "alternative_phone":alternativeNo,
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


/// Upload Logo
Future<ApiData> uploadWebAndAppLogo({
  required BuildContext context,
  required String type,
  required dynamic documentFile,
  required String documentName,
}
    ) async{
  try {
    final companyId = await TokenManager.getCompanyId();
    var logoDoc = await AppFilePickerBase64.getEncodeBase64(bytes: documentFile);
    var response = await Api(context).post(
        path: EstablishmentManagerRepository.
        uploadCompanyLogo(companyId: companyId, type: type),
        data: {
          "base64":logoDoc
        });
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Logo Uploaded");
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

///
// Future< WhiteLabellingCompanyDetailModal> getWhiteLabellingData(
//     BuildContext context,
//     // int companyID, String officeId
//     int companyDetail
//     ) async {
//   var itemsData;
//   try {
//     final response = await Api(context).get(
//         path: EstablishmentManagerRepository. getWhitelabellingDetail(
//             companyDetail:  companyDetail
//         )
//     );
//     print(response);
//     if (response.statusCode == 200 || response.statusCode == 201) {
//       print("Office details response<<::${itemsData}");
//       // for (var item in response.data['officeDetail']) {
//       itemsData =  WhiteLabellingCompanyDetailModal(
//           // officeName: response.data['officeDetail']['name'],
//           // priNumber: response.data['officeDetail']['primary_phone'],
//           // secNumber: response.data['officeDetail']['secondary_phone'],
//           // alternateNumber: response.data['officeDetail']['alternative_phone'],
//           // address: response.data['officeDetail']['address'],
//           // email: response.data['officeDetail']['email'],
//           // officeID: response.data['officeDetail']["office_id"],
//           sucess: true,
//           message: response.statusMessage!);
//       // }
//       // );
//       // itemsList.add(
//       //   ManageDetails(
//       //       officeName: item['name'],
//       //       priNumber: item['primary_phone'],
//       //       secNumber: item['secondary_phone'],
//       //       alternateNumber: item['alternative_phone'],
//       //       address: item['address'],
//       //       email: item['email'],
//       //       officeID: item["office_id"],
//       //       sucess: true,
//       //       message: response.statusMessage!),
//       // );
//       print("Office details response:::::${itemsData}");
//       // CompanyModel(
//       //   name: response.data['Name'],
//       //   address: response.data['address'],
//       //   );
//     } else {
//       print('Api Error');
//       //return itemsList;
//     }
//     return itemsData;
//   } catch (e) {
//     print("Error $e");
//     return itemsData;
//   }
// }

Future<WhiteLabellingCompanyDetailModal> getWhiteLabellingData(
    BuildContext context,
    ) async {
  late WhiteLabellingCompanyDetailModal itemsData;
  try {
    final companyId = await TokenManager.getCompanyId();
    final url = await EstablishmentManagerRepository.getWhitelabellingDetail(
        companyId: companyId
    );
    print("Fetching data from URL: $url");

    final response = await Api(context).get(path: url);

    if (response.statusCode == 200 || response.statusCode == 201) {
      var responseData = response.data;
      print("Sucess");
      WLCompanyDetailModal companyDetail =
      WLCompanyDetailModal.fromJson(responseData['CompanyDetail']);
      WLContactDetailModal contactDetail =
      WLContactDetailModal.fromJson(responseData['ContactDetail']);
      List<WLLogoModal> logos = (responseData['Logos'] as List).map((logo) =>
          WLLogoModal.fromJson(logo)).toList();


      itemsData = WhiteLabellingCompanyDetailModal(
        companyDetail: companyDetail,
        contactDetail: contactDetail,
        logos: logos,
        message: response.statusMessage ?? 'Success',
        success: true,
      );
    } else {
      itemsData = WhiteLabellingCompanyDetailModal(
        companyDetail: WLCompanyDetailModal(
            companyId: 1,
            name: '',
            description: '',
            url: '',
            address: '',
            headOfficeId: ''
        ),
        contactDetail: WLContactDetailModal(
            companyContactId: 0,
            companyId: 1,
            primaryPhone: '',
            secondaryPhone: '',
            primaryFax: '',
            alternativePhone: '',
            email: ''),
        logos: [],
        success: false,
        message: response.statusMessage ?? 'Whitelabelling get Error',
      );
    }
  } catch (e) {
    itemsData = WhiteLabellingCompanyDetailModal(
      companyDetail: WLCompanyDetailModal(
          companyId: 1,
          name: '',
          description: '',
          url: '',
          address: '',
          headOfficeId: ''
      ),
      contactDetail: WLContactDetailModal(
          companyContactId: 0,
          companyId: 1,
          primaryPhone: '',
          secondaryPhone: '',
          primaryFax: '',
          alternativePhone: '',
          email: ''
      ),
      logos: [],
      success: false,
      message: e.toString(),
    );
  }
  return itemsData;
}

/// workin api
// Future<WhiteLabellingCompanyDetailModal> getWhiteLabellingData(
//     BuildContext context,
//     int companyId,
//     ) async {
//   late WhiteLabellingCompanyDetailModal itemsData;
//   try {
//     final response = await Api(context).get(
//       path: EstablishmentManagerRepository.getWhitelabellingDetail(
//           companyId: companyId
//       ),
//     );
//
//     if (response.statusCode == 200 || response.statusCode == 201) {
//       var responseData = response.data;
//       WLCompanyDetailModal companyDetail =
//       WLCompanyDetailModal.fromJson(responseData['CompanyDetail']);
//       WLContactDetailModal contactDetail =
//       WLContactDetailModal.fromJson(responseData['ContactDetail']);
//       List<WLLogoModal> logos = (responseData['Logos'] as List).map((logo) =>
//           WLLogoModal.fromJson(logo)).toList();
//
//       itemsData = WhiteLabellingCompanyDetailModal(
//         companyDetail: companyDetail,
//         contactDetail: contactDetail,
//         logos: logos,
//         message: response.statusMessage ?? 'Success',
//          success: true,
//       );
//     } else {
//       itemsData = WhiteLabellingCompanyDetailModal(
//
//         companyDetail: WLCompanyDetailModal(
//             companyId: 1,
//             name: '',
//             description: '',
//             url: '',
//             address: '',
//             headOfficeId: ''
//         ),
//         contactDetail: WLContactDetailModal(
//             companyContactId: 0,
//             companyId: 1,
//             primaryPhone: '',
//             secondaryPhone: '',
//             primaryFax: '',
//             alternativePhone: '',
//             email: ''),
//         logos: [],
//         success: false,
//         message: response.statusMessage ?? 'Whitelabelling get Error',
//       );
//     }
//   } catch (e) {
//     itemsData = WhiteLabellingCompanyDetailModal(
//       companyDetail: WLCompanyDetailModal(
//           companyId: 1,
//           name: '',
//           description: '',
//           url: '',
//           address: '',
//           headOfficeId: ''
//       ),
//       contactDetail: WLContactDetailModal(
//           companyContactId: 0,
//           companyId: 1,
//           primaryPhone: '',
//           secondaryPhone: '',
//           primaryFax: '',
//           alternativePhone: '',
//           email: ''
//       ),
//       logos: [
//
//       ],
//       success: false,
//       message: e.toString(),
//     );
//   }
//   return itemsData;
// }
