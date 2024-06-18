import 'package:flutter/cupertino.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/data/api_data/api_data.dart';

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

/// Create user
Future<ApiData> createUserPost(
    BuildContext context,
    String firstName,
    String lastName,
    String role,
    String email,
    int companyId,
    String password
    ) async {
  try {
    var response = await Api(context).post(path: EstablishmentManagerRepository.createUserPost(), data: {
      'firstName':firstName,
      'lastName':lastName,
      'role':role,
      'email':email,
      'company_id':companyId,
      'password':password
    });
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("New User Added");
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

/// User edit
Future<ApiData> updateUserPatch(
    BuildContext context,
    int userId,
    String firstName,
    String lastName,
    String role,
    String email,
    int companyId
    ) async {
  try {
    var response = await Api(context).patch(path: EstablishmentManagerRepository.userUpdatePatch(userId: userId), data: {
      'firstName':firstName,
      'lastName':lastName,
      'role':role,
      'email':email,
      'company_id':companyId,
    });
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("User updated");
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

/// Delete user
Future<ApiData> deleteUser(
    BuildContext context,
    int userId,
    ) async {
  try {
    var response = await Api(context).delete(path: EstablishmentManagerRepository.userDelete(userId: userId));
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("User Deleted");
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