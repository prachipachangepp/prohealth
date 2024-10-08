import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/services/token/token_manager.dart';
import 'package:prohealth/data/api_data/api_data.dart';

import '../../../../../data/api_data/establishment_data/user/user_modal.dart';
import '../../api.dart';
import '../../repository/establishment_manager/establishment_repository.dart';

///user get user by company  API
Future<List<UserModal>> getUser(
  BuildContext context,
) async {
  List<UserModal> itemsList = [];
  try {
    final companyId = await TokenManager.getCompanyId();
    final response = await Api(context).get(
        path: EstablishmentManagerRepository.userGetByCompanyId(
            companyId: companyId));
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("user data");
      for (var item in response.data) {
        itemsList.add(UserModal(
          userId: item['userId'] ?? 1,
          firstName: item['firstName'] ?? "",
          lastName: item['lastName'] == null ? "--" : item['lastName'] ?? "",
          role: item['role'] ?? "",
          department: item['department'] ?? "Administration",
          departmentId: item['departmentId'] ?? 1,
          email: item['email'] ?? "",
          companyId: companyId, // item['company_id']  ,
          phoneNbr: item['phoneNbr'] ?? "",
          link: item['link'] ?? "",
          employeeEnrollId: item['employeeEnrollId'] ?? 0,
          employeeId: item['employeeId'] ?? 0,
          position: item['position'] ?? "",
          speciality: item['speciality'] ?? "",
          clinicianTypeId: item['clinicianTypeId'] ?? 0,
          reportingOfficeId: item['reportingOfficeId'] ?? "",
          cityId: item['cityId'] ?? 0,
          countryId: item['countryId'] ?? 0,
          countyId: item['countyId'] ?? 0,
          zoneId: item['zoneId'] ?? 0,
          employment: item['employment'] ?? "",
          service: item['service'] ?? "",
          status: item['status'] ?? "",
          templateId: item['templateId'] ?? 1,
          // password: ''

          ///
          //   userId: item['userId'],
          //   firstName: item['firstName'],
          //   lastName: item['lastName'] == null ? "--" : item['lastName'],
          //   role: item['role'],
          //   companyId: item['company_id'],
          //   email: item['email'],
          //   password: item['this.password'],
          sucess: true,
          message: response.statusMessage!,
        ));
        itemsList.sort((a, b) => a.userId.compareTo(b.userId));
      }
      print("Users By Company Id:::::${itemsList}");
    } else {
      print('Users By Company Id User Data Error');
      return itemsList;
    }
    print("Org response:::::${response}");
    return itemsList;
  } catch (e) {
    print("Error $e");
    return itemsList;
  }
}

/// Get all prefill user
Future<UserModalPrefill> getUserPrefill(
    BuildContext context, int userId) async {
  var itemsList;
  try {
    final companyId = await TokenManager.getCompanyId();
    final response = await Api(context).get(
        path: EstablishmentManagerRepository.userPrefillGet(userId: userId));
    if (response.statusCode == 200 || response.statusCode == 201) {
      itemsList = UserModalPrefill(
        userId: response.data['userId'],
        firstName: response.data['firstName'],
        lastName: response.data['lastName'] ?? "--",
        deptId: response.data['departmentId'] ?? 1,
        department: (response.data['department'] is List)
            ? response.data['department'].join(", ") ??
                "" // Convert list to comma-separated string
            : response.data['department'] ?? "", // If it's already a string
        companyId: companyId, // response.data['company_id'],
        password:
            response.data['password'], // Still including but not using in UI
        email: response.data['email'],
        sucess: true,
        message: response.statusMessage!,
      );
      print("User Prefilled by Get: $itemsList");
    } else {
      print('User Data Error');
    }
    return itemsList;
  } catch (e) {
    print("Error $e");
    return itemsList;
  }
}

///
// Future<UserModalPrefill> getUserPrefill(BuildContext context,int userId) async {
//   var itemsList;
//   try {
//     final response = await Api(context).get(
//         path: EstablishmentManagerRepository.userPrefillGet(userId: userId));
//     if (response.statusCode == 200 || response.statusCode == 201) {
//         itemsList =
//             UserModalPrefill(
//                 userId: response.data['userId'],
//                 firstName: response.data['firstName'],
//                 lastName: response.data['lastName']??"--",
//                 deptId: response.data['departmentId'],
//                 department: response.data['department'],
//                 companyId: response.data['company_id'],
//                 password: response.data['password'] ,
//                 email: response.data['email'],
//                 // status: response.data['status'],
//                 sucess: true,
//                 message: response.statusMessage!,
//
//             );
//         print("User Prefilled Bu Get :::::${itemsList}");
//       //
//     } else {
//       print('User Data Error');
//       return itemsList;
//     }
//     // print("Org response:::::${response}");
//     return itemsList;
//   } catch (e) {
//     print("Error $e");
//     return itemsList;
//   }
// }

/// Create user
Future<ApiData> createUserPost(BuildContext context, String firstName,
    String lastName, int departmentId, String email, String password) async {
  try {
    final companyId = await TokenManager.getCompanyId();
    var response = await Api(context)
        .post(path: EstablishmentManagerRepository.createUserPost(), data: {
      'firstName': firstName,
      'lastName': lastName,
      'departmentId': departmentId,
      'email': email,
      'company_id': companyId,
      'password': password
    });
    print(response.data);
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

///create user with popup

//
// Future<ApiData> createUserPost(
//     BuildContext context,
//     String firstName,
//     String lastName,
//     String role,
//     String email,
//     int companyId,
//     String password,
//     ) async {
//   try {
//     var response = await Api(context).post(path: EstablishmentManagerRepository.createUserPost(), data: {
//       'firstName': firstName,
//       'lastName': lastName,
//       'role': role,
//       'email': email,
//       'company_id': companyId,
//       'password': password
//     });
//
//     if (response.statusCode == 200 || response.statusCode == 201) {
//       print("New User Added - Status: ${response.statusCode}");
//       // Show success popup
//       _showPopup(context, "Success", "New User Added Successfully");
//       return ApiData(
//         statusCode: response.statusCode!,
//         success: true,
//         message: response.statusMessage!,
//       );
//     } else {
//       print("Failed to add user - Status: ${response.statusCode}");
//       // Show error popup with the message from the response
//       _showPopup(context, "Error", response.data['message'] ?? "Failed to add user");
//       return ApiData(
//         statusCode: response.statusCode!,
//         success: false,
//         message: response.data['message'],
//       );
//     }
//   } catch (e) {
//     print("Exception occurred: $e");
//     // Show error popup for exceptions
//     _showPopup(context, "Error", "Something went wrong. Please try again.");
//     return ApiData(
//       statusCode: 404,
//       success: false,
//       message: AppString.somethingWentWrong,
//     );
//   }
// }

void _showPopup(BuildContext context, String title, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            child: Text("OK"),
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
          ),
        ],
      );
    },
  ).then((_) {
    print("Popup closed");
  });
}

/// update user patch edit
Future<ApiData> updateUserPatch({
  required BuildContext context,
  required int userId,
  required String firstName,
  required String lastName,
  required int deptId,
  required String email,
}) async {
  try {
    final data = {
      "firstName": firstName,
      "lastName": lastName,
      "departmentId": deptId,
      "email": email,
    };

    print("Data ::" + data.toString());

    final response = await Api(context).patch(
      path: EstablishmentManagerRepository.userUpdatePatch(userId: userId),
      data: data,
    );

    print(response);
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("User updated successfully");
      return ApiData(statusCode: response.statusCode!, success: true, message: response.statusMessage!);
    } else {
      print("Failed to update user: ${response.statusCode}");
      return ApiData(statusCode: response.statusCode!, success: false, message: response.statusMessage!);
    }
  } catch (e) {
    print("Error: $e");
    return ApiData(statusCode: 500, success: false, message: "Server Error!");
  }
}

///
// Future<ApiData> updateUserPatch(
//     BuildContext context,
//     int userId,
//     String firstName,
//     String lastName,
//     int departmentId,
//     String email,
//     String password,
//     //int companyId
//     ) async {
//   try {
//     final companyId = await TokenManager.getCompanyId();
//     var response = await Api(context).patch(path: EstablishmentManagerRepository.userUpdatePatch(userId: userId), data: {
//       'firstName':firstName,
//       'lastName':lastName,
//       'departmentId':departmentId,
//       'email':email,
//       'password':password,
//       'company_id':companyId,
//     });
//     if (response.statusCode == 200 || response.statusCode == 201) {
//       print("User updated");
//       return ApiData(
//           statusCode: response.statusCode!,
//           success: true,
//           message: response.statusMessage!);
//     } else {
//       print("Error 1");
//       return ApiData(
//           statusCode: response.statusCode!,
//           success: false,
//           message: response.data['message']);
//     }
//   } catch (e) {
//     print("Error $e");
//     return ApiData(
//         statusCode: 404, success: false, message: AppString.somethingWentWrong);
//   }
// }

/// Delete user
Future<ApiData> deleteUser(
  BuildContext context,
  int userId,
) async {
  try {
    var response = await Api(context).delete(
        path: EstablishmentManagerRepository.userDelete(userId: userId));
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
