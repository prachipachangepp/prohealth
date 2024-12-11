import 'package:flutter/material.dart';
import 'package:prohealth/app/services/api/api_offer.dart';
import 'package:prohealth/app/services/api/repository/hr_module_repository/Register/legal_document_repo.dart';
import 'package:prohealth/app/services/api/repository/hr_module_repository/form_repository/form_general_repo.dart';
import 'package:prohealth/data/api_data/hr_module_data/legal_document_data/legal_oncall_doc_data.dart';

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
      itemsData = OnCallDocument(onCallData: response.data.toString());
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