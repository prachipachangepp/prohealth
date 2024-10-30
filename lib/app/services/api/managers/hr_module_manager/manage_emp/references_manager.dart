import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/services/api/api.dart';
import 'package:prohealth/app/services/api/repository/hr_module_repository/manage_emp/manage_emp_repo.dart';
import 'package:prohealth/data/api_data/api_data.dart';
import 'package:prohealth/data/api_data/hr_module_data/manage/references_data.dart';

Future<List<ReferenceData>> getReferences(
    BuildContext context, int employeeId) async {
  List<ReferenceData> itemsData = [];
  try {
    final response = await Api(context).get(
        path:
            ManageReposotory.referenceByemployeeIdGet(employeeId: employeeId, approveOnly: 'no'));
    if (response.statusCode == 200 || response.statusCode == 201) {
      for (var item in response.data) {
        itemsData.add(ReferenceData(
            referenceId: item['referenceId'],
            association: item['association'],
            comment: item['comment'],
            company: item['company'],
            email: item['email'],
            mobNumber: item['mob'],
            employeeId: item['employeeId'],
            name: item['name'],
            references: item['references'],
            title: item['title'],
            approve: item['approve'], sucess: true, message: response.statusMessage!));
        itemsData.sort((a, b) => a.referenceId.compareTo(b.referenceId));
      }
    } else {
      print("References List");
    }
    return itemsData;
  } catch (e) {
    print("error${e}");
    return itemsData;
  }
}

/// Add reference
Future<ApiData> addReferencePost(BuildContext context,String association,String comment,String company,
    String email,int employeeId,String mob,String name,String references,String title) async {
  try {
    var response = await Api(context).post(path: ManageReposotory.addReferences(), data: {
      "association": association,
      "comment": comment,
      "company": company,
      "email": email,
      "employeeId": employeeId,
      "mob": mob,
      "name": name,
      "references": references,
      "title": title
    },);
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("reference Added");
      var referenceRes = response.data;
      int referenceId = referenceRes['referenceId'];
      // orgDocumentGet(context);
      return ApiData(
          statusCode: response.statusCode!,
          success: true,
          message: response.statusMessage!,
          referenceId: referenceId);
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

/// Update rference
Future<ApiData> updateReferencePatch(BuildContext context,int referenceId,String association,String comment,String company,
    String email,int employeeId,String mob,String name,String references,String title) async {
  try {
    var response = await Api(context).patch(path: ManageReposotory.updateReferences(referenceId: referenceId), data: {
      "association": association,
      "comment": comment,
      "company": company,
      "email": email,
      "employeeId": employeeId,
      "mob": mob,
      "name": name,
      "references": references,
      "title": title
    },);
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("reference updated");
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

/// Get prefill
Future<ReferencePrefillData> getPrefillReferences(
    BuildContext context, int referenceId) async {
  var itemsData;
  try {
    final response = await Api(context).get(
        path:
        ManageReposotory.updateReferences(referenceId: referenceId));
    if (response.statusCode == 200 || response.statusCode == 201) {
        itemsData = ReferencePrefillData(
            referenceId: response.data['referenceId'],
            association: response.data['association'],
            comment: response.data['comment'],
            company: response.data['company'],
            email: response.data['email'],
            mobNumber: response.data['mob'],
            employeeId: response.data['employeeId'],
            name: response.data['name'],
            references: response.data['references'],
            title: response.data['title'],
            approve: response.data['approve']??false, sucess: true, message: response.statusMessage!);
    } else {
      print("References Prefill data");
    }
    return itemsData;
  } catch (e) {
    print("error${e}");
    return itemsData;
  }
}
/// Reject reference
Future<ApiData> rejectReferencePatch(BuildContext context, int referenceId) async {
  try {
    var response = await Api(context).patch(path: ManageReposotory.rejectReferences(referenceId: referenceId), data: {},);
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Reject reference");
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

/// Approve reference
Future<ApiData> approveReferencePatch(BuildContext context, int referenceId) async {
  try {
    var response = await Api(context).patch(path: ManageReposotory.approveReferences(referenceId: referenceId), data: {},);
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Approve reference");
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