import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:prohealth/app/services/api_sm/company_identity/add_doc_company_data.dart';

import '../../../../constants/app_config.dart';
import 'get_company_by_id_data.dart';

class CompanyIdentityManager {
  Dio dio = Dio();

  ///get shows response in terminal
  //  Future<void> getCompanyById() async {
  //    var dio = Dio();
  //    var response = await dio.request(
  //      '${AppConfig.endpoint}/establishment/company/1',
  //     // 'https://wwx3rebc2b.execute-api.us-west-1.amazonaws.com/dev/serverlessSetup/establishment/company/1',
  //      options: Options(
  //        method: 'GET',
  //      ),
  //    );
  //
  //    if (response.statusCode == 200) {
  //      print(json.encode(response.data));
  //    }
  //    else {
  //      print(response.statusMessage);
  //    }
  //  }

  ///copy try pheonix
  // Future<List<CompanyDataGet>> getCompanyById() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   String? token = prefs.getString('access_token');
  //   var dio = Dio();
  //   var response = await dio.request(
  //     '${AppConfig.endpoint}/establishment/company/1',
  //    // 'https://wwx3rebc2b.execute-api.us-west-1.amazonaws.com/dev/serverlessSetup/establishment/company/1',
  //     options: Options(
  //       method: 'GET',
  //     ),
  //   );
  //
  //   if (response.statusCode == 200) {
  //     var data = response.data;
  //     List<dynamic> list = data;
  //     List<CompanyDataGet> companydatalist = [];
  //     for(var a in list){
  //       companydatalist.add(CompanyDataGet.fromJson(a));
  //     }
  //     return companydatalist;
  //     //print(json.encode(response.data));
  //   }
  //   else {
  //     print(response.statusMessage);
  //     return [];
  //   }
  // }

  ///new shows null error get api
  Future<CompanyDataGet> getCompanyById() async {
    try {
      final response = await dio.request(
        '${AppConfig.endpoint}/establishment/company/1',
        // 'https://wwx3rebc2b.execute-api.us-west-1.amazonaws.com/dev/serverlessSetup/establishment/company/1',
        options: Options(
          method: 'GET',
        ),
      );

      if (response.statusCode == 200) {
        return CompanyDataGet.fromJson(response.data);
      } else {
        throw Exception('Failed to load company data');
      }
    } catch (e) {
      throw Exception('Failed to load company data: $e');
    }
  }

  ///post api
  Future outAddCompany() async {
    var headers = {'Content-Type': 'application/json'};
    var data = json.encode({
      "company_id": "1",
      "name": "ABC Healthcare",
      "description": "A healthcare company Test",
      "url": "https://www.abchealthcare.com",
      "logo": {
        "main": "https://www.abchealthcare.com/logo.png",
        "app": "https://www.abchealthcare.com/app_logo.png",
        "web": "https://www.abchealthcare.com/web_logo.png"
      },
      "contact": {
        "phones": [
          {"primary": "+1-555-1234567", "secondary": "+1-555-1234567"}
        ],
        "fax": ["+1-555-1234567", "+1-555-9876543"],
        "email": "info@abchealthcare.com"
      },
      "address": "1234 Elm Street, Suite 567, Springfield, IL 62704",
      "head_office_id": "office_1",
      "offices": [
        {
          "id": "office_1",
          "name": "Head Office",
          "address": "1234 Elm Street, Suite 567, Springfield, IL 62704",
          "email": "info@abchealthcare.com",
          "phones": ["+1-555-1234567"],
          "zones": ["Zone 1", "Zone 2"],
          "services": [
            {
              "service_name": "Cardiology",
              "service_id": "cardio_123",
              "npi_number": "1234567890",
              "medicare_provider_id": "MPID123",
              "hco_num_id": "65687"
            },
            {
              "service_name": "Dermatology",
              "service_id": "derma_456",
              "npi_number": "0987654321",
              "medicare_provider_id": "MPID456",
              "hco_num_id": "65687"
            }
          ],
          "documents": [
            {
              "corporate_docs": {
                "licenses": [
                  {
                    "doc_id": "",
                    "doc_name": "",
                    "doc_data": [
                      {
                        "created_at": "2023-04-11T16:27:17.666Z",
                        "url":
                            "https://documents-hr-module.s3.us-west-1.amazonaws.com/1681230437493123",
                        "expiry": {"type": 2, "date": "", "reminder": 32}
                      }
                    ]
                  }
                ]
              }
            },
            {
              "insurance_contracts": {
                "no_subtype": [
                  {
                    "doc_id": "",
                    "doc_name": "",
                    "doc_data": [
                      {
                        "created_at": "2023-04-11T16:27:17.666Z",
                        "url":
                            "https://documents-hr-module.s3.us-west-1.amazonaws.com/1681230437493123",
                        "expiry": {"type": 2, "date": "", "reminder": 32}
                      }
                    ]
                  }
                ]
              },
              "vendor_contracts": {},
              "policies": {}
            }
          ]
        },
        {
          "id": "office_2",
          "name": "Branch Office",
          "address": "5678 Oak Street, Suite 890, Chicago, IL 60601",
          "email": "info@abchealthcare.com",
          "phones": ["+1-555-9876543"],
          "zones": ["Zone 3"],
          "services": [
            {
              "service_name": "Pediatrics",
              "service_id": "pedi_789",
              "npi_number": "9876543210",
              "medicare_provider_id": "MPID789",
              "hco_num_id": "65687"
            }
          ]
        }
      ]
    });
    var dio = Dio();
    var response = await dio.request(
      'https://wwx3rebc2b.execute-api.us-west-1.amazonaws.com/dev/serverlessSetup/establishment/company',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      print(json.encode(response.data));
    } else {
      print(response.statusMessage);
    }
  }

  ///put api addDocToCompany
  Future<void> addDocCompany(Company company) async {
    var headers = {'Content-Type': 'application/json'};
    var data = json.encode({
      "company_id": "1",
      "name": "ABC Healthcare",
      "description": "A healthcare company Test",
      "url": "https://www.abchealthcare.com",
      "logo": {
        "main": "https://www.abchealthcare.com/logo.png",
        "app": "https://www.abchealthcare.com/app_logo.png",
        "web": "https://www.abchealthcare.com/web_logo.png"
      },
      "contact": {
        "phones": [
          {"primary": "+1-555-1234567", "secondary": "+1-555-1234567"}
        ],
        "fax": ["+1-555-1234567", "+1-555-9876543"],
        "email": "info@abchealthcare.com"
      },
      "address": "1234 Elm Street, Suite 567, Springfield, IL 62704",
      "head_office_id": "office_1",
      "offices": [
        {
          "id": "office_1",
          "name": "Head Office",
          "address": "1234 Elm Street, Suite 567, Springfield, IL 62704",
          "email": "info@abchealthcare.com",
          "phones": ["+1-555-1234567"],
          "zones": ["Zone 1", "Zone 2"],
          "services": [
            {
              "service_name": "Cardiology",
              "service_id": "cardio_123",
              "npi_number": "1234567890",
              "medicare_provider_id": "MPID123",
              "hco_num_id": "65687"
            },
            {
              "service_name": "Dermatology",
              "service_id": "derma_456",
              "npi_number": "0987654321",
              "medicare_provider_id": "MPID456",
              "hco_num_id": "65687"
            }
          ],
          "documents": [
            {
              "corporate_docs": {
                "licenses": [
                  {
                    "doc_id": "",
                    "doc_name": "",
                    "doc_data": [
                      {
                        "created_at": "2023-04-11T16:27:17.666Z",
                        "url":
                            "https://documents-hr-module.s3.us-west-1.amazonaws.com/1681230437493123",
                        "expiry": {"type": 2, "date": "", "reminder": 32}
                      }
                    ]
                  }
                ]
              }
            },
            {
              "insurance_contracts": {
                "no_subtype": [
                  {
                    "doc_id": "",
                    "doc_name": "",
                    "doc_data": [
                      {
                        "created_at": "2023-04-11T16:27:17.666Z",
                        "url":
                            "https://documents-hr-module.s3.us-west-1.amazonaws.com/1681230437493123",
                        "expiry": {"type": 2, "date": "", "reminder": 32}
                      }
                    ]
                  }
                ]
              },
              "vendor_contracts": {},
              "policies": {}
            }
          ]
        },
        {
          "id": "office_2",
          "name": "Branch Office 2",
          "address": "5678 Oak Street, Suite 890, Chicago, IL 60601",
          "email": "info@abchealthcare.com",
          "phones": ["+1-555-9876543"],
          "zones": ["Zone 3"],
          "services": [
            {
              "service_name": "Pediatrics",
              "service_id": "pedi_789",
              "npi_number": "9876543210",
              "medicare_provider_id": "MPID789",
              "hco_num_id": "65687"
            }
          ]
        }
      ]
    });
    var dio = Dio();
    var response = await dio.request(
      'https://wwx3rebc2b.execute-api.us-west-1.amazonaws.com/dev/serverlessSetup/establishment/company/1/office_1/1',
      options: Options(
        method: 'PUT',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      print(json.encode(response.data));
    } else {
      print(response.statusMessage);
    }
  }
}
