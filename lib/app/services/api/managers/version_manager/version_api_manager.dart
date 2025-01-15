import 'package:flutter/material.dart';
import 'package:prohealth/app/services/api/api.dart';
import 'package:prohealth/app/services/api/repository/version/version_repo.dart';
import 'package:prohealth/data/api_data/hr_module_data/add_employee/clinical.dart';
import 'package:prohealth/data/api_data/version/version_model_data.dart';

///get Employee API
Future<HRAddEmployeeGet> getApplicationVersion(
    BuildContext context,
    ) async {
  var itemsList;
  try {
    final response = await Api(context)
        .get(path: VersionRepository.getVersion());
    if (response.statusCode == 200 || response.statusCode == 201) {
      itemsList = VersionData(
          id: response.data['id'],
          versionName: response.data['versionName']??"--",
          lastUpdated:  response.data['lastUpdated']??"--");
      print("Response:::::${response}");
    } else {
      print('Version Api Error');
    }
    print("Response:::::${response}");
    return itemsList;
  } catch (e) {
    print("Error $e");
    return itemsList;
  }
}