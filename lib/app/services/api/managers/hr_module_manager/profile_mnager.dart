import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prohealth/app/services/api/api.dart';
import 'package:prohealth/app/services/api/repository/establishment_manager/establishment_repository.dart';
import 'package:prohealth/app/services/api/repository/hr_module_repository/profile_repo.dart';
import 'package:prohealth/app/services/token/token_manager.dart';
import 'package:prohealth/data/api_data/api_data.dart';
import 'package:prohealth/data/api_data/hr_module_data/employee_profile/search_profile_data.dart';
import 'package:prohealth/data/api_data/hr_module_data/profile_editor/profile_editor.dart';

import '../../repository/establishment_manager/all_from_hr_repository.dart';

/// Search by Text
/// get api
Future<List<SearchEmployeeProfileData>> getSearchProfileByText(
    BuildContext context, String searchText) async {
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
    final companyId = await TokenManager.getCompanyId();
    final response = await Api(context).get(
        path: ProfileRepository.searchEmployeeProfileByText(
            companyId: companyId, searchText: searchText));

    if (response.statusCode == 200 || response.statusCode == 201) {
      for (var item in response.data) {
        print("//");
        print(item);
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
            rehirable: item['rehirable'] ?? "--",
            finalAddress: item['finalAddress'] ?? '--',
            type: item['type'] ?? '--',
            reason: item['reason'] ?? '--',
            finalPayCheck: item['finalPayCheck'] != null
                ? item['finalPayCheck'].toDouble()
                : 0.0,
            checkDate: item['checkDate'] ?? '--',
            grossPay:
                item['grossPay'] != null ? item['grossPay'].toDouble() : 0.0,
            netPay: item['netPay'] != null ? item['netPay'].toDouble() : 0.0,
            methods: item['methods'] ?? '--',
            materials: item['materials'] ?? '--',
            dateofHire: item['dateofHire'] ?? "--",
            position: item['position'] ?? '--',
            driverLicenceNbr: item['driverLicenceNbr'] ?? '--',
            race: item['race'] ?? '--',
            rating: item["rating"] ?? '--'));
      }

      print("search data by Text${itemsData}");
    } else {
      print(response);
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
    final response = await Api(context).get(
        path: ProfileRepository.searchEmployeeProfileById(
            companyId: companyId, Id: employeeTypeId));
    if (response.statusCode == 200 || response.statusCode == 201) {
      for (var item in response.data) {
        String DateOfBirth = convertIsoToDayMonthYear(item['dateOfBirth']);
        String CreatedAt = convertIsoToDayMonthYear(item['createdAt']);
        String TerminationDate =
            convertIsoToDayMonthYear(item['dateofTermination']);
        String ReginationDate =
            convertIsoToDayMonthYear(item['dateofResignation']);
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
          finalPayCheck: item['finalPayCheck'] != null
              ? item['finalPayCheck'].toDouble()
              : 0.0,
          checkDate: CheckDate,
          grossPay:
              item['grossPay'] != null ? item['grossPay'].toDouble() : 0.0,
          netPay: item['netPay'] != null ? item['netPay'].toDouble() : 0.0,
          methods: item['methods'] ?? '--',
          materials: item['materials'] ?? '--',
          dateofHire: HireDate,
          position: item['position'] ?? '--',
          driverLicenceNbr: item['driverLicenceNbr'] ?? '--',
          race: item['race'] ?? '--',
          rating: item['rating'] ?? '--',
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
    DateFormat dateFormat = DateFormat('yyyy-MM-dd');

    // Format the date into "dd mm yy" format
    String formattedDate = dateFormat.format(dateTime);

    return formattedDate;
  }

  var itemsData;
  try {
    final response = await Api(context).get(
        path: ProfileRepository.searchByEmployeeIdProfile(
      employeeId: employeeId,
    ));
    print("Getting response");
    print("Search response ::: ${response}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      String DOB = convertIsoToDayMonthYear(response.data['dateOfBirth']);
      String hireDate = convertIsoToDayMonthYear(response.data['dateofHire']);
      itemsData = SearchByEmployeeIdProfileData(
        employeeId: response.data['employeeId'] ?? 0,
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
        dateOfBirth: DOB ?? "--",
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
        dateofHire: hireDate ?? "--",
        rehirable: response.data['rehirable'] ?? "--",
        position: response.data['position'] ?? '--',
        finalAddress: response.data['finalAddress'] ?? '--',
        type: response.data['type'] ?? '--',
        reason: response.data['reason'] ?? '--',
        finalPayCheck: response.data['finalPayCheck'] != null
            ? response.data['finalPayCheck'].toDouble()
            : 0.0,
        checkDate: response.data['checkDate'] ?? "--",
        grossPay: response.data['grossPay'] != null
            ? response.data['grossPay'].toDouble()
            : 0.0,
        netPay: response.data['netPay'] != null
            ? response.data['netPay'].toDouble()
            : 0.0,
        methods: response.data['methods'] ?? '--',
        materials: response.data['materials'] ?? '--',
        city: response.data['city'] ?? '--',
        employeeType: response.data['employeeType'] ?? '--',
        department: response.data['department'] ?? '--',
        country: response.data['country'] ?? '--',
        zone: response.data['zone'] ?? '--',
        race: response.data['race'] ?? '--',
        profileScorePercentage: response.data['profileScorePercentage'] != null
            ? response.data['profileScorePercentage'].toDouble()
            : 0.0,
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
    final response = await Api(context).get(
        path: ProfileRepository.getPercentage(
      employeeId: employeeId,
    ));
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


Future<ApiData> getEmployeeEdit({
  required BuildContext context,
  required int employeeId,
  required String code,
  required int userId,
  required String firstName,
  required String lastName,
  required int departmentId,
  required int employeeTypeId,
  required String expertise,
  required int cityId,
  required int countryId,
  required int countyId,
  required int zoneId,
  required String SSNNbr,
  required String primaryPhoneNbr,
  required String secondryPhoneNbr,
  required String workPhoneNbr,
  required String regOfficId,
  required String personalEmail,
  required String workEmail,
  required String address,
  required String dateOfBirth,
  required String emergencyContact,
  required String covreage,
  required String employment,
  required String gender,
  required String status,
  required String service,
  required String imgurl,
  required String resumeurl,
  // required int companyId,
  required String onboardingStatus,
  required String driverLicenceNbr,
  required String dateofTermination,
  required String dateofResignation,
  required String dateofHire,
  required String rehirable,
  required String position,
  required String finalAddress,
  required String type,
  required String reason,
  required int finalPayCheck,
  required String checkDate,
  required int grossPay,
  required int netPay,
  required String methods,
  required String materials,
  required String race,
  required String rating,
  required String signatureURL,
}) async {
  try {
    final companyId = await TokenManager.getCompanyId();
    final data = {
      'code' : code,
      'userId' : userId,
      'firstName' : firstName,
      'lastName' : lastName,
      'departmentId' : departmentId,
      'employeeTypeId' : employeeTypeId,
      'expertise' : expertise,
      'cityId' : cityId,
      'countryId' : countryId,
      'countyId' : countyId,
      'zoneId' : zoneId,
      'SSNNbr' : SSNNbr,
      'primaryPhoneNbr' : primaryPhoneNbr,
      'secondryPhoneNbr' : secondryPhoneNbr,
      'workPhoneNbr' : workPhoneNbr,
      'regOfficId' : regOfficId,
      'personalEmail' : personalEmail,
      'workEmail' : workEmail,
      'address' : address,
      'dateOfBirth' : dateOfBirth,
      'emergencyContact' : emergencyContact,
      'covreage': covreage,
      'employment' : employment,
      'gender' : gender,
      'status' : status,
      'service' : service,
      'imgurl' : imgurl,
      'resumeurl' : resumeurl,
      'companyId' : companyId,
      'onboardingStatus' : onboardingStatus,
      'driverLicenceNbr' : driverLicenceNbr,
      'dateofTermination' : dateofTermination,
      'dateofResignation' : dateofResignation,
      'dateofHire' : dateofHire,
      'rehirable' : rehirable,
      'position' : position,
      'finalAddress' : finalAddress,
      'type' : type,
      'reason': reason,
      'finalPayCheck' : finalPayCheck,
      'checkDate' : checkDate,
      'grossPay' : grossPay,
      'netPay' : netPay,
      'methods' : methods,
      'materials' : materials,
      'race' : race,
      'rating' : rating,
      'signatureURL' : signatureURL,
    };

    print("Data payload being sent to API: $data");

    final response = await Api(context).patch(
      path: EstablishmentManagerRepository.employeeEditGet(employeeId: employeeId),
      data: data,
    );

    print(response);
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Employees updated successfully");
      // Show success popup
      return ApiData(statusCode: response.statusCode!, success: true, message: response.statusMessage!);

    } else {
      print("Failed to update Employees: ${response.statusCode}");

      print("Error details: ${response.data}");
      return ApiData(statusCode: response.statusCode!, success: false, message: response.statusMessage!);

      // showDialog(
      //     context: context,
      //     builder: (BuildContext context) {
      //       return AlertDialog(
      //         title: Text('Error'),
      //         content: Text('An error occurred. Please try again.'),
      //         actions: [
      //           TextButton(
      //             onPressed: () {
      //               Navigator.of(context).pop(); // Close the dialog
      //             },
      //             child: Text('Try Again'),
      //           ),
      //         ],
      //       );});
    }
  } catch (e) {
    print("Error: $e");
    return ApiData(statusCode: 500, success: false, message: "Server error");
  }
}


/// get prefill API  Employees
Future<ProfileEditorModal> getEmployeePrefill(
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
  var itemsList;
  final companyId = await TokenManager.getCompanyId();
  try {

    final response = await Api(context).get(
        path: EstablishmentManagerRepository.employeePrefillPatch(
            employeeId: employeeId));
    if (response.statusCode == 200 || response.statusCode == 201) {
      String dateOfBirth = convertIsoToDayMonthYear(response.data['dateOfBirth']);
      itemsList = ProfileEditorModal(
        employeeId: response.data['employeeId'] ?? 0,
        code: response.data['code'] ?? '',
        userId: response.data['userId'] ?? 0,
        firstName: response.data['firstName'] ?? '',
        lastName: response.data['lastName'] ?? '',
        departmentId: response.data['departmentId'] ?? 0,
        employeeTypeId: response.data['employeeTypeId'] ?? 0,
        cityId: response.data['cityId'] ?? 0,
        countryId: response.data['countryId'] ?? 0,
        // countyId: response.data['countyId'],
        zoneId: response.data['zoneId'] ?? 0,
        SSNNbr: response.data['SSNNbr'] ?? '',
        primaryPhoneNbr: response.data['primaryPhoneNbr'] ?? '',
        secondryPhoneNbr: response.data['secondryPhoneNbr'] ?? '',
        workPhoneNbr: response.data['workPhoneNbr'] ?? '',
        regOfficId: response.data['regOfficId'] ?? '',
        personalEmail: response.data['personalEmail'] ?? '',
        workEmail: response.data['workEmail'] ?? '',
        dateOfBirth: dateOfBirth ?? '',
        emergencyContact: response.data['emergencyContact'] ?? '',
        covreage: response.data['covreage'] ?? '',
        employment: response.data['employment'] ?? '',
        gender: response.data['gender'] ?? '',
        status: response.data['status'] ?? '',
        service: response.data['service'] ?? '',
        imgurl: response.data['imgurl'] ?? '',
        resumeurl: response.data['resumeurl'] ?? '',

        onboardingStatus: response.data['onboardingStatus'] ?? '',
        driverLicenceNbr: response.data['driverLicenceNbr'] ?? '',
        createdAt: response.data['createdAt'] ?? '',
        dateofTermination: response.data['dateofTermination'] ?? null,
        dateofResignation: response.data['dateofResignation'] ?? null,
        dateofHire: response.data['dateofHire'] ?? '',
        rehirable: response.data['rehirable'] ?? '',
        position: response.data['position'] ?? '',
        finalAddress: response.data['finalAddress'] ?? '',
        type: response.data['type'] ?? '',
        reason: response.data['reason'] ?? '',
        finalPayCheck: response.data['finalPayCheck'] ?? '',
        checkDate: response.data['checkDate'] ?? '',
        grossPay: response.data['grossPay'] ?? 0,
        netPay: response.data['netPay'] ?? 0,
        methods: response.data['methods'] ?? '',
        materials: response.data['materials'] ?? '',
        race: response.data['race'] ?? '',
        signatureURL: response.data['signatureURL'] ?? '',
        companyId: response.data['companyId'] ?? 0,
        rating: response.data['rating'] ?? '',
        city: response.data['city'] ?? '',
        employeType: response.data['employeType'] ?? '',
        department: response.data['department'] ?? '',
        country: response.data['country'] ?? '',
        county: response.data['county'] ?? '',
        zone: response.data['zones'] ?? '',
        profileScorePercentage: response.data['profileScorePercentage'] ?? 0,
        message: response.statusMessage!,
        success: '', employeeEnrollId: response.data['employeeEnrollId']??0,
      );
      print('${response.data}');
      print("User Prefilled by Get: $itemsList");
    } else {
      print('User Data Error');
    }
    return itemsList;
  } catch (e) {
    print("Error $e");
    return itemsList;
  }
}

Future<List<EmployeeTypeModal>> EmployeeTypeGet(BuildContext context, int departmentId,  ) async {
  List<EmployeeTypeModal> itemsList = [];
  try {
    final response = await Api(context).get(path:  EstablishmentManagerRepository.getEmployeeType(departmentId: departmentId));

    if (response.statusCode == 200 || response.statusCode == 201) {
      for (var item in response.data) {
        // Add the employee type to the list
        itemsList.add(
          EmployeeTypeModal(
            employeeTypeId: item['employeeTypeId'],
            DepartmentId: item['DepartmentId'],
            employeeType: item['employeeType'],
            color: item['color'],
            abbreviation: item['abbreviation'],
          ),
        );
      }
    } else {
      print('API Error: ${response.statusCode}');
    }

    print("Response:::::${response.data}"); // Debug the response to see what you're getting
    return itemsList;
  } catch (e) {
    print("Error: $e");
    return itemsList; // Return empty list on error
  }
}

///county wise zone Get API

Future<List<CountyWiseZoneModal>> fetchCountyWiseZone(BuildContext context,
    int countyId,) async {
  List<CountyWiseZoneModal> itemsList = [];
  try {
    final response = await Api(context).get(path:
    ProfileRepository.getCountyWiseZone(
       countyId: countyId));

    if (response.statusCode == 200 || response.statusCode == 201) {
      for (var item in response.data) {
        itemsList.add(
          CountyWiseZoneModal(
              zone_id: item['zone_id'],
              county_id: item['county_id'],
              zoneName: item['zoneName'],
              companyId: item['companyId'],
              officeId: item['officeId'])

          );
      }
    } else {
      print('County Wise Zone API Error: ${response.statusCode}');
    }

    print("Response:::::${response.data}");
    return itemsList;
  } catch (e) {
    print("Error: $e");
    return itemsList; // Return empty list on error
  }
}
