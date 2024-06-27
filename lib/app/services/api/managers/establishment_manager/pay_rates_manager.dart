import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/services/api/api.dart';
import 'package:prohealth/app/services/api/repository/establishment_manager/establishment_repository.dart';
import 'package:prohealth/data/api_data/api_data.dart';
import 'package:prohealth/data/api_data/establishment_data/pay_rates/pay_rates_finance_data.dart';

Future<List<PayRateFinanceData>> payRatesDataGet(
    BuildContext context,int companyId,int empTypeId,int pageNo,int noOfRows,  ) async {
  List<PayRateFinanceData> itemsData = [];
  try {
    final response = await Api(context)
        .get(path: EstablishmentManagerRepository.payRatesSetupGet(pageNo: pageNo, noOfRows: noOfRows, empTypeId: empTypeId, companyId: companyId));
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(":::::LIST${response.data}");
      for (var item in response.data) {
        itemsData.add(
            PayRateFinanceData(
            department: item['department']== null ? "--" :item['department'],
            employeeType: item['employeeType']== null ? "--" :item['employeeType'],
            abbreviation: item['abbreviation']== null ? "--" :item['abbreviation'],
            payRates: item['payrates']== null ? "--" :item['payrates'],
            zoneId: item['zoneId']== null ? "--" :item['zoneId'],
            departmentId: item['departmentId']== null ? "--" :item['departmentId'],
            employeeTypeId: item['employeeTypeId']== null ? "--" :item['employeeTypeId'],
            typeOfVisitId: item['typeOfVisitId']== null ? "--" :item['typeOfVisitId'],
            typeVisit: item['typeOfVisit']== null ? "--" :item['typeOfVisit'],
            zone: item['zone'] == null ? "--" :item['zone'], payRatesSetupId: item['PayratesSetupId']== null ? "--" :item['PayratesSetupId']));
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
/// Get pre fill api
Future<PayRatePrefillFinanceData> payPrefillRatesDataGet(
    BuildContext context,int payRatesId) async {
  var itemsData;
  try {
    final response = await Api(context)
        .get(path: EstablishmentManagerRepository.updatePayRatesSetup(payRatesId: payRatesId));
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(":::::LIST${response.data}");
        itemsData =
            PayRatePrefillFinanceData(
                department: response.data['department']== null ? "--" :response.data['department'],
                employeeType: response.data['employeeType']== null ? "--" :response.data['employeeType'],
                abbreviation: response.data['abbreviation']== null ? "--" :response.data['abbreviation'],
                payRates: response.data['payrates']== null ? "--" :response.data['payrates'],
                zoneId: response.data['zoneId']== null ? "--" :response.data['zoneId'],
                departmentId: response.data['departmentId']== null ? "--" :response.data['departmentId'],
                employeeTypeId: response.data['employeeTypeId']== null ? "--" :response.data['employeeTypeId'],
                typeOfVisitId: response.data['typeOfVisitId']== null ? "--" :response.data['typeOfVisitId'],
                typeVisit: response.data['typeOfVisit']== null ? "--" :response.data['typeOfVisit'],
                zone: response.data['zone'] == null ? "--" :response.data['zone'], payRatesSetupId: response.data['PayratesSetupId']== null ? "--" :response.data['PayratesSetupId']) ;

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
    BuildContext context, int deptId, int empTypeId,int typeOfVisitId, int zoneId, int payRates, int companyId) async {
  try {
    var response = await Api(context).post(
        path: EstablishmentManagerRepository.
        payRatesSetupPost(),
        data: {
          'departmentId': deptId,
          'employeeTypeId': empTypeId,
          'typeOfVisitId':typeOfVisitId,
          'zoneId':zoneId,
          'payrates':payRates,
          'companyId':companyId
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
/// Update pay rates
Future<ApiData> updatePayRatesSetupPost(
    BuildContext context, int deptId, int empTypeId,int typeOfVisitId, int zoneId, int payRates, int companyId, int payRatesId) async {
  try {
    var response = await Api(context).patch(
        path: EstablishmentManagerRepository.
        updatePayRatesSetup(payRatesId: payRatesId),
        data: {
          'departmentId': deptId,
          'employeeTypeId': empTypeId,
          'typeOfVisitId':typeOfVisitId,
          'zoneId':zoneId,
          'payrates':payRates,
          'companyId':companyId
        });
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Pay Rates updates");
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

/// Delete pay rates setup PATCH
Future<ApiData> deletePayRatesSetupPost(
    BuildContext context,int payRatesId,) async {
  try {
    var response = await Api(context).delete(path: EstablishmentManagerRepository.deletePayRatesSetup(payRatesId: payRatesId));
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Pay Rates Deleted");
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