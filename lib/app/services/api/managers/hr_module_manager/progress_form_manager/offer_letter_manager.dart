

import 'dart:math';

import 'package:flutter/cupertino.dart';

import '../../../../../../data/api_data/api_data.dart';
import '../../../../../../data/api_data/hr_module_data/offer_letter_html_data/offer_letter_html.dart';
import '../../../../../resources/const_string.dart';
import '../../../api.dart';
import '../../../repository/hr_module_repository/form_repository/offer_leter_repo.dart';

///GET:-template---GET/employee-offers/GetEmployeeOffer/{EmployeeId}/{templateId

Future<OfferLetterData> GetOfferLetter(BuildContext context,
    int employeeId,
    int templateId
    ) async {
  // List<OfferLetterData> itemsList = [];
  var itemsList;
  try {
    final response = await Api(context)
        .get(path: OfferLetterHtmlRepo.getOfferLetterHtml(
        employeeId: employeeId, templateId: templateId));
    if (response.statusCode == 200 || response.statusCode == 201) {

        itemsList =
            OfferLetterData(
                docUploadStatus: response.data['DocumentUploadStatus'],
                templateName: response.data['templateName'],
                template: response.data['template']
            );
    } else {
      print('Api Error');
    }
    print("Response:::::${response}");
    return itemsList;
  } catch (e) {
    print("Error $e");
    return itemsList;
  }
}

///accept offer accept offer----PATCH/employee-offers/acceptOffer/{offerId}
Future<ApiData> updateOfferLetter(
     BuildContext context,
    int offerId,
    int employeeEnrollId,
    int employeeId,
    String issueDate,
    String lastDate,
    String startDate,
    String verbalDate,
    bool offerAccepted,
   String acceptedDate
    ) async {
  try {
    var response = await Api(context).patch(
      path: OfferLetterHtmlRepo.patchAcceptOffer(offerId: offerId),
      data: {
        "offerId": offerId,
        "employeeEnrollId": employeeEnrollId,
        "employeeId": employeeId,
        "issueDate": issueDate,
        "lastDate": lastDate,
        "startDate": startDate,
        "verbalDate": verbalDate,
        "offerAccepted": offerAccepted,
        "acceptedDate": acceptedDate,
        // "employeeId": employeeId,
        // "graduate": graduate,
        // "degree": degree,
        // "major": major,
        // "city": city,
        // "college": college,
        // "phone": phone,
        // "state": state
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Accept Offer Letter");
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
