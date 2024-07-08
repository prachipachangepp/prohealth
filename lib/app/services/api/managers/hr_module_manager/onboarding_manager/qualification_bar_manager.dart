import 'package:flutter/cupertino.dart';
import 'package:prohealth/app/services/api/api.dart';
import 'package:prohealth/app/services/api/repository/hr_module_repository/onboarding/onboarding_qualification.dart';
import 'package:prohealth/data/api_data/hr_module_data/onboarding_data/onboarding_qualification_data.dart';

Future<List<OnboardingQualificationData>> getOnboardingQualificationEmp(
BuildContext context, int employeeId) async{
  List<OnboardingQualificationData> itemData = [];
  try{
    final response = await Api(context).get(path:
    OnboardingQualificationRepo.getEmpEmploymentHistories(employeeid: employeeId));
    if(response.statusCode == 200 || response.statusCode == 201){
      for(var item in response.data){
        itemData.add(OnboardingQualificationData(
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
            approve: item['approved']));
      }
    }else {
      print("References List");
    }
    return itemData;

  }catch (e) {
    print("error${e}");
    return itemData;
  }
}