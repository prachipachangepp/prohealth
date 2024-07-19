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
        // String DateOfBirth = convertIsoToDayMonthYear(item['dateOfBirth']);
        // String CreatedAt = convertIsoToDayMonthYear(item['createdAt']);
        // String TerminationDate = convertIsoToDayMonthYear(
        //     item['dateofTermination'] ?? '--');
        // String ReginationDate = convertIsoToDayMonthYear(
        //     item['dateofResignation'] ?? '--');
        // //String CheckDate = convertIsoToDayMonthYear(item['checkDate']);
        // String HireDate = convertIsoToDayMonthYear(item['dateofHire'] ?? '--');
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
          dateOfBirth: item['dateOfBirth'] ?? "--",
          emergencyContact: item['emergencyContact'] ?? '--',
          employment: item['employment'] ?? '--',
          covreage: item['covreage'] ?? '--',
          gender: item['gender'] ?? '--',
          status: item['status'] ?? '--',
          service: item['service'] ?? '--',
          imgurl: item['imgurl'] ?? '--',
          resumeurl: item['resumeurl'] ?? '--',
          onboardingStatus: item['onboardingStatus'] ?? '--',
          createdAt: item['createdAt'] ?? "--",
          companyId: item['companyId'] ?? 0,
          terminationFlag: item['terminationFlag'] ?? false,
          approved: item['approved'] ?? false,
          dateofTermination: item['dateofTermination'] ?? "--",
          dateofResignation: item['dateofResignation'] ?? "--",
          rehirable: item['rehirable'] ?? false,
          finalAddress: item['finalAddress'] ?? '--',
          type: item['type'] ?? '--',
          reason: item['reason'] ?? '--',
          finalPayCheck: item['finalPayCheck'] != null ? item['finalPayCheck'].toDouble() : 0.0,
          checkDate: item['checkDate'] ?? '--',
          grossPay: item['grossPay'] != null
              ? item['grossPay'].toDouble()
              : 0.0,
          netPay: item['netPay'] != null ? item['netPay'].toDouble() : 0.0,
          methods: item['methods'] ?? '--',
          materials: item['materials'] ?? '--',
          dateofHire: item['dateofHire'] ?? "--",
          position: item['position'] ?? '--',
          driverLicenceNbr: item['driverLicenceNbr'] ?? '--',
          race: item['race'] ?? '--',
        ));
      }

      print("search data by Text${itemsData}");
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
    /// Parse ISO date string to DateTime object
    DateTime dateTime = DateTime.parse(isoDate);

    /// Create a DateFormat object to format the date
    DateFormat dateFormat = DateFormat('MM-dd-yyyy');

    /// Format the date into "dd mm yy" format
    String formattedDate = dateFormat.format(dateTime);

    return formattedDate;
  }

  List<SearchEmployeeProfileData> itemsData = [];
  try {
    final response = await Api(context)
        .get(path: ProfileRepository.searchEmployeeProfileById(
        companyId: companyId, Id: employeeTypeId));
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

/// employee id wise
Future<SearchByEmployeeIdProfileData> getSearchByEmployeeIdProfileByText(
    BuildContext context, int employeeId) async {
  String convertIsoToDayMonthYear(String isoDate) {
    // Parse ISO date string to DateTime object
    DateTime dateTime = DateTime.parse(isoDate);

    // Create a DateFormat object to format the date
    DateFormat dateFormat = DateFormat('MM-dd-yyyy');

    // Format the date into "dd mm yy" format
    String formattedDate = dateFormat.format(dateTime);

    return formattedDate;
  }

  var itemsData;
  try {
    final response = await Api(context)
        .get(path: ProfileRepository.searchByEmployeeIdProfile(employeeId: employeeId,));
    if (response.statusCode == 200 || response.statusCode == 201) {
        itemsData = SearchByEmployeeIdProfileData(
          code: response.data['code'] ?? '--',
          userId: response.data['userId'] ?? 0,
          firstName: response.data['firstName'] ?? '--',
          lastName: response.data['lastName'] ?? '--',
          departmentId: response.data['departmentId'] ?? 0,
          employeeTypeId: response.data['employeeTypeId'] ?? 0,
          cityId: response.data['cityId'] ?? 0,
          countryId: response.data['countryId'] ?? 0,
          zoneId: response.data['zoneId'] ?? 0,
          SSNNbr: response.data['SSNNbr'] ?? '--',
          primaryPhoneNbr: response.data['primaryPhoneNbr'] ?? '--',
          secondryPhoneNbr: response.data['secondryPhoneNbr'] ?? '--',
          workPhoneNbr: response.data['workPhoneNbr'] ?? '--',
          regOfficId: response.data['regOfficId'] ?? '--',
          personalEmail: response.data['personalEmail'] ?? '--',
          workEmail: response.data['workEmail'] ?? '--',
          dateOfBirth: response.data['dateOfBirth'] ?? "--",
          emergencyContact: response.data['emergencyContact'] ?? '--',
          covreage: response.data['covreage'] ?? '--',
          employment: response.data['employment'] ?? '--',
          gender: response.data['gender'] ?? '--',
          status: response.data['status'] ?? '--',
          service: response.data['service'] ?? '--',
          imgurl: response.data['imgurl'] ?? '--',
          resumeurl: response.data['resumeurl'] ?? '--',
          onboardingStatus: response.data['onboardingStatus'] ?? '',
          driverLicenceNbr: response.data['driverLicenceNbr'] ?? '',
          createdAt: response.data['createdAt'] ?? "--",
          dateofTermination: response.data['dateofTermination'] ?? "--",
          dateofResignation: response.data['dateofResignation'] ?? "--",
          dateofHire: response.data['dateofHire'] ?? "--",
          rehirable: response.data['rehirable'] ??"--",
          position: response.data['position'] ?? '--',
          finalAddress: response.data['finalAddress'] ?? '--',
          type: response.data['type'] ?? '--',
          reason: response.data['reason'] ?? '--',
          finalPayCheck: response.data['finalPayCheck'] != null ? response.data['finalPayCheck'].toDouble() : 0.0,
          checkDate: response.data['checkDate'] ?? "--",
          grossPay: response.data['grossPay'] != null ? response.data['grossPay'].toDouble() : 0.0,
          netPay: response.data['netPay'] != null ? response.data['netPay'].toDouble() : 0.0,
          methods: response.data['methods'] ?? '--',
          materials: response.data['materials'] ?? '--',
          city: response.data['city'] ?? '--',
          employeeType: response.data['employeeType'] ?? '--',
          department: response.data['department'] ?? '--',
          country: response.data['country'] ?? '--',
          zone: response.data['zone'] ?? '--',
          race: response.data['race'] ?? '--',
          profileScorePercentage: response.data['profileScorePercentage'] != null ? response.data['profileScorePercentage'].toDouble() : 0.0,
        );


      print("search data by Text ${itemsData.toString()}");
    } else {
      print("Search Data by Text Error 1");
    }
    return itemsData;
  } catch (e) {
    print("error${e}");
    return itemsData;
  }
}

Future<ProfilePercentage> getPercentage(
    BuildContext context, int employeeId) async {
  String convertIsoToDayMonthYear(String isoDate) {
    // Parse ISO date string to DateTime object
    DateTime dateTime = DateTime.parse(isoDate);

    // Create a DateFormat object to format the date
    DateFormat dateFormat = DateFormat('MM-dd-yyyy');

    // Format the date into "dd mm yy" format
    String formattedDate = dateFormat.format(dateTime);

    return formattedDate;
  }
  var itemsData;
  try {
    final response = await Api(context)
        .get(path: ProfileRepository.getPercentage(employeeId: employeeId,));
    if (response.statusCode == 200 || response.statusCode == 201) {
      itemsData = ProfilePercentage(percentage: response.data);
      print('profile percentage');
    } else {
      print("percentage Error 1");
    }
    return itemsData;
  } catch (e) {
    print("error${e}");
    return itemsData;
  }
}