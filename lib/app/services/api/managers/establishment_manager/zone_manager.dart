import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/services/api/api.dart';
import 'package:prohealth/app/services/api/repository/establishment_manager/all_from_hr_repository.dart';
import 'package:prohealth/app/services/api/repository/establishment_manager/establishment_repository.dart';
import 'package:prohealth/data/api_data/api_data.dart';
import 'package:prohealth/data/api_data/establishment_data/zone/zone_model_data.dart';

///zone GET
Future<List<AllZoneData>> getAllZone(
  BuildContext context,
) async {
  List<AllZoneData> itemsList = [];
  try {
    final response = await Api(context).get(path: AllZoneRepository.zoneGet());
    if (response.statusCode == 200 || response.statusCode == 201) {
      // print("Org Document response:::::${itemsList}");
      print("1");
      for (var item in response.data) {
        itemsList.add(AllZoneData(
            zoneId: item['zone_id'],
            zoneName: item['zoneName'],
            sucess: true,
            message: response.statusMessage!));
      }
      // print("Org Document response:::::${itemsList}");
    } else {
      print('Zone Api Error');
      return itemsList;
    }
    // print("Org response:::::${response}");
    return itemsList;
  } catch (e) {
    print("Error $e");
    return itemsList;
  }
}

///county get
Future<List<AllCountyGet>> getZoneBYcompOffice(
    BuildContext context, String officeId, int compId, pageNo, noOfRow) async {
  List<AllCountyGet> itemsList = [];
  try {
    final response = await Api(context).get(
        path: AllZoneRepository.countyGet(
            companyId: compId,
            officeId: officeId,
            pageNo: pageNo,
            noOfRow: noOfRow));
    if (response.statusCode == 200 || response.statusCode == 201) {
      // print("Org Document response:::::${itemsList}");
      print("1");
      for (var item in response.data) {
        itemsList.add(AllCountyGet(
            countyName: item['countyName'],
            state: item['state'],
            country: item['Country'],
            zipcodes: item['zipcodes'],
            sucess: true,
            message: response.statusMessage,
            zoneName: item['zoneName'],
            zoinId: item['zoneId']));
      }
      print("County response:::::${itemsList}");
    } else {
      print('County Api Error');
      return itemsList;
    }
    // print("Org response:::::${response}");
    return itemsList;
  } catch (e) {
    print("Error $e");
    return itemsList;
  }
}

///county get
Future<List<AllCountyZoneGet>> getZoneByCounty(BuildContext context,
    String officeId, int compId, int countyId, int pageNo, int noOfRow) async {
  List<AllCountyZoneGet> itemsList = [];
  try {
    final response = await Api(context).get(
        path: AllZoneRepository.countyZoneGet(
            companyId: compId,
            officeId: officeId,
            pageNo: pageNo,
            noOfRow: noOfRow,
            countyId: countyId));
    if (response.statusCode == 200 || response.statusCode == 201) {
      // print("Org Document response:::::${itemsList}");
      print("1");
      for (var item in response.data) {
        itemsList.add(AllCountyZoneGet(
            countyName: item['countyName'] ?? "--",
            zipcodes: item['zipcodes'] ?? "--",
            sucess: true,
            message: response.statusMessage!,
            countyId: item['county_id'] ?? 0,
            zoneId: item['zone_id'] ?? 0,
            zoneName: item['zoneName'] ?? "--",
            cities: item['cities'] ?? "--"));
      }
      print("County response:::::${itemsList}");
    } else {
      print('County Api Error');
      return itemsList;
    }
    // print("Org response:::::${response}");
    return itemsList;
  } catch (e) {
    print("Error $e");
    return itemsList;
  }
}
/// zone county prefill patch
Future<CountyZonePrefillGet> getZoneByCountyPrefill(BuildContext context, int zoinId) async {
  var itemsList;
  try {
    final response = await Api(context).get(
        path: AllZoneRepository.countyZoneDelete(zoinId: zoinId));
    if (response.statusCode == 200 || response.statusCode == 201) {
      // print("Org Document response:::::${itemsList}");
      print("1");

        itemsList=AllCountyZoneGet(
            countyName: response.data['countyName'] ?? "--",
            zipcodes: response.data['zipcodes'] ?? "--",
            sucess: true,
            message: response.statusMessage!,
            countyId: response.data['county_id'] ?? 0,
            zoneId: response.data['zone_id'] ?? 0,
            zoneName: response.data['zoneName'] ?? "--",
            cities: response.data['cities'] ?? "--");


    } else {
      print('County Api Error');
      return itemsList;
    }
    // print("Org response:::::${response}");
    return itemsList;
  } catch (e) {
    print("Error $e");
    return itemsList;
  }
}

/// County get List
Future<List<AllCountyGetList>> getCountyZoneList(BuildContext context) async {
  List<AllCountyGetList> itemsList = [];
  try {
    final response =
        await Api(context).get(path: AllZoneRepository.countyListGet());
    if (response.statusCode == 200 || response.statusCode == 201) {
      // print("Org Document response:::::${itemsList}");
      print("1");
      for (var item in response.data) {
        itemsList.add(AllCountyGetList(
            countyName: item['countyName'],
            state: item['state'],
            country: item['Country'],
            sucess: true,
            message: response.statusMessage!,
            officeID: item['officeId'],
            countyId: item['county_id'],
            companyId: item['companyId'],
            latitude: item['latitude'],
            longitude: item['longitude']));
      }
      print("County response:::::${itemsList}");
    } else {
      print('County Api Error');
      return itemsList;
    }
    // print("Org response:::::${response}");
    return itemsList;
  } catch (e) {
    print("Error $e");
    return itemsList;
  }
}

/// Zone county add
Future<ApiData> addZoneCountyData(BuildContext context, String zoneName,
    int countyId, String officeId, int companyId) async {
  try {
    var response =
        await Api(context).post(path: AllZoneRepository.addCountyZone(), data: {
      "zoneName": zoneName,
      "county_id": countyId,
      "officeId": officeId,
      "companyId": companyId
    });
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Zone-County record added");
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
    return ApiData(
        statusCode: 404, success: false, message: AppString.somethingWentWrong);
  }
}

/// Zone county update
Future<ApiData> updateZoneCountyData(BuildContext context, int zoinId,
    String zoneName, int countyId, String officeId, int companyId) async {
  try {
    var response = await Api(context)
        .patch(path: AllZoneRepository.updateCountyZone(zoinId: zoinId), data: {
      "zoneName": zoneName,
      "county_id": countyId,
      "officeId": officeId,
      "companyId": companyId
    });
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Zone-County record updated");
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
    return ApiData(
        statusCode: 404, success: false, message: AppString.somethingWentWrong);
  }
}

/// Zone County Delete
Future<ApiData> deleteZoneCountyData(BuildContext context, int zoneId) async {
  try {
    var response = await Api(context)
        .delete(path: AllZoneRepository.countyZoneDelete(zoinId: zoneId));
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Zone-County record added");
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
    return ApiData(
        statusCode: 404, success: false, message: AppString.somethingWentWrong);
  }
}

/// Zone County add
Future<ApiData> addZoneCounty(
    BuildContext context, int zoneId, int countyId) async {
  try {
    var response = await Api(context).post(
        path: AllZoneRepository.zoneCountyPost(),
        data: {"zone_id": zoneId, "county_id": countyId});
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Zone-County record added");
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
    return ApiData(
        statusCode: 404, success: false, message: AppString.somethingWentWrong);
  }
}

/// County add
Future<ApiData> addCounty(
    BuildContext context,
    String countyName,
    String stateName,
    String countryName,
    String lat,
    String long,
    int companyId,
    String officeId) async {
  try {
    var response =
        await Api(context).post(path: AllZoneRepository.addCounty(), data: {
      "countyName": countyName,
      "state": stateName,
      "Country": countryName,
      "latitude": lat,
      "longitude": long,
      "companyId": companyId,
      "officeId": officeId
    });
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("County added");
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
    return ApiData(
        statusCode: 404, success: false, message: AppString.somethingWentWrong);
  }
}

/// County delete
Future<ApiData> deleteCounty(BuildContext context, int countyId) async {
  try {
    var response = await Api(context)
        .delete(path: AllZoneRepository.deleteCounty(countyId: countyId));
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("County record Deleted");
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
    return ApiData(
        statusCode: 404, success: false, message: AppString.somethingWentWrong);
  }
}

///zipcode,zone get
Future<List<AllZipCodeGet>> getZipcodeSetup(
    BuildContext context, String officeId, int compId, pageNo, noOfRow) async {
  List<AllZipCodeGet> itemsList = [];
  try {
    final response = await Api(context).get(
        path: AllZoneRepository.zipcodeSetupGet(
            companyId: compId,
            officeId: officeId,
            pageNo: pageNo,
            noOfRow: noOfRow));
    if (response.statusCode == 200 || response.statusCode == 201) {
      // print("Org Document response:::::${itemsList}");
      print("1");
      for (var item in response.data) {
        itemsList.add(AllZipCodeGet(
            zipcodeSetupId: item['zipcodeSetupId'],
            zoneId: item['zoneId'],
            countyID: item['countyId'],
            companyID: item['companyId'],
            city: item['city'],
            zipcode: item['zipcode'],
            latitude: item['latitude'],
            longitude: item['longitude'],
            landmark: item['landmark'],
            officeId: item['officeId'],
            sucess: true,
            message: response.statusMessage,
            zoneName: item['zone'] ?? "--",
            countyName: item['county'] ?? "--"));
      }
      // print("Org Document response:::::${itemsList}");
    } else {
      print('Zone,zipcode Api Error');
      return itemsList;
    }
    // print("Org response:::::${response}");
    return itemsList;
  } catch (e) {
    print("Error $e");
    return itemsList;
  }
}

/// Zipcode prefill
Future<ZipCodeGetPrefill> getZipcodeSetupPrefill(
    BuildContext context, int zipCodeSetupId) async {
 var itemsList;
  try {
    final response = await Api(context).get(
        path: AllZoneRepository.deleteZipCodeSetup(zipCodeSetupId: zipCodeSetupId));
    if (response.statusCode == 200 || response.statusCode == 201) {
      // print("Org Document response:::::${itemsList}");
      print("1");

        itemsList = ZipCodeGetPrefill(
            zipcodeSetupId: response.data['zipcodeSetupId'],
            zoneId: response.data['zoneId'],
            countyID: response.data['countyId'],
            companyID: response.data['companyId'],
            city: response.data['city'],
            zipcode: response.data['zipcode'],
            latitude: response.data['latitude'],
            longitude: response.data['longitude'],
            landmark: response.data['landmark'],
            officeId: response.data['officeId'],
            sucess: true,
            message: response.statusMessage,
            zoneName: response.data['zone'] ?? "--",
            countyName: response.data['county'] ?? "--");

      // print("Org Document response:::::${itemsList}");
    } else {
      print('Zone,zipcode Api Error');
      return itemsList;
    }
    // print("Org response:::::${response}");
    return itemsList;
  } catch (e) {
    print("Error $e");
    return itemsList;
  }
}

/// Zipcode delete
Future<ApiData> deleteZipCodeSetup(
    BuildContext context, int zipCodeSetupId) async {
  try {
    var response = await Api(context).delete(
        path: AllZoneRepository.deleteZipCodeSetup(
            zipCodeSetupId: zipCodeSetupId));
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Zip Code record Deleted");
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
    return ApiData(
        statusCode: 404, success: false, message: AppString.somethingWentWrong);
  }
}

/// Add zipCode
Future<ApiData> addZipCodeSetup(
  BuildContext context,
  int zoneId,
  int countyId,
  int companyId,
  String officeId,
  String cityName,
  String zipCode,
  String latitude,
  String longitude,
  String landmark,
) async {
  try {
    var response = await Api(context)
        .post(path: AllZoneRepository.addZipCodeSetupPost(), data: {
      "zoneId": zoneId,
      "countyId": countyId,
      "city": cityName,
      "zipcode": zipCode,
      "latitude": latitude,
      "longitude": longitude,
      "landmark": landmark,
      "companyId": companyId,
      "officeId": officeId
    });
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Zip Code record Added");
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
    return ApiData(
        statusCode: 404, success: false, message: AppString.somethingWentWrong);
  }
}

/// Uodate zipcode setup
/// Add zipCode
Future<ApiData> updateZipCodeSetup(
  BuildContext context,
  int zipCodeSetupId,
  int zoneId,
  int countyId,
  int companyId,
  String officeId,
  String cityName,
  String zipCode,
  String latitude,
  String longitude,
  String landmark,
) async {
  try {
    var response = await Api(context).patch(
        path: AllZoneRepository.updateZipCodeSetup(
            zipCodeSetupId: zipCodeSetupId),
        data: {
          "zoneId": zoneId,
          "countyId": countyId,
          "city": cityName,
          "zipcode": zipCode,
          "latitude": latitude,
          "longitude": longitude,
          "landmark": landmark,
          "companyId": companyId,
          "officeId": officeId
        });
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Zip Code record Updated");
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
    return ApiData(
        statusCode: 404, success: false, message: AppString.somethingWentWrong);
  }
}
