import 'package:flutter/cupertino.dart';

import '../../../../../data/api_data/establishment_data/user/user_modal.dart';
import '../../api.dart';
import '../../repository/establishment_manager/establishment_repository.dart';

///user
Future<List<UserModal>> getUser(BuildContext context,) async {
  List<UserModal> itemsList = [];
  try {
    final response = await Api(context).get(
        path: EstablishmentManagerRepository.userGet());
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("user data");
      for (var item in response.data) {
        itemsList.add(
         UserModal(
             userId: item['userId'],
             firstName: item['firstName'],
             lastName: item['lastName'] == null ? "--" : item['lastName'],
             role: item['role'],
             companyId: item['company_id'],
             email: item['email'],
             sucess: true,
             message: response.statusMessage!)
        );
      }
      // print("Org Document response:::::${itemsList}");
    } else {
      print('User Data Error');
      return itemsList;
    }
    // print("Org response:::::${response}");
    return itemsList;
  } catch (e) {
    print("Error $e");
    return itemsList;
  }
}