import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:prohealth/app/model/company_data_model.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/services/api/api.dart';
import 'package:prohealth/app/services/api/repository/establishment_manager/establishment_repository.dart';
import 'package:prohealth/data/api_data/api_data.dart';

/* Establishment manager API */

/// Get Company
Future<List<CompanyModel>> companyAllApi(BuildContext context) async {
  List<CompanyModel> itemsList = [];
  try {
    final response = await Api(context)
        .get(path: EstablishmentManagerRepository.companyAll());
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("ResponseList:::::${itemsList}");
      for(var item in response.data){
        itemsList.add(
          CompanyModel(
            name: item['Name'],
            address: item['address'],
              officeName: item['head_office_id']
          ),
        );

        //itemsList.add(companyModel);
      }
      print("ResponseList:::::${itemsList}");
        // CompanyModel(
        //   name: response.data['Name'],
        //   address: response.data['address'],
        //   );
    } else {
      print('Api Error');
      //return itemsList;
    }
    print("Response:::::${response}");
    return itemsList;
  } catch (e) {
    print("Error $e");
    return itemsList;
  }
}

/// Get company by id
Future<CompanyModel> companyByIdApi(BuildContext context, int compantId) async {
  try {
    var response = await Api(context).get(
        path: EstablishmentManagerRepository.companyById(companyId: compantId));
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Company by id ::: ${response}");
      return CompanyModel(
          id: response.data['company_id']);
    } else {
      return CompanyModel();
    }
  } catch (e) {
    print("Error $e");
    return CompanyModel();
  }
}

/// Get company details
Future<CompanyModel> companyDetailsApi(BuildContext context, int id) async {
  try {
    var response = await Api(context).get(
        path: EstablishmentManagerRepository.companyDetails(companyId: id));
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Company Details id ::: ${response}");
      return CompanyModel(
          id: response.data['company_id']);
    } else {
      return CompanyModel();
    }
  } catch (e) {
    print("Error $e");
    return CompanyModel();
  }
}



/// Get upload company logo
Future<ApiData> uploadCompanyLogoApi(
    BuildContext context, int id, String type) async {
  try {
    var response = await Api(context).post(
        path: EstablishmentManagerRepository.uploadCompanyLogo(
            companyId: id, type: type),
        data: {
          'company_id': id,
          'type': type,
        });
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Saved request");
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
