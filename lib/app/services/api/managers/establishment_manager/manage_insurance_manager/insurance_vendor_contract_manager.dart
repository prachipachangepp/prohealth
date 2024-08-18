import 'package:flutter/material.dart';
import 'package:prohealth/app/services/token/token_manager.dart';
import 'package:prohealth/main.dart';

import '../../../../../../data/api_data/api_data.dart';
import '../../../../../../data/api_data/establishment_data/ci_manage_button/manage_insurance_data.dart';
import '../../../../../resources/const_string.dart';
import '../../../api.dart';
import '../../../repository/establishment_manager/establishment_repository.dart';

///Add vendors
Future<ApiData> addVendors(
  BuildContext context,
  String officeId,
  String vendorName,
) async {
  try {
    final companyId= await TokenManager.getCompanyId();
    var response = await Api(context).post(
        path: EstablishmentManagerRepository.companyOfficeVendorPost(),
        data: {
          "vendorName": vendorName,
          "officeId": officeId,
          "companyId": companyId,
        });
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Vendor Addded");
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

/// get vendor /insurance-vendor/{CompanyId}/{officeId}/{pageNbr}/{NbrofRows}
Future<List<ManageVendorData>> companyVendorGet(BuildContext context, String officeId, int pageNo, int rowNo,) async {
  List<ManageVendorData> itemsList = [];
  try {
    final companyId = await TokenManager.getCompanyId();
    final response = await Api(context)
        .get(path: EstablishmentManagerRepository.companyOfficeVendorGet(companyId: companyId, officeId: officeId, pageNo: pageNo, rowNo: rowNo));
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Companyy vendor get:::::${itemsList}");
      for (var item in response.data) {
        itemsList.add(
          ManageVendorData(
            sucess: true,
            message: response.statusMessage!,
            insuranceVendorId: item['insuranceVendorId'],
            officeId: item['officeId'],
            vendorName: item['vendorName'],
            address: item['vendorAddress'],
            phone: item['vendorPhone'],
            companyId: companyId,
          ),
        );
      }
      print("Companyy vendor data:::::${itemsList}");
    } else {
      print('Api Error');
      //return itemsList;
    }
    return itemsList;
  } catch (e) {
    print("Error $e");
    return itemsList;
  }
}

/// patch vendor
Future<ApiData> patchCompanyVendor(
    BuildContext context,
    int insuranceVendorId,
    String officeId,
    String vendorName,
    ) async {
  try {
    final companyId = await TokenManager.getCompanyId();
    var response = await Api(context).patch(
        path: EstablishmentManagerRepository.companyOfficeVendorPatchDelete(
            insuranceVendorId: insuranceVendorId),
        data: {
          "vendorName": vendorName,
          "officeId": officeId,
          "companyId": companyId,
        });

    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Vendor Updated");
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

///delete vendor
Future<ApiData> deleteVendor(
    BuildContext context, int vendorId) async {
  try {
    var response = await Api(context).delete(
        path: EstablishmentManagerRepository.companyOfficeVendorPatchDelete(insuranceVendorId: vendorId));
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Deleted Document :::${vendorId}");
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

/// GET prefill vendor
Future<ManageVendorPrefill> getPrefillVendor(
    BuildContext context, int vendorId) async {
  var itemsList;
  try {
    final response = await Api(context).get(
        path: EstablishmentManagerRepository.companyOfficeVendorPatchDelete(insuranceVendorId: vendorId));
    if (response.statusCode == 200 || response.statusCode == 201) {
      // print("Document type Response:::::${itemsList}");
      itemsList = ManageVendorPrefill(
        vendorId: response.data['vendorId'],
        officeId: response.data['officeId'],
        vendorName: response.data['vendorName'],
        address: response.data['address'],
        city: response.data['city'],
        email: response.data['email'],
        phone: response.data['phone'],
        workEmail: response.data['work_email'],
        workPhone: response.data['work_phone'],
        zone: response.data['zone'],
      );
    } else {
      print('Api Error');
      //return itemsList;
    }
    print("vendor Prefill Response:::::${itemsList}");
    return itemsList;
  } catch (e) {
    print("Error $e");
    return itemsList;
  }
}
