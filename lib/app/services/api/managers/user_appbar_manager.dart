
import 'package:flutter/cupertino.dart';
import 'package:prohealth/data/api_data/establishment_data/user/user_appbar.dart';

import '../../token/token_manager.dart';
import '../api.dart';
import '../repository/establishment_manager/establishment_repository.dart';

Future<UserAppBar> getAppBarDetails(BuildContext context, int userId) async {
  var itemsList;
  try{
    final companyId = await TokenManager.getCompanyId();
    final response = await Api(context).get(
        path: EstablishmentManagerRepository.userPrefillGet(userId: userId));
    if(response.statusCode == 200 || response.statusCode == 201){
      itemsList = UserAppBar(
          userId: response.data['userId'],
          firstName: response.data['firstName'],
          lastName: response.data['lastName'],
          departmentId: response.data['departmentId'],
          department: response.data['department'],
          email: response.data['email'],
          companyId: companyId,
          password: response.data['password'],
          status: response.data['status'],
          employeeId: response.data['employeeId'],
          imgUrl: response.data['imgUrl']);
      print("User Data for Appbar : $itemsList");
    }
    else{
      print("User Data for Appbar error");
    }
    return itemsList;
  }
  catch(e){
    print("Error $e");
    return itemsList;
  }
}
