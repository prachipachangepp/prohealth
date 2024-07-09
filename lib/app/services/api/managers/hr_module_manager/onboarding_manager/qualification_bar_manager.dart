import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:prohealth/app/services/api/api.dart';
import 'package:prohealth/app/services/api/repository/hr_module_repository/onboarding/onboarding_qualification.dart';
import 'package:prohealth/data/api_data/hr_module_data/onboarding_data/onboarding_qualification_data.dart';

///get onboarding qualification employement
Future<List<OnboardingQualificationEmploymentData>> getOnboardingQualificationEmp(
BuildContext context, int employeeId) async{
  List<OnboardingQualificationEmploymentData> itemData = [];
  try{
    final response = await Api(context).get(path:
    OnboardingQualificationRepo.getEmpEmploymentHistories(employeeid: employeeId));
    if(response.statusCode == 200 || response.statusCode == 201){
      for(var item in response.data){
        itemData.add(OnboardingQualificationEmploymentData(
            employmentId: item['employmentId'],
            empId: item['employeeId'],
            employer: item['employer'],
            city: item['city'],
            reason: item['reason'],
            supervisor: item['supervisor'],
            supMobile: item['supMobile'],
            title: item['title'],
            dateOfJoin: item['dateOfJoining'],
            endDate: item['endDate'],
            approve: item['approved'] ?? false));
      }
    }else {
      print("Employment List");
    }
    return itemData;

  }catch (e) {
    print("error${e}");
    return itemData;
  }
}

///get onboarding qualification education
Future<List<OnboardingQualificationEducationData>> getOnboardingQualificationEducation(
    BuildContext context, int employeeId) async{
  List<OnboardingQualificationEducationData> itemData = [];
  try{
    final response = await Api(context).get(path:
    OnboardingQualificationRepo.getEmpEducation(employeeid: employeeId));
    if(response.statusCode == 200 || response.statusCode == 201){
      for(var item in response.data){
        itemData.add(OnboardingQualificationEducationData(
            educationId: item['educationId'],
            empId: item['employeeId'],
            graduate: item['graduate'],
            degree: item['degree'],
            major: item['major'],
            city: item['city'],
            college: item['college'],
            phone: item['phone'],
            state: item['state'],
            approved: item['approved'] ?? false,));
      }
    }else {
      print("Education List");
    }
    return itemData;

  }catch (e) {
    print("error${e}");
    return itemData;
  }
}


///get onboarding qualification referance
Future<List<OnboardingQualificationReferanceData>> getOnboardingQualificationReference(
    BuildContext context, int employeeId) async{
  List<OnboardingQualificationReferanceData> itemData = [];
  try{
    final response = await Api(context).get(path:
    OnboardingQualificationRepo.getEmpReference(employeeid: employeeId));
    if(response.statusCode == 200 || response.statusCode == 201){
      for(var item in response.data){
        itemData.add(OnboardingQualificationReferanceData(
            referenceId: item['referenceId'],
            empId: item['employeeId'],
            association: item['association'],
            comment: item['comment'],
            company: item['company'],
            email: item['email'],
            mob: item['mob'],
            name: item['name'],
            references: item['references'],
            title: item['title'],
            approve: item['approve'] ?? false));
      }
    }else {
      print("Reference List");
    }
    return itemData;

  }catch (e) {
    print("error${e}");
    return itemData;
  }
}

///get onboarding qualification license
Future<List<OnboardingQualificationLicenseData>> getOnboardingQualificationLicense(
    BuildContext context, int employeeId) async{
  String convertIsoToDayMonthYear(String isoDate) {
    // Parse ISO date string to DateTime object
    DateTime dateTime = DateTime.parse(isoDate);

    // Create a DateFormat object to format the date
    DateFormat dateFormat = DateFormat('dd MMM yyyy');

    // Format the date into "dd mm yy" format
    String formattedDate = dateFormat.format(dateTime);

    return formattedDate;
  }
  List<OnboardingQualificationLicenseData> itemData = [];
  try{
    final response = await Api(context).get(path:
    OnboardingQualificationRepo.getEmpLicense(employeeid: employeeId));
    if(response.statusCode == 200 || response.statusCode == 201){
      for(var item in response.data){
        String expFormattedDate = convertIsoToDayMonthYear(item['expDate']);
        String issueFormattedDate = convertIsoToDayMonthYear(item['issueDate']);
        itemData.add(OnboardingQualificationLicenseData(
            licenseId: item['licenseId'],
            employeeId: item['employeeId'],
            country: item['country'],
            expDate: item['expDate'],
            issueDate: item['issueDate'],
            licenseUrl: item['licenseUrl'],
            licensure: item['licensure'],
            licenseNumber: item['licenseNumber'],
            org: item['org'],
            documentType: item['documentType'],
            approve: item['approved'] ?? false,
          sucess: true, message: response.statusMessage!,
           ));
      }
    }else {
      print("License List");
    }
    return itemData;

  }catch (e) {
    print("error${e}");
    return itemData;
  }
}