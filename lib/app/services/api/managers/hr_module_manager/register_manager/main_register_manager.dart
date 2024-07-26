import 'package:flutter/material.dart';
import '../../../../../../data/api_data/hr_module_data/register_data/main_register_screen_data.dart';
import '../../../../token/token_manager.dart';
import '../../../api.dart';
import '../../../repository/hr_module_repository/Register/main_register_screen.dart';

///users/ByCompanyId/{companyId}
Future<List<RegisterDataCompID>> GetRegisterByCompId(
    BuildContext context,
    ) async {
  List<RegisterDataCompID> itemsList = [];
  try {
    final companyId = await TokenManager.getCompanyId();
    final response =
    await Api(context).get(path: AllRegisterRepo.getRegisterDataCompId(companyId: companyId));
    if (response.statusCode == 200 || response.statusCode == 201) {
      for (var item in response.data) {
        itemsList.add(RegisterDataCompID(
            userId: item['userId'] ?? 0,
            firstName: item['firstName'] ?? "--",
            lastName: item['lastName'] ?? '--',
            role: item['role'] ?? '--',
            email: item['email'] ?? '--',
            company_id: item['company_id'] ?? 0,
            status: item['status'] ?? 'null'));
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


///users/ByCompanyId/{companyId}/{status}
Future<List<RegisterDataCompIDStatus>> GetRegisterByCompIdStatus(
    BuildContext context,
    String status
    ) async {
  List<RegisterDataCompIDStatus> itemsList = [];
  try {
    final companyId = await TokenManager.getCompanyId();
    final response =
    await Api(context).get(path: AllRegisterRepo.getRegisterDataCompIdStatus(companyId: companyId, status: status));
    if (response.statusCode == 200 || response.statusCode == 201) {
      for (var item in response.data) {
        itemsList.add(RegisterDataCompIDStatus(
            userId: item['userId'] ?? 0,
            firstName: item['firstName'] ?? "--",
            lastName: item['lastName'] ?? '--',
            role: item['role'] ?? '--',
            email: item['email'] ?? '--',
            company_id: item['company_id'] ?? 0,
            status: item['status'] ?? '--'));
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

///register prefill
Future<RegisterDataUserIDPrefill> getRegisterEnrollPrefillUserId(
    BuildContext context, int userId) async {
  var itemsList;
  try {
    final response = await Api(context).get(
        path: AllRegisterRepo.getRegisterPrefill(
            userId: userId));
    if (response.statusCode == 200 || response.statusCode == 201) {
      // print("Org Document response:::::${itemsList}");
      itemsList = RegisterDataUserIDPrefill(
          userId: response.data['userId'] ?? 0,
          firstName: response.data['firstName'] ?? "--",
          lastName: response.data['lastName'] ?? '--',
          role: response.data['role'] ?? '--',
          email: response.data['email'] ?? '--',
          company_id: response.data['company_id'] ?? 0,
          status: response.data['status'] ?? '--');
    } else {
      return itemsList;
    }
    return itemsList;
  } catch (e) {
    print("Error $e");
    return itemsList;
  }
}
