import 'package:flutter/material.dart';
import '../../../../../data/api_data/api_data.dart';
import '../../../../../data/api_data/establishment_data/ci_manage_button/manage_corporate_conpliance_data.dart';
import '../../../../../data/api_data/establishment_data/ci_manage_button/manage_details_data.dart';
import '../../../../resources/const_string.dart';
import '../../api.dart';
import '../../repository/establishment_manager/establishment_repository.dart';

///get manage detail
Future<ManageDetails> companyDetailGetAll(BuildContext context, int companyID, String officeId) async {
  var itemsData;
  try {
    final response = await Api(context)
        .get(path: EstablishmentManagerRepository.getManageDetails(companyID: companyID, officeId: officeId));
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Office details response<<::${itemsData}");
      // for (var item in response.data['officeDetail']) {
        itemsData = ManageDetails(
            officeName: response.data['officeDetail']['name'],
            priNumber: response.data['officeDetail']['primary_phone'],
            secNumber: response.data['officeDetail']['secondary_phone'],
            alternateNumber: response.data['officeDetail']['alternative_phone'],
            address: response.data['officeDetail']['address'],
            email: response.data['officeDetail']['email'],
            officeID: response.data['officeDetail']["office_id"],
            sucess: true,
            message: response.statusMessage!);
      // }
  // );
        // itemsList.add(
        //   ManageDetails(
        //       officeName: item['name'],
        //       priNumber: item['primary_phone'],
        //       secNumber: item['secondary_phone'],
        //       alternateNumber: item['alternative_phone'],
        //       address: item['address'],
        //       email: item['email'],
        //       officeID: item["office_id"],
        //       sucess: true,
        //       message: response.statusMessage!),
        // );
      print("Office details response:::::${itemsData}");
      // CompanyModel(
      //   name: response.data['Name'],
      //   address: response.data['address'],
      //   );
    } else {
      print('Api Error');
      //return itemsList;
    }
    return itemsData;
  } catch (e) {
    print("Error $e");
    return itemsData;
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
Future<List<GetManageDetailsHeadData>> getManageCorporateComp(BuildContext context,) async {
  List<GetManageDetailsHeadData> itemsList = [];
  try {
    final response = await Api(context)
        .get(path: EstablishmentManagerRepository.getManageCorporateComp(
    ));
    if (response.statusCode == 200 || response.statusCode == 201) {
      // print("Org Document response:::::${itemsList}");
      print("1");
      for(var item in response.data){
        itemsList.add(
          GetManageDetailsHeadData(
              id: item['document_type_id'],
              docName: item['document_type'],
              sucess: true, message: response.statusMessage!
          ),
        );
      }
      // print("Org Document response:::::${itemsList}");
    } else {
      print('Ci Policies Pr Api Error');
      return itemsList;
    }
    // print("Org response:::::${response}");
    return itemsList;
  } catch (e) {
    print("Error $e");
    return itemsList;
  }
}

