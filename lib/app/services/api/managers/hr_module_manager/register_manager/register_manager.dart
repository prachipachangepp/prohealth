import 'package:flutter/material.dart';
import 'package:prohealth/app/services/api/repository/hr_module_repository/Register/register.dart';
import 'package:prohealth/data/api_data/hr_module_data/register_data/register_data.dart';
import '../../../../../../data/api_data/api_data.dart';
import '../../../../../resources/const_string.dart';
import '../../../api.dart';

///register enroll get
Future<List<RegisterEnrollData>> RegisterGetData(BuildContext context,) async {
  List<RegisterEnrollData> itemsList = [];
  try {
    final response = await Api(context)
        .get(path: AllRegisterRepository.getEmployeeEnroll());
    if (response.statusCode == 200 || response.statusCode == 201) {
      for (var item in response.data) {
        itemsList.add(
       RegisterEnrollData(
           employeeEnrollId: item["employeeEnrollId"] ?? 0,
           companyId: item["companyId"] ?? 0,
           employeeId: item["employeeId"] ?? 0,
           code: item["code"] ?? '--',
           userId: item["userId"] ?? 0,
         firstName: item["firstName"] ?? '--',
         lastName: item["lastName"]?? '--',
         phoneNbr: item["phoneNbr"] ?? '--',
         email: item["email"] ?? '--',
         link: item["link"] ?? '--',
         status: item["status"] ?? '--',
         departmentId: item["departmentId"] ?? 0,
         position: item["position"] ?? '--',
         speciality: item["speciality"] ?? '--',
         clinicianTypeId: item["clinicianTypeId"] ?? 0,
         reportingOfficeId: item["reportingOfficeId"] ?? '--',
         cityId: item["cityId"] ?? 0,
         countryId: item["countryId"] ?? 0,
         countyId: item["countyId"] ?? 0,
         zoneId: item["zoneId"] ?? 0,
         employment: item["employment"] ?? '--',
         service: item["service"] ?? '--',
       )
        );
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

// Future<List<RegisterEnrollData>> RegisterEmpEnrollGetById(BuildContext context, int empEnrollId) async {
//   List<RegisterEnrollData> itemsList = [];
//   try{
//     final response = await Api(context).get(path:
//     AllRegisterRepository.getEmpEnrollByEnrollId(empEnrollId: empEnrollId));
//     if (response.statusCode == 200 || response.statusCode == 201) {
//       for (var item in response.data) {
//         itemsList.add(
//             RegisterEnrollData(
//               empEnrollId: item["employeeEnrollId"],
//               compId: item["companyId"],
//               empId: item["employeeId"],
//               userId: item["userId"],
//               code: item["code"],
//               firstName: item["firstName"],
//               lastName: item["lastName"],
//               phoneNbr: item["phoneNbr"],
//               email: item["email"],
//               link: item["link"],
//               status: item["status"],
//             )
//         );
//       }
//     } else {
//       print('Api Error');
//     }
//     print("Response:::::${response}");
//     return itemsList;
//   }catch (e) {
//     print("Error $e");
//     return itemsList;
//   }
// }

///register enroll add
Future<ApiData> addEmpEnroll(BuildContext context,
    int companyId, int employeeId,String code,
    int userId,String firstName,String lastName,
    String phoneNbr,String email,String link, String status
    )
async {
  try {
    var response = await Api(context).post(path: AllRegisterRepository.addEmpEnrollAdd(),
      data: {
        "companyId": companyId,
        "employeeId": employeeId,
        "code": code,
        "userId": userId,
        "firstName": firstName,
        "lastName": lastName,
        "phoneNbr": phoneNbr,
        "email": email,
        "link": link,
        "status": status
    },);
    print(response);
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Enroll added");
      // orgDocumentGet(context);
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

/// Get prefill register enroll
Future<RegisterDataPrefill> getRegisterEnrollPrefill(BuildContext context, int empEnrollId) async {
  var itemsList;
  try {
    final response = await Api(context)
        .get(path: AllRegisterRepository.getEmpEnrollByEnrollId(empEnrollId: empEnrollId));
    if (response.statusCode == 200 || response.statusCode == 201) {
      // print("Org Document response:::::${itemsList}");
      itemsList = RegisterDataPrefill(
        empEnrollId: response.data['employeeEnrollId']??0,
        compId: response.data['companyId']??5,
        empId: response.data['employeeId']??2,
        userId: response.data['userId']??0,
        code:response.data['code']?? '--',
        firstName: response.data['firstName']??"--",
        lastName: response.data['lastName']??"--",
        phoneNbr: response.data['phoneNbr']??"--",
        email: response.data['email'] ?? '-',
        link:response.data['link']??"--",
        status: response.data['status']??"--",);
    } else {
      return itemsList;
    }
    return itemsList;
  } catch (e) {
    print("Error $e");
    return itemsList;
  }
}
