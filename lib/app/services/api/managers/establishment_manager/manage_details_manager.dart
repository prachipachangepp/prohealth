import 'package:flutter/material.dart';
import 'package:prohealth/app/services/token/token_manager.dart';

import '../../../../../data/api_data/api_data.dart';
import '../../../../../data/api_data/establishment_data/ci_manage_button/manage_corporate_conpliance_data.dart';
import '../../../../../data/api_data/establishment_data/ci_manage_button/manage_details_data.dart';
import '../../../../resources/const_string.dart';
import '../../api.dart';
import '../../repository/establishment_manager/establishment_repository.dart';

///get manage detail
Future<ManageDetails> companyDetailGetAll(
    BuildContext context, String officeId) async {
  var itemsData;
  List<DetailsServiceData> detailService = [];
  try {
    final companyID =await TokenManager.getCompanyId();
    final response = await Api(context).get(
        path: EstablishmentManagerRepository.getManageDetails(
            companyID: companyID, officeId: officeId));
    print(response);
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
          message: response.statusMessage!,
          primaryFax: response.data['officeDetail']["primary_fax"],
          secondaryFax: response.data['officeDetail']["secondary_fax"]);
      for(var items in response.data['serviceList']){
        detailService.add(DetailsServiceData(
            CompanyId: items['company_id'],
            officeId: items['office_id'],
            serviceName: items['service_name'],
            serviceId: items['service_id'],
            npiNum: items['npi_number'],
            medicareNum: items['medicare_provider_id'],
            hcoNum: items['hco_num_id'],
            OfficeServiceId: items['Office_service_id']));

      }
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
Future<ApiData> addNewService(
  BuildContext context,
  String hcoNum,
  medicareId,
  npiNum,
) async {
  try {
    var response = await Api(context).post(
        path: EstablishmentManagerRepository.companyOfficeServicePost(),
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
Future<List<GetManageDetailsHeadData>> getManageCorporateComp(
  BuildContext context,
) async {
  List<GetManageDetailsHeadData> itemsList = [];
  try {
    final response = await Api(context)
        .get(path: EstablishmentManagerRepository.getManageCorporateComp());
    if (response.statusCode == 200 || response.statusCode == 201) {
      // print("Org Document response:::::${itemsList}");
      print("1");
      for (var item in response.data) {
        itemsList.add(
          GetManageDetailsHeadData(
              id: item['document_type_id'],
              docName: item['document_type'],
              sucess: true,
              message: response.statusMessage!),
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

///company-office patch
Future<ApiData> patchCompanyOffice(BuildContext context, int company_Office_id,
    String office_id,String primary_phone,String secondary_phone, String primary_fax,
    String secondary_fax, String alternative_phone, String email,String name,String address) async {
  try{
    var companyId = await TokenManager.getCompanyId();
    var response = await Api(context).patch(path: EstablishmentManagerRepository.companyOfficepatch(company_Office_id: company_Office_id),
        data: {
            "company_id": companyId,
            "office_id": office_id,
            "primary_phone": primary_phone,
            "secondary_phone": secondary_phone,
            "primary_fax": primary_fax,
            "secondary_fax": secondary_fax,
            "alternative_phone": alternative_phone,
            "email": email,
            "name": name,
            "address": address

        });

    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Company Updated");
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
  }
  catch (e) {
    print("Error $e");
    return ApiData(
        statusCode: 404, success: false, message: AppString.somethingWentWrong);
  }
}

///company office service patch
Future<ApiData> patchCompanyOfficeService(BuildContext context, int OfficeServiceId,
    String office_id,String service_name,String service_id, String npi_number,
    String medicare_provider_id, String hco_num_id,) async {
  try{
    var companyId = await TokenManager.getCompanyId();
    var response = await Api(context).patch(path: EstablishmentManagerRepository.companyofficeservicepatch(Office_service_id: OfficeServiceId),
        data: {
          "company_id": companyId,
          "office_id": office_id,
          "service_name": service_name,
          "service_id": service_id,
          "npi_number": npi_number,
          "medicare_provider_id": medicare_provider_id,
          "hco_num_id": hco_num_id
        });

    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Service Updated");
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
  }
  catch (e) {
    print("Error $e");
    return ApiData(
        statusCode: 404, success: false, message: AppString.somethingWentWrong);
  }
}
