import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prohealth/app/services/api/api_offer.dart';
import 'package:prohealth/app/services/token/token_manager.dart';

import '../../../../../../data/api_data/api_data.dart';
import '../../../../../../data/api_data/hr_module_data/onlink_general/onlink_general_data.dart';
import '../../../api.dart';
import '../../../repository/hr_module_repository/form_repository/onlinj_general_repo/onlink_general_repo.dart';

Future<OnlinkGeneralData> getGeneralIdPrefill(
    BuildContext context, int employeeId) async {
  String convertIsoToDayMonthYear(String isoDate) {
    // Parse ISO date string to DateTime object
    DateTime dateTime = DateTime.parse(isoDate);

    // Create a DateFormat object to format the date
    DateFormat dateFormat = DateFormat('yyyy-MM-dd');

    // Format the date into "dd mm yy" format
    String formattedDate = dateFormat.format(dateTime);

    return formattedDate;
  }
  var itemsList;
  try {
    final companyId = TokenManager.getCompanyId();
    final response = await Api(context).get(
        path: OnlinkGeneralRepo.getGeneralByIdPrefill(employeeId: employeeId
        ));
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("onlink general response:::::${itemsList}");
      String formatedDOBDate = convertIsoToDayMonthYear(response.data['dateOfBirth']);
      itemsList = OnlinkGeneralData(
        employeeId: response.data['employeeId'] ?? 0,
        userId: response.data['userId'] ?? 0,
        code: response.data['code'] ?? '--',
        firstName: response.data['firstName'] ?? "--",
        lastName: response.data['lastName'] ?? "--",
        departmentId: response.data['departmentId'] ?? 0,
        employeeTypeId: response.data['departmentId'] ?? 0,
        expertise: response.data['expertise'] ??"--",
        cityId: response.data['cityId'] ?? 0,
        countryId: response.data['countryId'] ?? 0,
        zoneId: response.data['zoneId'] ?? 0,
        SSNNbr: response.data['SSNNbr'] ?? "--",
        primaryPhoneNbr: response.data['primaryPhoneNbr'] ?? "--",
        secondryPhoneNbr: response.data['secondryPhoneNbr'] ?? "--",
        workPhoneNbr: response.data['workPhoneNbr'] ?? "--",
        regOfficId: response.data['regOfficId'] ?? "--",
        personalEmail: response.data['personalEmail'] ?? '--',
        workEmail: response.data['workEmail'] ?? '--',
        dateOfBirth: formatedDOBDate,
        emergencyContact: response.data['emergencyContact'] ?? "--",
        covreage: response.data['covreage'] ?? "--",
        employment: response.data['employment'] ?? "--",
        gender: response.data['gender'] ?? "--",
        status: response.data['status'] ?? "--",
        service: response.data['service'] ?? "--",
        imgurl: response.data['imgurl'] ?? "--",
        resumeurl: response.data['resumeurl'] ?? "--",
        onboardingStatus: response.data['onboardingStatus'] ?? "--",
        driverLicenceNbr: response.data['driverLicenceNbr'] ?? "--",
        dateofTermination: response.data['dateofTermination'] ?? "--",
        dateofResignation: response.data['dateofResignation'] ?? "--",
        dateofHire: response.data['dateofHire'] ?? "--",
        rehirable: response.data['rehirable'] ?? "--",
        position: response.data['position'] ?? "--",
        finalAddress: response.data['finalAddress'] ?? "--",
        type: response.data['type'] ?? "--",
        reason: response.data['reason'] ?? "--",
        finalPayCheck: response.data['finalPayCheck'] ?? 0,
        checkDate: response.data['checkDate'] ?? "--",
        grossPay: response.data['grossPay'] ?? 0,
        netPay: response.data['netPay'] ?? 0,
        methods: response.data['methods'] ?? "--",
        materials: response.data['materials'] ?? "--",
        race: response.data['race'] ?? "--",
        signatureURL: response.data['signatureURL'] ?? "--",
        companyId: response.data['companyId'] ?? 0,
        city: response.data['city'] ?? "--",
        employeeType: response.data['employeeType'] ?? "--",
        department: response.data['department'] ?? "--",
        country: response.data['country'] ?? "--",
        county: response.data['county'] ?? "--",
        zone: response.data['zone'] ?? "--",
        profileScorePercentage: response.data['profileScorePercentage'] ?? 0.0,
        createdAt: response.data['createdAt'] ?? "--",
      );

    } else {
      return itemsList;
    }
    return itemsList;
  } catch (e) {
    print("Error $e");
    return itemsList;
  }
}


///patch
Future<ApiDataRegister> updateOnlinkGeneralPatch(
    BuildContext context,
    int employeeId,
    String code,
    int userId,
    String firstName,
    String lastName,
    int departmentId,
    int employeeTypeId,
    String expertise,
    int cityId,
    int countryId,
    int countyId,
    int zoneId,
    String SSNNbr,
    String primaryPhoneNbr,
    String secondaryPhoneNbr,
    String workPhoneNbr,
    String regOfficId,
    String personalEmail,
    String workEmail,
    String address,
    String dateOfBirth, // Ensure this is formatted correctly
    String emergencyContact,
    String covreage,
    String employment,
    String gender,
    String status,
    String service,
    String imgurl,
    String resumeurl,
    int companyId,
    String onboardingStatus,
    String driverLicenceNbr,
    String dateofTermination, // Ensure this is formatted correctly
    String dateofResignation, // Ensure this is formatted correctly
    String dateofHire, // Ensure this is formatted correctly
    String rehirable,
    String position,
    String finalAddress,
    String type,
    String reason,
    int finalPayCheck,
    String checkDate, // Ensure this is formatted correctly
    int grossPay,
    int netPay,
    String methods,
    String materials,
    String race,
    String rating,
    String signatureURL,
    ) async {
  try {
    var response = await ApiOffer(context).patch(
      path: OnlinkGeneralRepo.patchGeneralById(employeeId: employeeId),
      data: {
        'code': code,
        'userId': userId,
        'firstName': firstName,
        'lastName': lastName,
        'departmentId': departmentId,
        'employeeTypeId': employeeTypeId,
        'expertise': expertise,
        'cityId': cityId,
        'countryId': countryId,
        'countyId': countyId,
        'zoneId': zoneId,
        'SSNNbr': SSNNbr,
        'primaryPhoneNbr': primaryPhoneNbr,
        'secondryPhoneNbr': secondaryPhoneNbr,
        'workPhoneNbr': workPhoneNbr,
        'regOfficId': regOfficId,
        'personalEmail': personalEmail,
        'workEmail': workEmail,
        'address': address,
        'dateOfBirth': "${dateOfBirth}T00:00:00Z",
        'emergencyContact': emergencyContact,
        'covreage': covreage,
        'employment': employment,
        'gender': gender,
        'status': status,
        'service': service,
        'imgurl': imgurl,
        'resumeurl': resumeurl,
        'companyId': companyId,
        'onboardingStatus': onboardingStatus,
        'driverLicenceNbr': driverLicenceNbr,
        'dateofTermination': "2024-01-01T00:00:00Z",
        'dateofResignation': "2024-01-01T00:00:00Z",
        'dateofHire': "2024-01-01T00:00:00Z",
        'rehirable': rehirable,
        'position': position,
        'finalAddress': finalAddress,
        'type': type,
        'reason': reason,
        'finalPayCheck': finalPayCheck,
        'checkDate': "2024-01-01T00:00:00Z",
        'grossPay': grossPay,
        'netPay': netPay,
        'methods': methods,
        'materials': materials,
        'race': race,
        'rating': rating,
        'signatureURL': signatureURL,
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print("User updated");
      return ApiDataRegister(
        statusCode: response.statusCode!,
        success: true,
        message: response.statusMessage!,
      );
    } else {
      print("Error: ${response.data['message']}");
      return ApiDataRegister(
        statusCode: response.statusCode!,
        success: false,
        message: response.data['message'],
      );
    }
  } catch (e) {
    print("Error: $e");
    return ApiDataRegister(
      statusCode: 404,
      success: false,
      message: "Something went wrong",
    );
  }
}
