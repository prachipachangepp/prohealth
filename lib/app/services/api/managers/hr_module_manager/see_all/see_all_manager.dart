import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prohealth/app/services/api/api.dart';
import 'package:prohealth/app/services/api/repository/hr_module_repository/see_all/see_all.dart';
import 'package:prohealth/app/services/token/token_manager.dart';
import 'package:prohealth/data/api_data/hr_module_data/see_all_data/see_all_data.dart';

///see all get

Future<List<SeeAllData>> getEmployeeSeeAll(BuildContext context) async {
  List<SeeAllData> itemsData = [];
  String convertIsoToDayMonthYear(String isoDate) {
    DateTime dateTime = DateTime.parse(isoDate);
    DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    String formattedDate = dateFormat.format(dateTime);
    return formattedDate;
  }

  try{
    final compID = await TokenManager.getCompanyId();
    final response = await Api(context).get(path:
    SeeAllRepository.getEmpSeeAll(compId: compID));
    if(response.statusCode == 200 || response.statusCode == 201){
      for(var item in response.data){
        String DOB = convertIsoToDayMonthYear(item['dateOfBirth']);
      itemsData.add(SeeAllData(
        empId: item['employeeId'],
        companyId: compID,
        code: item['code'],
        userID: item['userId'],
        firstName: item['firstName'],
        lastName: item['lastName'],
        deptId: item['departmentId'],
        empTypeId: item['employeeTypeId'],
        cityID: item['cityId'],
        countryId: item['countryId'],
        zoneId: item['zoneId'],
        ssnnbr: item['SSNNbr'] ?? '--',
        expertise: item['expertise'] ?? '--',
        primaryPhoneNbr: item['primaryPhoneNbr'] ?? '--',
        secondryPhoneNbr: item['secondryPhoneNbr'],
        workPhoneNbr: item['workPhoneNbr'],
        regOfficId: item['regOfficId'],
        personalEmail: item['personalEmail'] ?? '--',
        workEmail: item['workEmail'],
        dateOfBirth: DOB,
        emergencyContact: item['emergencyContact'],
        employment: item['employment'] ?? '--',
        covreage: item['covreage'],
        gender: item['gender'],
        status: item['status'],
        service: item['service'],
        imgurl: item['imgurl'],
        resumeurl: item['resumeurl'],
        onboardingStatus: item['onboardingStatus'],
        driverLicenseNum: item['driverLicenceNbr'] ?? '--',
        createdAt: item['createdAt'],
        dateofTermination: item['dateofTermination'],
        dateofResignation: item['dateofResignation'],
        dateofHire: item['dateofHire'],
        rehirable: item['rehirable'],
        position: item['position'],
        finalAddress: item['finalAddress']?? '--',
        type: item['type']?? '--',
        reason: item['reason'],
        finalPayCheck: item['finalPayCheck']?? '--',
        checkDate: item['checkDate'],
        grossPay: item['grossPay'] ?? '--',
        netPay: item['netPay']?? '--',
        methods: item['methods'] ?? '--',
        materials: item['materials'] ?? '--',
        race: item['race'] ?? '--',
        approved: item['approved'] ?? false,
        signatureURL: item['signatureURL'],
        city: item['city'] ?? '--',
        employeeType: item['employeeType']?? '--',
        department: item['department'] ?? '--',
        country: item['country']?? '--',
        county: item['county']?? '--',
        zone: item['zone']?? '--',
        profileScorePercentage: item['profileScorePercentage'],

      ));
      }
    }else {
      print("Employment List");
    }
    return itemsData;
  } catch (e) {
    print("error${e}");
    return itemsData;
  }
}
