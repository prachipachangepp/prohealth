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
Future<List<ManageVendorData>> companyVendorGet(BuildContext context,
    String officeId, int pageNo, int rowNo,) async {
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



///Add contract
Future<ApiData> addVendorContract(
    BuildContext context,
    int insuranceVendorId,
    String contractName,
    String expiryType,
    String officeId,
    String contractId,
    ) async {
  try {
    final companyId= await TokenManager.getCompanyId();
    var response = await Api(context).post(
        path: EstablishmentManagerRepository.companyOfficeContractPost(),
        data: {
          "insuranceVendorId": insuranceVendorId,
          "contractName": contractName,
          "expiry_type": expiryType,
          "companyId": companyId,
          "officeId": officeId,
          "contractId": contractId,
        });
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Contract Addded");
      print("Contract Response ${response.data}");
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

/// get contract /insurance-vendor-contract/{CompanyId}/{officeId}/{insuranceVendorId}/{pageNbr}/{NbrofRows}
Future<List<ManageInsuranceContractData>> companyContractGetByVendorId(BuildContext context,
    String officeId, int insuranceVendorId ,int pageNo, int rowNo,) async {
  List<ManageInsuranceContractData> itemsList = [];
  try {
    final companyId = await TokenManager.getCompanyId();
    final response = await Api(context)
        .get(path: EstablishmentManagerRepository.companyOfficeContractGet(companyId: companyId, officeId: officeId,
        pageNo: pageNo, rowNo: rowNo, insuranceVendorId: insuranceVendorId));
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Companyy contract get:::::${itemsList}");
      for (var item in response.data) {
        itemsList.add(
          ManageInsuranceContractData(
            sucess: true,
            message: response.statusMessage!,
            insuranceVendorContracId: item['insuranceVendorContracId'],
            insuranceVendorId: item['insuranceVendorId'],
            contractName: item['contractName'],
            contractId: item['contractId'],
            expiryType: item['expiry_type'],
            officeId: item['officeId'],
            expiryDate: item['expiry_date'] ?? "",
            expiryReminder: item['expiry_reminder'] ?? "",
            companyId: companyId,
          ),
        );
      }
      print("Companyy contract data:::::${itemsList}");
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


///delete contract
Future<ApiData> deleteContract(BuildContext context, int insuranceVendorContracId) async {
  try {
    var response = await Api(context)
        .delete(path: EstablishmentManagerRepository.companyOfficeContractPatchDeleteprefill(insuranceVendorContracId: insuranceVendorContracId));
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Delete contract");
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

///prefill contract
Future<ManageContractPrefill> getPrefillContract(
    BuildContext context, int insuranceVendorContracId) async {
  var itemsList;
  try {
    final companyId = await TokenManager.getCompanyId();
    final response = await Api(context).get(
        path: EstablishmentManagerRepository.companyOfficeContractPatchDeleteprefill(insuranceVendorContracId: insuranceVendorContracId));
    if (response.statusCode == 200 || response.statusCode == 201) {
      // print("Document type Response:::::${itemsList}");
      itemsList = ManageContractPrefill(
        insuranceVendorContracId: response.data['insuranceVendorContracId'],
        insuranceVendorId: response.data['insuranceVendorId'],
        companyId: companyId,
        officeId: response.data['officeId'],
        contractName: response.data['contractName'],
        contractId: response.data['contractId'],
        expiryType: response.data['expiry_type'] ?? "",
        expiryDate: response.data['expiry_date'] ?? "",
        expiryReminder: response.data['expiry_reminder'] ?? "",
      );
    } else {
      print('Api Error');
      //return itemsList;
    }
    print("contract Prefill Response:::::${itemsList}");
    return itemsList;
  } catch (e) {
    print("Error $e");
    return itemsList;
  }
}

///patch contract
Future<ApiData> patchCompanyContract(
    BuildContext context,
    int insuranceVendorId,
    String officeId,
    String contractName,
    String expirType,
    String contractId,
    ) async {
  try {
    final companyId = await TokenManager.getCompanyId();
    var response = await Api(context).patch(
        path: EstablishmentManagerRepository.companyOfficeVendorPatchDelete(
            insuranceVendorId: insuranceVendorId),
        data: {
          "contractName": contractName,
          "officeId": officeId,
          "companyId": companyId,
          "expiry_type": expirType,
          "contractId": contractId,
        });

    if (response.statusCode == 200 || response.statusCode == 201) {
      print("contract Updated");
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