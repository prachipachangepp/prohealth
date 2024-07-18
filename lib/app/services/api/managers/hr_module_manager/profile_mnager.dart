import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prohealth/app/services/api/api.dart';
import 'package:prohealth/app/services/api/repository/hr_module_repository/profile_repo.dart';
import 'package:prohealth/data/api_data/hr_module_data/employee_profile/search_profile_data.dart';


/// Search by Text
/// get api
Future<List<SearchEmployeeProfileData>> getSearchProfileByText(
    BuildContext context, int companyId, String searchText) async {
  String convertIsoToDayMonthYear(String isoDate) {
    // Parse ISO date string to DateTime object
    DateTime dateTime = DateTime.parse(isoDate);

    // Create a DateFormat object to format the date
    DateFormat dateFormat = DateFormat('MM-dd-yyyy');

    // Format the date into "dd mm yy" format
    String formattedDate = dateFormat.format(dateTime);

    return formattedDate;
  }

  List<SearchEmployeeProfileData> itemsData = [];
  try {
    final response = await Api(context)
        .get(path: ProfileRepository.searchEmployeeProfileByText(companyId: companyId, searchText: searchText));
    if (response.statusCode == 200 || response.statusCode == 201) {
      for (var item in response.data) {
        String DateOfBirth = convertIsoToDayMonthYear(item['dateOfBirth']);
        String CreatedAt = convertIsoToDayMonthYear(item['createdAt']);
        String TerminationDate = convertIsoToDayMonthYear(item['dateofTermination']);
        String ReginationDate = convertIsoToDayMonthYear(item['dateofResignation']);
        String CheckDate = convertIsoToDayMonthYear(item['checkDate']);
        String HireDate = convertIsoToDayMonthYear(item['dateofHire']);
        itemsData.add(SearchEmployeeProfileData(
          employeeId: item['employeeId'] ?? 0,
          code: item['code'] ?? '--',
          userId: item['userId'] ?? 0,
          firstName: item['firstName'] ?? '--',
          lastName: item['lastName'] ?? '--',
          departmentId: item['departmentId'] ?? 0,
          employeeTypeId: item['employeeTypeId'] ?? 0,
          expertise: item['expertise'] ?? '--',
          cityId: item['cityId'] ?? 0,
          countryId: item['countryId'] ?? 0,
          zoneId: item['zoneId'] ?? 0,
          SSNNbr: item['SSNNbr'] ?? '--',
          primaryPhoneNbr: item['primaryPhoneNbr'] ?? '--',
          secondryPhoneNbr: item['secondryPhoneNbr'] ?? '--',
          workPhoneNbr: item['workPhoneNbr'] ?? '--',
          regOfficId: item['regOfficId'] ?? '--',
          personalEmail: item['personalEmail'] ?? '--',
          workEmail: item['workEmail'] ?? '--',
          address: item['address'] ?? '--',
          dateOfBirth: DateOfBirth,
          emergencyContact: item['emergencyContact'] ?? '--',
          employment: item['employment'] ?? '--',
          covreage: item['covreage'] ?? '--',
          gender: item['gender'] ?? '--',
          status: item['status'] ?? '--',
          service: item['service'] ?? '--',
          imgurl: item['imgurl'] ?? '--',
          resumeurl: item['resumeurl'] ?? '--',
          onboardingStatus: item['onboardingStatus'] ?? '--',
          createdAt: CreatedAt,
          companyId: item['companyId'] ?? 0,
          terminationFlag: item['terminationFlag'] ?? false,
          approved: item['approved'] ?? false,
          dateofTermination: TerminationDate,
          dateofResignation: ReginationDate,
          rehirable: item['rehirable'] ?? false,
          finalAddress: item['finalAddress'] ?? '--',
          type: item['type'] ?? '--',
          reason: item['reason'] ?? '--',
          finalPayCheck: item['finalPayCheck'] != null ? item['finalPayCheck'].toDouble() : 0.0,
          checkDate: CheckDate,
          grossPay: item['grossPay'] != null ? item['grossPay'].toDouble() : 0.0,
          netPay: item['netPay'] != null ? item['netPay'].toDouble() : 0.0,
          methods: item['methods'] ?? '--',
          materials: item['materials'] ?? '--',
          dateofHire: HireDate,
          position: item['position'] ?? '--',
          driverLicenceNbr: item['driverLicenceNbr'] ?? '--',
          race: item['race'] ?? '--',
        ));
      }
      print("search data by Text");
    } else {
      print("Search Data by Text Error 1");
    }
    return itemsData;
  } catch (e) {
    print("error${e}");
    return itemsData;
  }
}

/// Search by ID
///get
Future<List<SearchEmployeeProfileData>> getSearchProfileById(
    BuildContext context, int companyId, int employeeTypeId) async {
  String convertIsoToDayMonthYear(String isoDate) {
    // Parse ISO date string to DateTime object
    DateTime dateTime = DateTime.parse(isoDate);

    // Create a DateFormat object to format the date
    DateFormat dateFormat = DateFormat('MM-dd-yyyy');

    // Format the date into "dd mm yy" format
    String formattedDate = dateFormat.format(dateTime);

    return formattedDate;
  }

  List<SearchEmployeeProfileData> itemsData = [];
  try {
    final response = await Api(context)
        .get(path: ProfileRepository.searchEmployeeProfileById(companyId: companyId, Id: employeeTypeId));
    if (response.statusCode == 200 || response.statusCode == 201) {
      for (var item in response.data) {
        String DateOfBirth = convertIsoToDayMonthYear(item['dateOfBirth']);
        String CreatedAt = convertIsoToDayMonthYear(item['createdAt']);
        String TerminationDate = convertIsoToDayMonthYear(item['dateofTermination']);
        String ReginationDate = convertIsoToDayMonthYear(item['dateofResignation']);
        String CheckDate = convertIsoToDayMonthYear(item['checkDate']);
        String HireDate = convertIsoToDayMonthYear(item['dateofHire']);
        itemsData.add(SearchEmployeeProfileData(
          employeeId: item['employeeId'] ?? 0,
          code: item['code'] ?? '--',
          userId: item['userId'] ?? 0,
          firstName: item['firstName'] ?? '--',
          lastName: item['lastName'] ?? '--',
          departmentId: item['departmentId'] ?? 0,
          employeeTypeId: item['employeeTypeId'] ?? 0,
          expertise: item['expertise'] ?? '--',
          cityId: item['cityId'] ?? 0,
          countryId: item['countryId'] ?? 0,
          zoneId: item['zoneId'] ?? 0,
          SSNNbr: item['SSNNbr'] ?? '--',
          primaryPhoneNbr: item['primaryPhoneNbr'] ?? '--',
          secondryPhoneNbr: item['secondryPhoneNbr'] ?? '--',
          workPhoneNbr: item['workPhoneNbr'] ?? '--',
          regOfficId: item['regOfficId'] ?? '--',
          personalEmail: item['personalEmail'] ?? '--',
          workEmail: item['workEmail'] ?? '--',
          address: item['address'] ?? '--',
          dateOfBirth: DateOfBirth,
          emergencyContact: item['emergencyContact'] ?? '--',
          employment: item['employment'] ?? '--',
          covreage: item['covreage'] ?? '--',
          gender: item['gender'] ?? '--',
          status: item['status'] ?? '--',
          service: item['service'] ?? '--',
          imgurl: item['imgurl'] ?? '--',
          resumeurl: item['resumeurl'] ?? '--',
          onboardingStatus: item['onboardingStatus'] ?? '--',
          createdAt: CreatedAt,
          companyId: item['companyId'] ?? 0,
          terminationFlag: item['terminationFlag'] ?? false,
          approved: item['approved'] ?? false,
          dateofTermination: TerminationDate,
          dateofResignation: ReginationDate,
          rehirable: item['rehirable'] ?? false,
          finalAddress: item['finalAddress'] ?? '--',
          type: item['type'] ?? '--',
          reason: item['reason'] ?? '--',
          finalPayCheck: item['finalPayCheck'] != null ? item['finalPayCheck'].toDouble() : 0.0,
          checkDate: CheckDate,
          grossPay: item['grossPay'] != null ? item['grossPay'].toDouble() : 0.0,
          netPay: item['netPay'] != null ? item['netPay'].toDouble() : 0.0,
          methods: item['methods'] ?? '--',
          materials: item['materials'] ?? '--',
          dateofHire: HireDate,
          position: item['position'] ?? '--',
          driverLicenceNbr: item['driverLicenceNbr'] ?? '--',
          race: item['race'] ?? '--',
        ));
      }
      print("search data by Id");
    } else {
      print("Search Data by Id Error 1");
    }
    return itemsData;
  } catch (e) {
    print("error${e}");
    return itemsData;
  }
}