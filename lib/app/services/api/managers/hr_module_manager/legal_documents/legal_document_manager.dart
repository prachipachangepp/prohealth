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
Future<ApiDataRegister> htmlFormTemplateSignature({
  required BuildContext context,
  required int formHtmlTempId,
  required String htmlName,
  required String documentFile,
  required int employeeId,
  required bool signed,
}) async {
  try {
    // String documents = await
    // AppFilePickerBase64.getEncodeBase64(
    //     bytes: documentFile);
    final companyId = await TokenManager.getCompanyId();
    var data = {
      "formHtmlTemplatesId": formHtmlTempId,
      "htmlname": htmlName,
      "base64": documentFile,
      "employeeId": employeeId,
      "createdAt": DateTime.now().toIso8601String(),
      "company_Id": companyId,
      "signed": signed
    };
    print('All sign data ${data}');

    var response = await ApiOffer(context).post(
      path: LegalDocumentsRepo.postHemlTemplateFormSignature(),
      data: {
        "formHtmlTemplatesId": formHtmlTempId,
        "htmlname": htmlName,
        "base64": documentFile,
        "employeeId": employeeId,
        "createdAt": DateTime.now().toIso8601String()+"Z",
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
Future<OnCallDocument> getLegalOnCallDocument(
    {required BuildContext context,
    required int callHtmlId,
    required int employeeId}) async {
//var itemList ;
  var itemsData;
  try {
    final response = await ApiOffer(context).get(
        path: LegalDocumentsRepo.getOnCallDocument(
            callHtmlId: callHtmlId, employeeId: employeeId));
    if (response.statusCode == 200 || response.statusCode == 201) {
      print('OnCall Document Fetched');
      itemsData = OnCallDocument(
          onCallId: response.data['id'],
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
Future<CovidTestPolicyDocument> getLegalCovidTestPolicyDocument(
    {required BuildContext context,
    required int covidTestId,
    required int employeeId}) async {
//var itemList ;
  var itemsData;
  try {
    final response = await ApiOffer(context).get(
        path: LegalDocumentsRepo.getCovidTestPolicyDocument(
            covidTestId: covidTestId, employeeId: employeeId));
    if (response.statusCode == 200 || response.statusCode == 201) {
      print('covidTest Document Fetched');
      itemsData = CovidTestPolicyDocument(
          covidTestPolicyId: response.data['id'],
          name: response.data['name'],
          html: response.data['html']);
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
Future<ConfidentialStatementDocument> getLegalConfidentialStatementDocument(
    {required BuildContext context,
    required int ConfidentialStatementId,
    required int employeeId}) async {
//var itemList ;
  var itemsData;
  try {
    final response = await ApiOffer(context).get(
        path: LegalDocumentsRepo.getConfidentialStatementDocument(
            confidentialId: ConfidentialStatementId, employeeId: employeeId));
    if (response.statusCode == 200 || response.statusCode == 201) {
      print('confidentialDocument Fetched');
      itemsData = ConfidentialStatementDocument(
          confidentialStatementId: response.data['id'],
          name: response.data['name'],
          html: response.data['html']);
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
Future<ReportingAbuseDocument> getLegalReportingAbuseDocumentDocument(
    {required BuildContext context,
    required int reportingAbuseId,
    required int employeeId}) async {
//var itemList ;
  var itemsData;
  try {
    final response = await ApiOffer(context).get(
        path: LegalDocumentsRepo.getreportingAbuseDocument(
            reportingAbuseId: reportingAbuseId, employeeId: employeeId));
    if (response.statusCode == 200 || response.statusCode == 201) {
      print('reportingAbuseDocument Fetched');
      itemsData = ReportingAbuseDocument(
          reportingAbuseId: response.data['id'],
          name: response.data['name'],
          html: response.data['html']);
    } else {
      print("reportingAbuseDocument ");
    }
    return itemsData;
  } catch (e) {
    print("error${e}");
    return itemsData;
  }
}

/// policyConcerningDocument
Future<PolicyConcerningDocument> getLegalpolicyConcerningDocument(
    {required BuildContext context,
    required int policyConcerningId,
    required int employeeId}) async {
//var itemList ;
  var itemsData;
  try {
    final response = await ApiOffer(context).get(
        path: LegalDocumentsRepo.getpolicyConcerningDocument(
            policyConcerningId: policyConcerningId, employeeId: employeeId));
    if (response.statusCode == 200 || response.statusCode == 201) {
      print('policyConcerning document Fetched');
      itemsData = PolicyConcerningDocument(
          policyConcerningId: response.data['id'],
          name: response.data['name'],
          html: response.data['html']);
    } else {
      print("policyConcerningDocument ");
    }
    return itemsData;
  } catch (e) {
    print("error${e}");
    return itemsData;
  }
}

/// Candidates reales form
// Future<PolicyConcerningDocument> getLegalpolicyConcerningDocument({
//   required BuildContext context, required int policyConcerningId,required int employeeId}) async {
// //var itemList ;
//   var itemsData ;
//   try {
//     final response = await ApiOffer(context).get(
//         path: LegalDocumentsRepo
//             .getpolicyConcerningDocument(policyConcerningId: policyConcerningId, employeeId: employeeId));
//     if (response.statusCode == 200 || response.statusCode == 201) {
//       print('policyConcerning document Fetched');
//       itemsData = PolicyConcerningDocument(policyConcerningId: response.data['id'], name: response.data['name'], html: response.data['html']);
//     } else {
//       print("policyConcerningDocument ");
//     }
//     return itemsData;
//   } catch (e) {
//     print("error${e}");
//     return itemsData;
//   }
// }

/// Standard of conduct form
Future<StandardConductDocument> getStandardConductDocument({
  required BuildContext context, required int standardConductId,required int employeeId}) async {
//var itemList ;
  var itemsData ;
  try {
    final response = await ApiOffer(context).get(
        path: LegalDocumentsRepo
            .getStandardConductDocument(standardConductId: standardConductId, employeeId: employeeId));
    if (response.statusCode == 200 || response.statusCode == 201) {
      print('StandardConduct document Fetched');
      itemsData = StandardConductDocument(standardConductId: response.data['id'], name: response.data['name'], html: response.data['html']);
    } else {
      print("StandardConductDocument ");
    }
    return itemsData;
  } catch (e) {
    print("error${e}");
    return itemsData;
  }
}

/// Sexual Haressment document
Future<SexualHaressmentDocument> getSexualHaressmentDocument({
  required BuildContext context, required int templateId,required int employeeId}) async {
//var itemList ;
  var itemsData ;
  try {
    final response = await ApiOffer(context).get(
        path: LegalDocumentsRepo
            .getSexualHaressmentDocument(templateId: templateId, employeeId: employeeId));
    if (response.statusCode == 200 || response.statusCode == 201) {
      print('SexualHaressment document Fetched');
      itemsData = SexualHaressmentDocument(sexualHaressmentId: response.data['id'], name: response.data['name'], html: response.data['html']);
    } else {
      print("SexualHaressmentDocument ");
    }
    return itemsData;
  } catch (e) {
    print("error${e}");
    return itemsData;
  }
}

/// Sexual And Unlawful Document
Future<SexualAndUnlawfulDocument> getSexualAndUnlawfulDocument({
  required BuildContext context, required int templateId,required int employeeId}) async {
//var itemList ;
  var itemsData ;
  try {
    final response = await ApiOffer(context).get(
        path: LegalDocumentsRepo
            .getSexualAndUnlawfulDocument(templateId: templateId, employeeId: employeeId));
    if (response.statusCode == 200 || response.statusCode == 201) {
      print('SexualAndUnlawful document Fetched');
      itemsData = SexualAndUnlawfulDocument(sexualUnlawfulId: response.data['id'], name: response.data['name'], html: response.data['html']);
    } else {
      print("SexualAndUnlawfulDocument ");
    }
    return itemsData;
  } catch (e) {
    print("error${e}");
    return itemsData;
  }
}

/// Pre auth patient visits
Future<PreAuthPatientVisitsDocument> getPreAuthPatientVisitsDocument({
  required BuildContext context, required int templateId,required int employeeId}) async {
//var itemList ;
  var itemsData ;
  try {
    final response = await ApiOffer(context).get(
        path: LegalDocumentsRepo
            .getPreAuthPatientVisitsDocument(templateId: templateId, employeeId: employeeId));
    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Pre Auth Patient Visits document Fetched');
      itemsData = PreAuthPatientVisitsDocument(preAuthPatientId: response.data['id'], name: response.data['name'], html: response.data['html']);
    } else {
      print("PreAuthPatientVisitsDocument ");
    }
    return itemsData;
  } catch (e) {
    print("error${e}");
    return itemsData;
  }
}

/// Pro 65 document
Future<ProDocument> getPro65Document({
  required BuildContext context, required int templateId,required int employeeId}) async {
//var itemList ;
  var itemsData ;
  try {
    final response = await ApiOffer(context).get(
        path: LegalDocumentsRepo
            .getPro65Document(templateId: templateId, employeeId: employeeId));
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(' Pro 65 Document Fetched');
      itemsData = ProDocument(proDocumentId: response.data['id'], name: response.data['name'], html: response.data['html']);
    } else {
      print("ProDocument ");
    }
    return itemsData;
  } catch (e) {
    print("error${e}");
    return itemsData;
  }
}

/// return of company property
Future<ReturnOfCompanyProperty> getReturnOfCompanyPropertyDocument({
  required BuildContext context, required int templateId,required int employeeId}) async {
//var itemList ;
  var itemsData ;
  try {
    final response = await ApiOffer(context).get(
        path: LegalDocumentsRepo
            .getReturnOfCompanyDocument(templateId: templateId, employeeId: employeeId));
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(' Return Of Company Property Fetched');
      itemsData = ReturnOfCompanyProperty(returnOfCompanyPropertyId: response.data['id'], name: response.data['name'], html: response.data['html']);
    } else {
      print("ReturnOfCompanyPropertyDocument ");
    }
    return itemsData;
  } catch (e) {
    print("error${e}");
    return itemsData;
  }
}

/// Hep B document
Future<HepBDocuemnt> getHepBDocument({
  required BuildContext context, required int templateId,required int employeeId}) async {
//var itemList ;
  var itemsData ;
  try {
    final response = await ApiOffer(context).get(
        path: LegalDocumentsRepo
            .getHepBDocument(templateId: templateId, employeeId: employeeId));
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(' Hep B DocuemntFetched');
      itemsData = HepBDocuemnt(hepBDocuemntId: response.data['id'], name: response.data['name'], html: response.data['html']);
    } else {
      print("HepBDocuemnt ");
    }
    return itemsData;
  } catch (e) {
    print("error${e}");
    return itemsData;
  }
}

/// T Dap document
Future<TDapDocuemnt> getTDapDocument({
  required BuildContext context, required int templateId,required int employeeId}) async {
//var itemList ;
  var itemsData ;
  try {
    final response = await ApiOffer(context).get(
        path: LegalDocumentsRepo
            .getTDapDocument(templateId: templateId, employeeId: employeeId));
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(' T Dap Docuemnt Fetched');
      itemsData = TDapDocuemnt(tDapDocuemnttId: response.data['id'], name: response.data['name'], html: response.data['html']);
    } else {
      print("TDapDocuemnt ");
    }
    return itemsData;
  } catch (e) {
    print("error${e}");
    return itemsData;
  }
}

/// Covid Vaccine document
Future<CovidVaccineDocuemnt> getCovidVaccineDocument({
  required BuildContext context, required int templateId,required int employeeId}) async {
//var itemList ;
  var itemsData ;
  try {
    final response = await ApiOffer(context).get(
        path: LegalDocumentsRepo
            .getCovidVaccineDocument(templateId: templateId, employeeId: employeeId));
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(' Covid Vaccine Docuemnt Fetched');
      itemsData = CovidVaccineDocuemnt(covidVaccineDocuemntId: response.data['id'], name: response.data['name'], html: response.data['html']);
    } else {
      print("CovidVaccineDocuemnt ");
    }
    return itemsData;
  } catch (e) {
    print("error${e}");
    return itemsData;
  }
}