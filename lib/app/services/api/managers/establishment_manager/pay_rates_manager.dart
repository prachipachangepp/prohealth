import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/services/api/api.dart';
import 'package:prohealth/app/services/api/repository/establishment_manager/establishment_repository.dart';
import 'package:prohealth/app/services/token/token_manager.dart';
import 'package:prohealth/data/api_data/api_data.dart';
import 'package:prohealth/data/api_data/establishment_data/pay_rates/pay_rates_finance_data.dart';

// Future<List<PayRateFinanceData>> payRatesDataGet(
//   BuildContext context,
//   int empTypeId,
//   int pageNo,
//   int noOfRows,
// ) async {
//   List<PayRateFinanceData> itemsData = [];
//   try {
//     final companyId = await TokenManager.getCompanyId();
//     final response = await Api(context).get(
//         path: EstablishmentManagerRepository.payRatesSetupGet(
//             pageNo: pageNo,
//             noOfRows: noOfRows,
//             empTypeId: empTypeId,
//             companyId: companyId));
//     if (response.statusCode == 200 || response.statusCode == 201) {
//       print(":::::LIST${response.data}");
//       for (var item in response.data) {
//         itemsData.add(PayRateFinanceData(
//             department: item['department'] ?? "--",
//             employeeType: item['employeeType'] ?? "--",
//             abbreviation: item['abbreviation'] ?? "--",
//             payRates: item['payrates'] ?? 0,
//             zoneId: item['zoneId'] ?? 0,
//             departmentId: item['departmentId'] ?? 0,
//             employeeTypeId: item['employeeTypeId'] ?? 0,
//             typeOfVisitId: item['typeOfVisitId'] ?? 0,
//             typeVisit: item['typeOfVisit'] ?? "--",
//             zone: item['zone'] ?? "--",
//             payRatesSetupId: item['PayratesSetupId'] ?? 0,
//             permile: item['permiles'] ?? 0));
//       }
//     } else {
//       print("Api Pay rates Data Error");
//     }
//     return itemsData;
//   } catch (e) {
//     print("error${e}");
//     return itemsData;
//   }
// }
///get api payrate

Future<List<PayRate>> newPayRatesDataGet(
  BuildContext context,
) async {
  List<PayRate> itemsData = [];
  try {
    final companyId = await TokenManager.getCompanyId();
    final response = await Api(context)
        .get(path: EstablishmentManagerRepository.getPayrates());

    if (response.statusCode == 200 || response.statusCode == 201) {
      print(":::::LIST${response.data}");
      //   for (var item in response.data) {
      //     itemsData.add(PayRate(
      //         payratesId: item['payratesId'] ?? "--",
      //         ZoneId: item['ZoneId'] ?? "--",
      //         rate: item['rate'] ?? "--",
      //         typeOfVisitId: item['typeOfVisitId'] ?? "--",
      //         perMile: item['perMile'] ?? "--",
      //         serviceTypeId: item['serviceTypeId'] ?? "--"));
      //   }
      // } else {
      //   print("Api Pay rates Data Error");
      // }

      List<dynamic> jsonData = response.data;
      itemsData = jsonData.map((item) => PayRate.fromJson(item)).toList();
    } else {
      print("Api Pay rates Data Error");
    }
  } catch (e) {
    print("error${e}");
  }

  return itemsData;
}

/// Get pre fill api
Future<PayRatePrefillFinanceData> payPrefillRatesDataGet(
    BuildContext context, int payRatesId) async {
  var itemsData;
  try {
    final companyId = await TokenManager.getCompanyId();
    final response = await Api(context).get(
        path: EstablishmentManagerRepository.updatePayRatesSetup(
            payRatesId: payRatesId));
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(":::::LIST${response.data}");
      itemsData = PayRatePrefillFinanceData(
          department: response.data['department'] ?? "--",
          employeeType: response.data['employeeType'] ?? "--",
          abbreviation: response.data['abbreviation'] ?? "--",
          payRates: response.data['rates'] ?? 0,
          zoneId: response.data['zoneId'] ?? 0,
          departmentId: response.data['departmentId'] ?? 0,
          employeeTypeId: response.data['employeeTypeId'] ?? 0,
          typeOfVisitId: response.data['typeOfVisitId'] ?? 0,
          typeVisit: response.data['typeOfVisit'] ?? "--",
          perMiles: response.data['permile'] ?? 0,
          zone: response.data['zone'] ?? "--",
          payRatesSetupId: response.data['PayratesSetupId'] ?? 0);
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
  BuildContext context,
  int deptId,
  int empTypeId,
  int permile,
  int typeOfVisitId,
  int zoneId,
  int payRates,
) async {
  try {
    final companyId = await TokenManager.getCompanyId();
    var response = await Api(context)
        .post(path: EstablishmentManagerRepository.payRatesSetupPost(), data: {
      'departmentId': deptId,
      'employeeTypeId': empTypeId,
      'typeOfVisitId': typeOfVisitId,
      'zoneId': zoneId,
      'rates': payRates,
      'permile': permile,
      'companyId': companyId
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
    BuildContext context,
    int deptId,
    int empTypeId,
    int permile,
    int typeOfVisitId,
    int zoneId,
    int payRates,
    int payRatesId) async {
  try {
    final companyId = await TokenManager.getCompanyId();
    var response = await Api(context).patch(
        path: EstablishmentManagerRepository.updatePayRatesSetup(
            payRatesId: payRatesId),
        data: {
          'departmentId': deptId,
          'employeeTypeId': empTypeId,
          'typeOfVisitId': typeOfVisitId,
          'zoneId': zoneId,
          'rates': payRates,
          'permile': permile,
          'companyId': companyId
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
  BuildContext context,
  int payRatesId,
) async {
  try {
    var response = await Api(context).delete(
        path: EstablishmentManagerRepository.deletePayRatesSetup(
            payRatesId: payRatesId));
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

///zone sort by dropdown
Future<List<SortByZoneData>> PayRateZoneDropdown(
    BuildContext context,) async {
  List<SortByZoneData> itemsList = [];
  try {
    final companyID = await TokenManager.getCompanyId();
    final response = await Api(context).get(
        path: EstablishmentManagerRepository.getzonedropdown(
            companyID: companyID));
    if (response.statusCode == 200 || response.statusCode == 201) {
      for (var item in response.data) {
        itemsList.add(
          SortByZoneData(
            zoneId: item['zone_id'] ?? 0,
            zoneName: item['zoneName'] ?? "--",
           ),
        );
        print(" payrates dropdown$response");
      }
    } else {
      print('Api Error');
    }
    print("Response:::::${response}");
    return itemsList;
  } catch (e) {
    print("Error $e");
    return itemsList;
  }
}

///serviceby dropdown
Future<List<ServiceData>> PayRateServiceDropdown(
    BuildContext context,) async {
  List<ServiceData> itemsList = [];
  try {
    final companyID = await TokenManager.getCompanyId();
    final response = await Api(context).get(
        path: EstablishmentManagerRepository.getServicedropdown());
    if (response.statusCode == 200 || response.statusCode == 201) {
      for (var item in response.data) {
        itemsList.add(
         ServiceData(
             officeServiceId: item['Office_service_id'],
             companyId: companyID,
             officeId: item['office_id'],
             serviceName: item['service_name'],
             serviceId: item['service_id'],
             npiNum: item['npi_number'],
             medicareNum: item['medicare_provider_id'],
             hcoNum: item['hco_num_id']),
        );
        print(" payrates dropdown$response");
      }
    } else {
      print('Api Error');
    }
    print("Response:::::${response}");
    return itemsList;
  } catch (e) {
    print("Error $e");
    return itemsList;
  }
}

/// Add pay rates POST
Future<ApiData> addButtonPayRatesSetupPost(
  BuildContext context,
  int zoneId,
  int rate,
  String typeOfVisitId,
  int permile,
  int serviceTypeId,
) async {
  try {
    final companyId = await TokenManager.getCompanyId();
    var response = await Api(context)
        .post(path: EstablishmentManagerRepository.postPayrates(), data: {
      'zoneId': zoneId,
      "rate": rate,
      "typeOfVisitId": typeOfVisitId,
      'perMile': permile,
      "serviceTypeId": serviceTypeId
    });
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Pay Rates added");
      return ApiData(
          statusCode: response.statusCode!,
          success: true,
          message: response.statusMessage!);
    } else {
      print("Error 1 Not Added Payrates");
      return ApiData(
          statusCode: response.statusCode!,
          success: false,
          message: response.data['message']);
    }
  } catch (e) {
    print("Error $e");
    print("Error 2 Not Added Payrates");
    return ApiData(
        statusCode: 404, success: false, message: AppString.somethingWentWrong);
  }
}

///
///
//////patch api
Future<ApiData> updatePayRatesEdit(
  BuildContext context,
  int payRatesId,
  int zoneId,
  int rateS,
  int rateE,
  List<int> rateD,
  String typeOfVisitId,
  int permileS,
  int permileE,
  List<int> permileD,
  int serviceTypeId,
) async {
  try {
    final companyId = await TokenManager.getCompanyId();
    var response = await Api(context).patch(
        path:
            EstablishmentManagerRepository.editPayRates(payRatesId: payRatesId),
        data: {
          'ZoneId': zoneId,
          'rate': {
            's': rateS,
            'e': rateE,
            'd': rateD,
          },
          'typeOfVisitId': typeOfVisitId,
          'perMile': {
            's': permileS,
            'e': permileE,
            'd': permileD,
          },
          'serviceTypeId': serviceTypeId,
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

///
Future<ApiData> deletePayRatesId(
  BuildContext context,
  int payRatesId,
) async {
  try {
    var response = await Api(context).delete(
        path: EstablishmentManagerRepository.deletePayRates(
            payRatesId: payRatesId));
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











////post api

Future<ApiData> addButtonPayRatePost(
    BuildContext context,
    int zoneId,
    int rateS,
    int rateE,
    List<int> rateD,
    String typeOfVisitId,
    int permileS,
    int permileE,
    List<int> permileD,
    int serviceTypeId,
    ) async {
  try {
    final companyId = await TokenManager.getCompanyId();
    var response = await Api(context).post(
      path: EstablishmentManagerRepository.postPayrates(),
      data: {
        'ZoneId': zoneId,
        'rate': {
          's': rateS,
          'e': rateE,
          'd': rateD,
        },
        'typeOfVisitId': typeOfVisitId,
        'perMile': {
          's': permileS,
          'e': permileE,
          'd': permileD,
        },
        'serviceTypeId': serviceTypeId,
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Pay Rates added");
      return ApiData(
        statusCode: response.statusCode!,
        success: true,
        message: response.statusMessage!,
      );
    } else {
      print("Error 1: Not Added Payrates");
      return ApiData(
        statusCode: response.statusCode!,
        success: false,
        message: response.data['message'] ?? 'Unknown error',
      );
    }
  } catch (e) {
    print("Error: $e");
    print("Error 2: Not Added Payrates");
    return ApiData(
      statusCode: 404,
      success: false,
      message: 'Something went wrong',
    );
  }
}




////prifill data

Future<PayRate> payPrefillRatesData(
    BuildContext context,
    int payRatesId
    ) async {
  try {
    final companyId = await TokenManager.getCompanyId();
    final response = await Api(context).get(
        path: EstablishmentManagerRepository.prefillPayRates(payRatesId: payRatesId)
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print(":::::LIST ${response.data}");

      // Ensure the response data is properly formatted
      if (response.data != null && response.data is Map<String, dynamic>) {
        // Create PayRate object from JSON data
        return PayRate.fromJson(response.data as Map<String, dynamic>);
      } else {
        throw Exception("Invalid response data format");
      }
    } else {
      print("Api Pay rates Data Error: ${response.statusMessage}");
      throw Exception("Failed to load pay rates data");
    }
  } catch (e) {
    print("Error: $e");
    throw Exception("Error fetching pay rates data");
  }
}






















////////////////////////////////////////////////////////////////////////////

class Rate {
  final int s;
  final int e;
  final List<int> d;

  Rate({
    required this.s,
    required this.e,
    required this.d,
  });

  factory Rate.fromJson(Map<String, dynamic> json) {
    return Rate(
      s: json['s'],
      e: json['e'],
      d: List<int>.from(json['d']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      's': s,
      'e': e,
      'd': d,
    };
  }
}

class PerMile {
  final int s;
  final int e;
  final List<int> d;

  PerMile({
    required this.s,
    required this.e,
    required this.d,
  });

  factory PerMile.fromJson(Map<String, dynamic> json) {
    return PerMile(
      s: json['s'],
      e: json['e'],
      d: List<int>.from(json['d']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      's': s,
      'e': e,
      'd': d,
    };
  }
}

class PayRate {
  final int payratesId;
  final int ZoneId;
  final Rate rate;
  final String typeOfVisitId;
  final PerMile perMile;
  final int serviceTypeId;

  PayRate({
    required this.payratesId,
    required this.ZoneId,
    required this.rate,
    required this.typeOfVisitId,
    required this.perMile,
    required this.serviceTypeId,
  });

  factory PayRate.fromJson(Map<String, dynamic> json) {
    return PayRate(
      payratesId: json['payratesId'],
      ZoneId: json['ZoneId'],
      rate: Rate.fromJson(json['rate']),
      typeOfVisitId: json['typeOfVisitId'],
      perMile: PerMile.fromJson(json['perMile']),
      serviceTypeId: json['serviceTypeId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'payratesId': payratesId,
      'ZoneId': ZoneId,
      'rate': rate.toJson(),
      'typeOfVisitId': typeOfVisitId,
      'perMile': perMile.toJson(),
      'serviceTypeId': serviceTypeId,
    };
  }
}
