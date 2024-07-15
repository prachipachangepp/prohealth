import 'package:flutter/cupertino.dart';

import '../../../../../../data/api_data/api_data.dart';
import '../../../../../../data/api_data/hr_module_data/add_employee/clinical.dart';
import '../../../api.dart';

import '../../../repository/hr_module_repository/add_employee/clinical.dart';



// ///ADD Employee Post API
// Future<ApiData> addEmployeeClinical(
//     BuildContext context,
//     String code,
//     int userId,
//     String firstName,
//     String lastName,
//     int dptID,
//     int emplyID,
//     String expritise,
//     int cityID,
//     int countryID,
//     int zoneID,
//     String ssnnBr,
//     String primeNo,
//     String secNo,
//     String workNo,
//     String regOfficeId,
//     String personalEmail,
//     String workEmail,
//     String address,
//     String dob,
//     String emgContact,
//     String coverage,
//     String employment,
//     String gender,
//     String status,
//     String service,
//     String imgUrl,
//     String resumeUrl,
//     int companyID,
//     String onboardingStatus,
//     String
//
//
//
//
//
//     // int employeeId,
//     // String graduate,
//     // String degree,
//     // String major,
//     // String city,
//     // String college,
//     // String phone,
//     // String state
//     ) async {
//   try {
//     var response = await Api(context).post(
//       path: HRModuleAEClinicalRepository.postAddEmployeeClinical(),
//       data: {
//         "employeeId": employeeId,
//         "graduate": graduate,
//         "degree": degree,
//         "major": major,
//         "city": city,
//         "college": college,
//         "phone": phone,
//         "state": state
//       },
//     );
//     if (response.statusCode == 200 || response.statusCode == 201) {
//       print("Education added");
//       // orgDocumentGet(context);
//       return ApiData(
//           statusCode: response.statusCode!,
//           success: true,
//           message: response.statusMessage!);
//     } else {
//       print("Error 1");
//       return ApiData(
//           statusCode: response.statusCode!,
//           success: false,
//           message: response.data['message']);
//     }
//   } catch (e) {
//     print("Error $e");
//     return ApiData(
//         statusCode: 404, success: false, message: AppString.somethingWentWrong);
//   }
// }


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
    int companyId

    ) async {
  List<AEClinicalService> itemsList = [];
  try {
    final response = await Api(context).get(
        path:
            HRModuleAEClinicalRepository.getEmplyServiceRadiobutton(companyID: companyId));
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