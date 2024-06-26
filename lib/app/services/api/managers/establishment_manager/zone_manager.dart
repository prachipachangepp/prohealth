import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/services/api/api.dart';
import 'package:prohealth/app/services/api/repository/establishment_manager/all_from_hr_repository.dart';
import 'package:prohealth/app/services/api/repository/establishment_manager/establishment_repository.dart';
import 'package:prohealth/data/api_data/api_data.dart';
import 'package:prohealth/data/api_data/establishment_data/zone/zone_model_data.dart';
///zone GET
Future<List<AllZoneData>> getAllZone(BuildContext context,) async {
  List<AllZoneData> itemsList = [];
  try {
    final response = await Api(context)
        .get(path: AllZoneRepository.
    zoneGet(
    ));
    if (response.statusCode == 200 || response.statusCode == 201) {
      // print("Org Document response:::::${itemsList}");
      print("1");
      for(var item in response.data){
        itemsList.add(
          AllZoneData(
              zoneId: item['zone_id'],
              zoneName: item['zoneName'],
              sucess: true,
              message: response.statusMessage!)
        );
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
Future<List<AllCountyGet>> getZoneBYcompOffice(BuildContext context,String officeId,int compId,pageNo, noOfRow) async {
  List<AllCountyGet> itemsList = [];
  try {
    final response = await Api(context)
        .get(path: AllZoneRepository.countyGet(companyId: compId, officeId: officeId, pageNo: pageNo, noOfRow: noOfRow)
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      // print("Org Document response:::::${itemsList}");
      print("1");
      for(var item in response.data){
        itemsList.add(
          AllCountyGet(
              countyName: item['countyName'],
              state: item['state'],
              country: item['Country'],
              zipcodes: item['zipcodes'],
              sucess: true, 
              message: response.statusMessage)
        );
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
/// County delete
Future<ApiData> deleteCounty(
    BuildContext context,
    int countyId
    ) async {
  try {
    var response = await Api(context).delete(path:
    AllZoneRepository.deleteCounty(countyId: countyId));
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
Future<List<AllZipCodeGet>> getZipcodeSetup(BuildContext context,String officeId,int compId,pageNo, noOfRow) async {
  List<AllZipCodeGet> itemsList = [];
  try {
    final response = await Api(context)
        .get(path: AllZoneRepository.zipcodeSetupGet(companyId: compId, officeId: officeId, pageNo: pageNo, noOfRow: noOfRow));
    if (response.statusCode == 200 || response.statusCode == 201) {
      // print("Org Document response:::::${itemsList}");
      print("1");
      for(var item in response.data){
        itemsList.add(
          AllZipCodeGet(
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
              message: response.statusMessage)
        );
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

/// Zipcode delete
Future<ApiData> deleteZipCodeSetup(
    BuildContext context,
    int zipCodeSetupId
    ) async {
  try {
    var response = await Api(context).delete(path:
    AllZoneRepository.deleteZipCodeSetup(zipCodeSetupId: zipCodeSetupId));
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
