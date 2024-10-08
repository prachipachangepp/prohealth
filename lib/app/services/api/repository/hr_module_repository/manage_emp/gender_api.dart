import 'package:flutter/material.dart';
import 'package:prohealth/app/services/api/repository/hr_module_repository/profile_repo.dart';

import '../../../../../../data/api_data/hr_module_data/manage/gender_data.dart';
import '../../../api.dart';

///get hrTab
Future<List<GenderData>> getGenderDropdown(BuildContext context) async {
  List<GenderData> itemsList = [];
  try {
    final response = await Api(context)
        .get(path: ProfileRepository.getGender());
    print('Prachi ::::::::;;;;${""}');
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("ResponseList:::::${itemsList}");
      for (var item in response.data) {
        itemsList.add(
            GenderData(
                genderId: item['genderId'],
                gender: item['gender'],
            )
        );
      }
      print("ResponseList:::::${itemsList}");
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
