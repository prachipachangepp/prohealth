import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/services/api/api.dart';
import 'package:prohealth/app/services/api/repository/hr_module_repository/manage_emp/manage_emp_repo.dart';
import 'package:prohealth/app/services/token/token_manager.dart';
import 'package:prohealth/data/api_data/api_data.dart';
import '../../../../../../data/api_data/hr_module_data/manage/equipment_data.dart';

/// Get equipment
Future<List<EquipmentData>> getEquipement(
    BuildContext context,int employeeId) async {
  String convertIsoToDayMonthYear(String isoDate) {
    // Parse ISO date string to DateTime object
    DateTime dateTime = DateTime.parse(isoDate);

    // Create a DateFormat object to format the date
    DateFormat dateFormat = DateFormat('yyyy-MM-dd');

    // Format the date into "dd mm yy" format
    String formattedDate = dateFormat.format(dateTime);

    return formattedDate;
  }

  List<EquipmentData> itemsData = [];
  try {
    final response =
    await Api(context).get(path: ManageReposotory.getEquipement(employeeId: employeeId));
    if (response.statusCode == 200 || response.statusCode == 201) {
      for (var item in response.data) {
        String assignedFormattedDate =
        convertIsoToDayMonthYear(item['assignedDate']);
        itemsData.add(
            EquipmentData(
                empInventoryId: item['employeeInventoryId']??0,
                inventoryId: item['inventoryId']??0,
                assignedDate: assignedFormattedDate,
                employeeId: item['employeeId'],
                givenId: item['givenId'],
                inventoryTypeId: item['inventoryTypeId']??0,
                name: item['name'],
                createdAt: item['createdAt'] ?? "--"));
        itemsData.sort((a, b) => a.empInventoryId.compareTo(b.empInventoryId));
      }
    } else {
      print("Equipment");
    }
    return itemsData;
  } catch (e) {
    print("error${e}");
    return itemsData;
  }
}
/// Get dropdown inventory
Future<List<InventoryDropdownData>> getDropdownInventory(
    BuildContext context) async {
  List<InventoryDropdownData> itemsData = [];
  try {
    final companyId = await TokenManager.getCompanyId();
    final response =
    await Api(context).get(path: ManageReposotory.gerDropdownInventory(companyId: companyId));
    if (response.statusCode == 200 || response.statusCode == 201) {
      for (var item in response.data) {
        itemsData.add(InventoryDropdownData(
            inventoryId: item['inventoryId'],
            name: item['name'],
            qty: item['qty'],
            description: item['description'],
            companyId: item['companyId']));
      }
    } else {
      print("Equipment");
    }
    return itemsData;
  } catch (e) {
    print("error${e}");
    return itemsData;
  }
}

/// Equipement prefill data get
Future<EquipmentPrefillData> getPrefillEquipement(
    BuildContext context, int employeeId) async {
  String convertIsoToDayMonthYear(String isoDate) {
    // Parse ISO date string to DateTime object
    DateTime dateTime = DateTime.parse(isoDate);

    // Create a DateFormat object to format the date
    DateFormat dateFormat = DateFormat('MM-dd-yyyy');

    // Format the date into "dd mm yy" format
    String formattedDate = dateFormat.format(dateTime);

    return formattedDate;
  }

  var itemsData;
  try {
    final response =
    await Api(context).get(path: ManageReposotory.getEquipement(employeeId: employeeId));
    if (response.statusCode == 200 || response.statusCode == 201) {
      String assignedFormattedDate =
      convertIsoToDayMonthYear(response.data['assignedDate']);
      itemsData =
          EquipmentPrefillData(
              empInventoryId: response.data['employeeInventoryId'],
              inventoryId: response.data['inventoryId'],
              assignedDate: assignedFormattedDate,
              employeeId: response.data['employeeId'],
              givenId: response.data['givenId'],
              inventoryTypeId: response.data['inventoryTypeId'],
              name: response.data['name'],
              createdAt: response.data['createdAt'] ?? "--");

    } else {
      print("Equipment prefill");
    }
    return itemsData;
  } catch (e) {
    print("error${e}");
    return itemsData;
  }
}

/// add equipment
Future<ApiData> addEquipment(BuildContext context,
    int inventoryId,String assignedDate,int empId,String givenId,String inventoryTypeId,String name,
    ) async {
  try {
    var response = await Api(context).post(path: ManageReposotory.addEquipement(), data: {
      "inventoryId": inventoryId,
      "assignedDate": "${assignedDate}T00:00:00Z",
      "employeeId": empId,
      "givenId": givenId,
      "inventoryTypeId": inventoryTypeId,
      "name": name
    },);
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Equipment added");
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

/// Patch equipment
Future<ApiData> updateEquipmentPatch(BuildContext context,
    int empInventoryId,int inventoryId,String assignedDate,int empId,String givenId,int inventoryTypeId,String name,
    ) async {
  try {
    var response = await Api(context).patch(path: ManageReposotory.patchEquipement(empInventoryId: empInventoryId), data: {
      "inventoryId": inventoryId,
      "assignedDate": "${assignedDate}T00:00:00Z",
      "employeeId": empId,
      "givenId": givenId,
      "inventoryTypeId": inventoryTypeId,
      "name": name
    },);
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Equipment updated");
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
