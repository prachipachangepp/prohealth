import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/data/api_data/api_data.dart';

import '../../../../../data/api_data/establishment_data/role_manager/role_manager_data.dart';
import '../../api.dart';
import '../../repository/establishment_manager/establishment_repository.dart';

Future<List<RoleManagerData>> roleManagerDataGet(BuildContext context) async {
  List<RoleManagerData> itemsData = [];
  try {
    final response = await Api(context)
        .get(path: EstablishmentManagerRepository.companyDepartment());
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(":::::LIST${response.data}");
      for (var item in response.data) {
        itemsData.add(RoleManagerData(
            deptID: item['DepartmentId'],
            deptName: item['departmentName'],
            description: item['description']));
      }
    } else {
      print("Api Role Manager Data Error");
    }
    return itemsData;
  } catch (e) {
    print("error${e}");
    return itemsData;
  }
}
///get emp type
Future<List<RoleManagerDepartmentEmpType>> roleManagerGetByDepartmentID(BuildContext context,
    int DepartmentId) async {
  List<RoleManagerDepartmentEmpType> itemsData = [];
  try {
    final response = await Api(context)
        .get(path: EstablishmentManagerRepository.companyDepartmentById(DepartmentId: DepartmentId));
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(":::::LIST${response.data}");
      for (var item in response.data) {
        itemsData.add(RoleManagerDepartmentEmpType(
            employeeTypeId: item['employeeTypeId'],
            DepartmentId: item['DepartmentId'],
            employeeType: item['employeeType'],
            color: item['color'],
            abbreviation: item['abbreviation'],));
      }
    } else {
      print("Api Role Manager Data Error");
    }
    return itemsData;
  } catch (e) {
    print("error${e}");
    return itemsData;
  }
}
/// GET
Future<List<ModuleMetaData>> roleMabagerMetaData(BuildContext context) async {
  List<ModuleMetaData> itemsData = [];
  try {
    final response = await Api(context)
        .get(path: EstablishmentManagerRepository.getRoalMetaData());
    if (response.statusCode == 200 || response.statusCode == 201) {
      for (var item in response.data) {
        itemsData.add(ModuleMetaData(
            appModuleMetaDataId: item['AppModuleMetaDataId'],
            mainModule: item['mainModule'],
            iconUrl: item['iconUrl'],
            sucess: true,
            message: response.statusMessage!));
        print("<<<<<<<<${itemsData}");
      }
    } else {
      print("Api Role Module Meta Data Manager Data Error");
    }
    return itemsData;
  } catch (e) {
    print("error${e}");
    return itemsData;
  }
}

/// POST
Future<ApiData> addSelectedModules(
    BuildContext context, int appModuleMetaDataId, int DeptId,int companyId, String officeId, int empTypeId) async {
  try {
    var response = await Api(context).post(path: EstablishmentManagerRepository.addAppRoleModulePost(),
        data:{
          "AppModuleMetaDataId": appModuleMetaDataId,
          "DepartmentId": DeptId,
          "CompanyId": companyId,
          "OfficeId": officeId,
          "EmployeeTypeId": empTypeId
        });
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Saved Data");
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
    print("Error 2");
    return ApiData(
        statusCode: 404, success: false, message: AppString.somethingWentWrong);
  }
}
