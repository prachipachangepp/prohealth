import 'package:dio/dio.dart';
import 'dart:convert';

import 'package:prohealth/app/constants/app_config.dart';


class CompanyInsert {
  final Dio dio = Dio();
  String token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjMsImlhdCI6MTcxNzE1MzEzMSwiZXhwIjoxNzE3MTUzNDMxfQ.Dx10H7AwUsBOEYivnnz7XDYc_OEqoHF_UZw7ONPYY8s';
  ///POST
  Future<void> insertCompany(String name,String desc,String url,String address,String headOffice) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    var data = json.encode({
      // "Name": "saloni new",
      // "description": "development",
      // "url": "www.development",
      // "address": "pune",
      // "head_office_id": "pune"
      "Name": name,
      "description": desc,
      "url": url,
      "address": address,
      "head_office_id": headOffice
    });

    try {
      var response = await dio.request(
        '${AppConfig.endpoint}/Company/Insert',
       // 'http://54.245.136.133:3000/Company/Insert',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 201) {
        print(json.encode(response.data));
      } else {
        print(response.statusMessage);
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  ///GET company
  Future<void> fetchCompany() async {
    var headers = {
      'Authorization': 'Bearer $token'
    };

    var data = '''''';

    try {
      var response = await dio.request(
        '${AppConfig.endpoint}/Company',
        //'http://54.245.136.133:3000/Company',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        print(json.encode(response.data));
      } else {
        print(response.statusMessage);
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  ///GET Company id
  Future<void> fetchCompanyByID() async{
    var headers = {
      'Authorization': 'Bearer $token'
    };
    var data = '''''';
    var dio = Dio();
    var response = await dio.request(
      '${AppConfig.endpoint}/Company/4',
     // 'http://54.245.136.133:3000/Company/4',
      options: Options(
        method: 'GET',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      print(json.encode(response.data));
    }
    else {
      print(response.statusMessage);
    }
  }
}

