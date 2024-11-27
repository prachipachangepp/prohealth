import 'package:flutter/material.dart';

import '../../../../../../data/api_data/api_data.dart';
import '../../../../../resources/const_string.dart';
import '../../../../base64/encode_decode_base64.dart';
import '../../../../token/token_manager.dart';
import '../../../api_offer.dart';
import '../../../repository/hr_module_repository/onboarding/clinical_licenses_repo.dart';

Future<ApiDataRegister> postDrivinglicenseData(
    BuildContext context,
    //String idOfDocument,
    String expirydate,
    String doccreatedat,
   // int companyId,
    int employeeid,
    String url,
    //String officeid,
    String filename,

    ) async {
  try {
    final companyId = await TokenManager.getCompanyId();
    var response = await ApiOffer(context).post(
      path:ClinicalLicensesRepo.postDrivingLicense(),
      data: {
        "idOfDocument": "Driving License",
        "expiry_date": "${expirydate}T00:00:00Z",
        "doc_created_at":  DateTime.now().toIso8601String()+"Z",                           //"${doccreatedat}T00:00:00Z",
        "company_id": companyId,
        "employee_id": employeeid,
        "url": url,
        "office_id": '',
        "file_name": filename

      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Driving License Added");
      var dataId =response.data;
      var drivingLicenceId =  dataId["drivingLicenceId"];
      return ApiDataRegister(
          statusCode: response.statusCode!,
          success: true,
drivingLicenceId: drivingLicenceId,
          message: response.statusMessage!);
    } else {
      print("Error 1DLLLLLLLL");
      return ApiDataRegister(
          statusCode: response.statusCode!,
          success: false,
          message: response.data['message']);
    }
  } catch (e) {
    print("Error $e");
    return ApiDataRegister(
        statusCode: 404, success: false, message: AppString.somethingWentWrong);
  }
}



///post postpractitionerLicense
Future<ApiDataRegister> postpractitionerLicenseData(
    BuildContext context,
    //String idOfDocument,
    String expirydate,
    String doccreatedat,
    // int companyId,
    int employeeid,
    String url,
    //String officeid,
    String filename,

    ) async {
  try {
    final companyId = await TokenManager.getCompanyId();
    var response = await ApiOffer(context).post(
      path:ClinicalLicensesRepo.postpractitionerLicense(),
      data: {
        "idOfDocument": "Practitioner License",
        "expiry_date": "${expirydate}T00:00:00Z",
        "doc_created_at": DateTime.now().toIso8601String()+"Z",
        "company_id": companyId,
        "employee_id":employeeid,
        "url": url,
        "office_id": '',
        "file_name": filename,
        "approved": true

      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(">>>>>Practitioner License Added");
var dataId =response.data;
var practitionerLicenceId =  dataId["practitionerLicenceId"];
      return ApiDataRegister(
          statusCode: response.statusCode!,
          success: true,
          practitionerLicenceId: practitionerLicenceId,
          message: response.statusMessage!);
    } else {
      print("'''''''Error 1   ;;;;;;");
      return ApiDataRegister(
          statusCode: response.statusCode!,
          success: false,
          message: response.data['message']);
    }
  } catch (e) {
    print("Error $e");
    return ApiDataRegister(
        statusCode: 404, success: false, message: AppString.somethingWentWrong);
  }
}




Future<ApiDataRegister> uploadDocumentsPL({
  required BuildContext context,
  required int practitionerLicenceId,
  required dynamic documentFile,
  required String documentName

}) async {
  try {
    String documents = await AppFilePickerBase64.getEncodeBase64(bytes: documentFile);
    print("File :::${documents}" );
    var response = await ApiOffer(context).post(
      path:ClinicalLicensesRepo.postpractitionerLicensebase64(practitionerLicenceId: practitionerLicenceId),
      data: {
       // 'base64':documents,
        "Base64": documents,
        "file_name":documentName

      },
    );
    print("Response ${response.toString()}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("......>>>>>>>Documents uploaded Plll");
      // orgDocumentGet(context);
      //var uploadResponse = response.data;
      //int documentId = uploadResponse['employeeDocumentId'];
      return ApiDataRegister(
          statusCode: response.statusCode!,
          success: true,
          message: response.statusMessage!, );
    } else {
      print("Error 1");
      return ApiDataRegister(
          statusCode: response.statusCode!,
          success: false,
          message: response.data['message']);
    }
  } catch (e) {
    print("Error $e");
    return ApiDataRegister(
        statusCode: 404, success: false, message: AppString.somethingWentWrong);
  }
}



Future<ApiDataRegister> uploadDocumentsDL({
  required BuildContext context,
  required int drivingLicenceId,
  required dynamic documentFile,
  required String documentName

}) async {
  try {
    String documents = await AppFilePickerBase64.getEncodeBase64(bytes: documentFile);
    print("File :::${documents}" );
    var response = await ApiOffer(context).post(
      path:ClinicalLicensesRepo.postdrivingLicensebase64(drivingLicenceId: drivingLicenceId),
      data: {
        // 'base64':documents,
        "Base64": documents,
        "file_name":documentName

      },
    );
    print("Response ${response.toString()}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("......>>>>>>>Documents uploaded Dll");
      // orgDocumentGet(context);
      //var uploadResponse = response.data;
      //int documentId = uploadResponse['employeeDocumentId'];
      return ApiDataRegister(
        statusCode: response.statusCode!,
        success: true,
        message: response.statusMessage!, );
    } else {
      print("Error 1");
      return ApiDataRegister(
          statusCode: response.statusCode!,
          success: false,
          message: response.data['message']);
    }
  } catch (e) {
    print("Error $e");
    return ApiDataRegister(
        statusCode: 404, success: false, message: AppString.somethingWentWrong);
  }
}