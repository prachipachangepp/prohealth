import 'package:flutter/material.dart';
import 'package:prohealth/app/services/api/api.dart';
import 'package:prohealth/app/services/api/repository/establishment_manager/establishment_repository.dart';
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