import 'package:flutter/cupertino.dart';

import '../../../../../../data/api_data/hr_module_data/add_employee/clinical.dart';
import '../../../api.dart';
import '../../../repository/establishment_manager/all_from_hr_repository.dart';
import '../../../repository/hr_module_repository/add_employee/clinical.dart';

///Discipline dropdown get Api
Future<List<AEClinicalDiscipline>> HrAddEmplyClinicalDisciplinApi(
    BuildContext context, int deptID) async {
  List<AEClinicalDiscipline> itemsList = [];
  try {
    final response = await Api(context)
        .get(path: HRModuleAEClinicalRepository.getEmployeeTypeDept(deptID));
    if (response.statusCode == 200 || response.statusCode == 201) {
      for (var item in response.data) {
        itemsList.add(
          AEClinicalDiscipline(
            employeeTypesId: item['employeeTypeId'],
            empType: item['employeeType'],
            deptID: item['DepartmentId'],
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

///city dropdown get Api
Future<List<AEClinicalCity>> HrAddEmplyClinicalCityApi(
  BuildContext context,
  // int deptID
) async {
  List<AEClinicalCity> itemsList = [];
  try {
    final response = await Api(context).get(
        path: HRModuleAEClinicalRepository.getAddEmployeeTypeCity(
            // deptID
            ));
    if (response.statusCode == 200 || response.statusCode == 201) {
      for (var item in response.data) {
        itemsList.add(AEClinicalCity(
          cityName: item['cityName'],
          cityID: item['city_id'],
          state: item['state'],
          country: item['Country'],
        ));
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

///Reporting Office DropDown get api
Future<List<AEClinicalReportingOffice>> HrAddEmplyClinicalReportingOfficeApi(
    BuildContext context, int companyID) async {
  List<AEClinicalReportingOffice> itemsList = [];
  try {
    final response = await Api(context).get(
        path:
            HRModuleAEClinicalRepository.getAddEmplyReportingOffice(companyID));
    if (response.statusCode == 200 || response.statusCode == 201) {
      for (var item in response.data) {
        itemsList.add(
          AEClinicalReportingOffice(
              companyOfficeID: item['company_Office_id'],
              companyID: item['company_id'],
              officeID: item['office_id'],
              primNo: item['primary_phone'],
              secNo: item['secondary_phone'],
              primeFax: item['primary_fax'],
              secFax: item['secondary_fax'],
              alterNo: item['alternative_phone'],
              email: item['email'],
              name: item['name'],
              address: item['address']),
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

///zone drop down
Future<List<AEClinicalZone>> HrAddEmplyClinicalZoneApi(
  BuildContext context,
) async {
  List<AEClinicalZone> itemsList = [];
  try {
    final response = await Api(context).get(
        path: HRModuleAEClinicalRepository.getAddEmplyZone(
            //   companyID: companyID, officeID:officeID, countyID: countyID,
            // pageNo: pageNo,
            // rowsNo: rowsNo,
            ));
    if (response.statusCode == 200 || response.statusCode == 201) {
      for (var item in response.data) {
        itemsList.add(
          AEClinicalZone(
            county: item['county'],
            countyID: item['county_id'],
            zoneID: item['zone_id'],
            zoneName: item['zoneName'],
            zipCode: item['zipcodes'],
            cities: item['cities'],
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

// int companyID,
// int officeID,
// int countyID,
// int pageNo,
// int rowsNo,
/// service radio button Get Api
Future<List<AEClinicalService>> HrAddEmplyClinicalServiceRadioButtonApi(
    BuildContext context,

    ) async {
  List<AEClinicalService> itemsList = [];
  try {
    final response = await Api(context).get(
        path:
            HRModuleAEClinicalRepository.getAddEmplyService(

            ));
    if (response.statusCode == 200 || response.statusCode == 201) {
      for (var item in response.data) {
        itemsList.add(
          AEClinicalService(
              officeServiceID: item['Office_service_id'],
              companyID: item['company_id'],
              officeID: item['office_id'],
              serviceName: item['service_name'],
              npiNo: item['npi_number'],
              medicareProviderID: item['medicare_provider_id'],
              hecoNoID: item['hco_num_id']),
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
// companyID: companyID
// int companyID