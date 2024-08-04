import 'package:flutter/material.dart';
import 'package:prohealth/app/services/api/api.dart';
import 'package:prohealth/app/services/api/repository/hr_module_repository/onboarding/onboarding_qualification.dart';
import 'package:prohealth/data/api_data/hr_module_data/onboarding_data/onboarding_banking_data.dart';

Future<List<OnboardingBankingData>> getOnboardingBanking(
BuildContext context, int employeeId, String approveOnly) async{
  List<OnboardingBankingData> itemsData = [];
  try{
    final response = await Api(context).get(path:
    OnboardingQualificationRepo.getOnboardBanking(employeeid: employeeId, approveOnly: approveOnly));
    if(response.statusCode == 200 || response.statusCode == 201){
      for(var item in response.data){
        itemsData.add(OnboardingBankingData(
            empBankId: item['empBankingId'],
            accNum: item['accountNumber'],
            empId:  item['employeeId'],
            bankName:  item['bankName'],
            amtRequested:  item['amountRequested'],
            checkUrl:  item['checkUrl'],
            effectiveDate:  item['effectiveDate'],
            rountingNumber:  item['routingNumber'],
            type:  item['type'],
            approved:  item['approved'] ?? false,
        requestedPercentage: item['requestedPercentage']));
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


///bybankid
Future<List<OnboardingBankingData>> getOnboardingBankingID(
    BuildContext context, int empBankingId) async{
  List<OnboardingBankingData> itemsData = [];
  try{
    final response = await Api(context).get(path:
    OnboardingQualificationRepo.getBankBYBankId(empBankingId: empBankingId));
    if(response.statusCode == 200 || response.statusCode == 201){
      for(var item in response.data){
        itemsData.add(OnboardingBankingData(
            empBankId: item['empBankingId'],
            accNum: item['accountNumber'],
            empId:  item['employeeId'],
            bankName:  item['bankName'],
            amtRequested:  item['amountRequested'],
            checkUrl:  item['checkUrl'],
            effectiveDate:  item['effectiveDate'],
            rountingNumber:  item['routingNumber'],
            type:  item['type'],
            approved:  item['approved'] ?? false,
            requestedPercentage: item['requestedPercentage']));
      }
    }else {
      print("Banking List By Id");
    }
    return itemsData;
  } catch (e) {
    print("error${e}");
    return itemsData;
  }
}