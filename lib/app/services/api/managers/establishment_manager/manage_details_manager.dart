import 'package:flutter/material.dart';
import '../../../../../data/api_data/api_data.dart';
import '../../../../../data/api_data/establishment_data/ci_manage_button/manage_corporate_conpliance_data.dart';
import '../../../../../data/api_data/establishment_data/ci_manage_button/manage_details_data.dart';
import '../../../../resources/const_string.dart';
import '../../api.dart';
import '../../repository/establishment_manager/establishment_repository.dart';

///get manage detail
Future<List<ManageDetails>> companyDetailGetAll(BuildContext context, int companyID, int officeId) async {
  List<ManageDetails> itemsList = [];
  try {
    final response = await Api(context)
        .get(path: EstablishmentManagerRepository.getManageDetails(companyID: companyID, officeId: officeId));
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("ResponseList:::::${itemsList}");
      for (var item in response.data) {
        itemsList.add(
          ManageDetails(
              officeName: item['company_id'],
              priNumber: item['name'],
              secNumber: item['address'],
              alternateNumber: item['head_office_id'],
              address: item['head_office_id'],
              email: item['head_office_id']),
        );
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

///manage detail service post
Future<ApiData> addNewService(BuildContext context, String hcoNum, medicareId, npiNum,) async {
  try {
    var response = await Api(context)
        .post(path: EstablishmentManagerRepository.companyOfficeServicePost(),
        data: {
      'hco_num_id': hcoNum,
      'medicare_provider_id': medicareId,
      'npi_number': npiNum,
    });
    print('::::$response');
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

///manage corporate compliance flow get
Future<List<ManageCorporateConplianceData>> corporateCompGetAllApi(BuildContext context, int docTypeId,) async {
  List<ManageCorporateConplianceData> itemsList = [];
  try {
    final response = await Api(context)
        .get(path: EstablishmentManagerRepository.corporateGetDocType(
      // docTypeId: docTypeId,
    ));
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("ResponseList:::::${itemsList}");
      for (var item in response.data) {
        itemsList.add(
          ManageCorporateConplianceData(
              id: item['company_id'],
              docName: item['name'],),
        );
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

