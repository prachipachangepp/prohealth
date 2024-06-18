import 'package:flutter/material.dart';
import 'package:prohealth/app/services/api/api.dart';
import 'package:prohealth/app/services/api/repository/establishment_manager/establishment_repository.dart';
import 'package:prohealth/data/api_data/establishment_data/zone/zone_model_data.dart';

Future<List<AllZoneData>> getAllZone(BuildContext context,) async {
  List<AllZoneData> itemsList = [];
  try {
    final response = await Api(context)
        .get(path: EstablishmentManagerRepository.zoneGet(
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