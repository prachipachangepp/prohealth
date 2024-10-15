import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/services/api/api_offer.dart';
import 'package:prohealth/app/services/api/repository/hr_module_repository/Register/legal_document_repo.dart';
import 'package:prohealth/app/services/api/repository/hr_module_repository/form_repository/form_general_repo.dart';
import 'package:prohealth/app/services/base64/encode_decode_base64.dart';
import 'package:prohealth/app/services/token/token_manager.dart';
import 'package:prohealth/data/api_data/api_data.dart';
import 'package:prohealth/data/api_data/hr_module_data/legal_document_data/legal_oncall_doc_data.dart';


/// Signature Form
Future<ApiDataRegister> htmlFormTemplateSignature({required BuildContext context,
  required int formHtmlTempId,
  required String htmlName,
  required String documentFile,
  required int employeeId,
  required bool signed,
}) async {
  try {
// String documents = await
// AppFilePickerBase64.getEncodeBase64(
// bytes: documentFile);
final companyId = await TokenManager.getCompanyId();
    var response = await ApiOffer(context).post(
      path: LegalDocumentsRepo.postHemlTemplateFormSignature(),
      data: {
          "formHtmlTemplatesId": formHtmlTempId,
          "htmlname": htmlName,
          "base64": documentFile,
          "employeeId": employeeId,
          "createdAt": DateTime.now().toIso8601String(),
          "company_Id": companyId,
          "signed": signed
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Html form Signature Added");
      return ApiDataRegister(
          statusCode: response.statusCode!,
          success: true,
          message: response.statusMessage!);
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

/// OnCall Document
Future<OnCallDocument> getLegalOnCallDocument({
    required BuildContext context, required int callHtmlId,required int employeeId}) async {
//var itemList ;
 var itemsData ;
  try {
    final response = await ApiOffer(context).get(
        path: LegalDocumentsRepo
            .getOnCallDocument(callHtmlId: callHtmlId, employeeId: employeeId));
    if (response.statusCode == 200 || response.statusCode == 201) {
      print('OnCall Document Fetched');
      itemsData = OnCallDocument(onCallId: response.data['id'],
          html: response.data['html'],
          name: response.data['name']);
    } else {
      print("OnCall Document ");
    }
    return itemsData;
  } catch (e) {
    print("error${e}");
    return itemsData;
  }
}

/// CovidTestPolicy Document
Future<CovidTestPolicyDocument> getLegalCovidTestPolicyDocument({
  required BuildContext context, required int covidTestId,required int employeeId}) async {
//var itemList ;
  var itemsData ;
  try {
    final response = await ApiOffer(context).get(
        path: LegalDocumentsRepo
            .getCovidTestPolicyDocument(covidTestId: covidTestId, employeeId: employeeId));
    if (response.statusCode == 200 || response.statusCode == 201) {
      print('covidTest Document Fetched');
      itemsData = CovidTestPolicyDocument(covidTestData: response.data.toString());
    } else {
      print("covidTest Document ");
    }
    return itemsData;
  } catch (e) {
    print("error${e}");
    return itemsData;
  }
}

/// ConfidentialStatement Document
Future<ConfidentialStatementDocument> getLegalConfidentialStatementDocument({
  required BuildContext context, required int ConfidentialStatementId,required int employeeId}) async {
//var itemList ;
  var itemsData ;
  try {
    final response = await ApiOffer(context).get(
        path: LegalDocumentsRepo
            .getConfidentialStatementDocument(confidentialId: ConfidentialStatementId, employeeId: employeeId));
    if (response.statusCode == 200 || response.statusCode == 201) {
      print('confidentialDocument Fetched');
      itemsData = ConfidentialStatementDocument(confidentialDocument: response.data.toString());
    } else {
      print("confidentialDocument ");
    }
    return itemsData;
  } catch (e) {
    print("error${e}");
    return itemsData;
  }
}

/// reportingAbuseDocument
Future<ReportingAbuseDocument> getLegalReportingAbuseDocumentDocument({
  required BuildContext context, required int reportingAbuseId,required int employeeId}) async {
//var itemList ;
  var itemsData ;
  try {
    final response = await ApiOffer(context).get(
        path: LegalDocumentsRepo
            .getreportingAbuseDocument(reportingAbuseId: reportingAbuseId, employeeId: employeeId));
    if (response.statusCode == 200 || response.statusCode == 201) {
      print('reportingAbuseDocument Fetched');
      itemsData = ReportingAbuseDocument(reportingAbuseDocument: response.data.toString());
    } else {
      print("reportingAbuseDocument ");
    }
    return itemsData;
  } catch (e) {
    print("error${e}");
    return itemsData;
  }
}

/// reportingAbuseDocument
Future<PolicyConcerningDocument> getLegalpolicyConcerningDocument({
  required BuildContext context, required int policyConcerningId,required int employeeId}) async {
//var itemList ;
  var itemsData ;
  try {
    final response = await ApiOffer(context).get(
        path: LegalDocumentsRepo
            .getpolicyConcerningDocument(policyConcerningId: policyConcerningId, employeeId: employeeId));
    if (response.statusCode == 200 || response.statusCode == 201) {
      print('policyConcerning document Fetched');
      itemsData = PolicyConcerningDocument(policyConcerningDocument: response.data.toString());
    } else {
      print("policyConcerningDocument ");
    }
    return itemsData;
  } catch (e) {
    print("error${e}");
    return itemsData;
  }
}