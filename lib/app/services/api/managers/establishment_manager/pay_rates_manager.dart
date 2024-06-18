import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/services/api/api.dart';
import 'package:prohealth/app/services/api/repository/establishment_manager/establishment_repository.dart';
import 'package:prohealth/data/api_data/api_data.dart';
import 'package:prohealth/data/api_data/establishment_data/pay_rates/pay_rates_finance_data.dart';

Future<List<PayRateFinanceData>> payRatesDataGet(
    BuildContext context,int pageNo,int noOfRows) async {
  List<PayRateFinanceData> itemsData = [];
  try {
    final response = await Api(context)
        .get(path: EstablishmentManagerRepository.payRatesSetupGet(pageNo: pageNo, noOfRows: noOfRows));
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(":::::LIST${response.data}");
      for (var item in response.data) {
        itemsData.add(
            PayRateFinanceData(
            department: item['department'],
            employeeType: item['employeeType'],
            abbreviation: item['abbreviation'],
            payRates: item['payrates'],
            zoneId: item['zoneId'],
            departmentId: item['departmentId'],
            employeeTypeId: item['employeeTypeId'],
            typeOfVisitId: item['typeOfVisitId'],
            typeVisit: item['typeOfVisit'],
            zone: item['zone'] == null ? "Null" :item['zone']));
      }
    } else {
      print("Api Pay rates Data Error");
    }
    return itemsData;
  } catch (e) {
    print("error${e}");
    return itemsData;
  }
}

/// Add pay rates setup POST
Future<ApiData> addPayRatesSetupPost(
    BuildContext context, int deptId, int empTypeId,int typeOfVisitId, int zoneId, int payRates) async {
  try {
    var response = await Api(context).post(
        path: EstablishmentManagerRepository.payRatesSetupPost(),
        data: {
          'departmentId': deptId,
          'employeeTypeId': empTypeId,
          'typeOfVisitId':typeOfVisitId,
          'zoneId':zoneId,
          'payrates':payRates
        });
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Pay Rates added");
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
    print("Error 2");
    return ApiData(
        statusCode: 404, success: false, message: AppString.somethingWentWrong);
  }
}