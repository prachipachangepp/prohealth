import 'package:flutter/material.dart';
import '../../../../../data/api_data/establishment_data/all_from_hr/all_from_hr_data.dart';
import '../../api.dart';
import '../../repository/establishment_manager/all_from_hr_repository.dart';

/// Get Company
Future<List<HRClinical>> companyAllApi(BuildContext context) async {
  List<HRClinical> itemsList = [];
  try {
    final response = await Api(context)
        .get(path: AllFromHrRepository.getEmployeeType());
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("ResponseList:::::${itemsList}");
      for (var item in response.data) {
        itemsList.add(
          HRClinical(
              empType: item['employeeType'],
              abbrivation: item['shorthand'],
              color: item['color'],
              ),
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
