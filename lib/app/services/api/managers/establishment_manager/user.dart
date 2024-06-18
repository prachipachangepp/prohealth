import 'package:flutter/cupertino.dart';

import '../../../../../data/api_data/establishment_data/user/user_modal.dart';
import '../../api.dart';
import '../../repository/establishment_manager/establishment_repository.dart';

///user
Future<List<UserModal>> getUser(BuildContext context,
    int userId,
    String firstName,
    String lastName,
    String role,
    String email,
    int companyId
    ) async {
  List<UserModal> itemsList = [];
  try {
    final response = await Api(context).get(
        path: EstablishmentManagerRepository.userGet(

        ));
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Org Document Tab bar response:::::${itemsList}");
      print("111");
      for (var item in response.data) {
        itemsList.add(
         UserModal(
             userId: userId,
             firstName: firstName,
             lastName: lastName,
             role: role,
             companyId: companyId,
             email: email)
        );
      }
      // print("Org Document response:::::${itemsList}");
    } else {
      print('Org Api Error');
      return itemsList;
    }
    // print("Org response:::::${response}");
    return itemsList;
  } catch (e) {
    print("Error $e");
    return itemsList;
  }
}