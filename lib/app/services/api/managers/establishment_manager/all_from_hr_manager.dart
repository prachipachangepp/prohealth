import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/services/api/repository/establishment_manager/establishment_repository.dart';
import 'package:prohealth/data/api_data/api_data.dart';
import '../../../../../data/api_data/establishment_data/all_from_hr/all_from_hr_data.dart';
import '../../api.dart';
import '../../repository/establishment_manager/all_from_hr_repository.dart';
///get hrTab
Future<List<HRHeadBar>> companyHRHeadApi(BuildContext context, int deptId) async {
  List<HRHeadBar> itemsList = [];
  try {
    final response = await Api(context)
        .get(path: AllFromHrRepository.getHrType());
    print('Prachi ::::::::;;;;${deptId}');
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("ResponseList:::::${itemsList}");
      for (var item in response.data) {
        itemsList.add(
            HRHeadBar(
                deptId: item['DepartmentId'],
                deptName: item['departmentName'],
                deptDescp: item['description'],
                sucess: true,
                message: response.statusMessage!)
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

/// Get Company data
Future<List<HRClinical>> companyAllHrClinicApi(BuildContext context) async {
  List<HRClinical> itemsList = [];
  try {
    final response = await Api(context)
        .get(path: AllFromHrRepository.getEmployeeType());
    if (response.statusCode == 200 || response.statusCode == 201) {
      for (var item in response.data) {
        itemsList.add(
          HRClinical(
              employeeTypesId: item['employeeTypeId'],
              empType: item['employeeType'],
              abbrivation: item['abbreviation'],
              color: item['color'],
              ),
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
/// Get data by depart ment ID
Future<List<HRAllData>> getAllHrDeptWise(BuildContext context,int deptId) async {
  List<HRAllData> itemsList = [];
  try {
    final response = await Api(context)
        .get(path: AllFromHrRepository.getEmployeeTypeDeptWise(deptId: deptId));
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("ResponseList:::::${itemsList}");
      for (var item in response.data) {
        itemsList.add(
          HRAllData(
            deptID: item['DepartmentId'],
            employeeTypesId: item['employeeTypeId'],
            empType: item['employeeType'],
            abbrivation: item['abbreviation'],
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
///get by id
Future<HRGetEmpId> HrGetById(BuildContext context, int empId) async {
  var itemsList;
  try {
    final response = await Api(context)
        .get(path: AllFromHrRepository.getEmpTypeById(empId: empId));
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("ResponseList:::::${itemsList}");
      //for (var item in response.data) {
        itemsList =
          HRGetEmpId(empTypeId: response.data['employeeTypeId'],
              deptId: response.data['DepartmentId'],
            empType: response.data['employeeType'],
            abbrivation: response.data['abbreviation'],
            color: response.data['color']

        );
      //}
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

/// Add employee type data POST
Future<ApiData> addEmployeeTypePost(
    BuildContext context,
    int departmentId,
    String employeeType,
    String color,
    String abbreviation) async {
  try {
    var response = await Api(context).post(path:
    EstablishmentManagerRepository.addEmployeeTypePost(), data:
    {
      'DepartmentId':departmentId,
      'employeeType':employeeType,
      'color':"${color}",
      'abbreviation':abbreviation
    });
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Employee type Added");
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
///delete allfromHr Clinical
Future<ApiData> allfromHrDelete(
    BuildContext context,
    int employeeTypeId
    ) async {
  try {
    var response = await Api(context).delete(path:
    EstablishmentManagerRepository.deleteEmployeeTypes(
         employeeTypeId: employeeTypeId
    ));
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Hr Doc Deleted");
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

///patch
Future<ApiData> AllFromHrPatch(
    BuildContext context,
    int employeeTypeId,
    int deptId,
    String empType,
    String abbreviation,
    String color,
    ) async {
  try {
    var allData = {
      "DepartmentId": deptId,
      "employeeType": empType,
      "color": color,
      "abbreviation": abbreviation
    };
    print('All data ${allData}');
    var response = await Api(context).patch(path:
    AllFromHrRepository.patchHRType(
        empId : employeeTypeId,
    ), data: {
      "DepartmentId": deptId,
      "employeeType": empType,
      "color": color,
      "abbreviation": abbreviation
    });

    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Hr Doc updated");
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
    print("Error 11 $e");
    return ApiData(
        statusCode: 404, success: false, message: AppString.somethingWentWrong);
  }
}