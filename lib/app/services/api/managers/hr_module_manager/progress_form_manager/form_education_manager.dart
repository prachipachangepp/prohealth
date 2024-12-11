import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prohealth/app/services/api/api_offer.dart';
import 'package:prohealth/app/services/base64/encode_decode_base64.dart';

import '../../../../../../data/api_data/api_data.dart';
import '../../../../../../data/api_data/hr_module_data/progress_form_data/form_education_data.dart';
import '../../../../../resources/const_string.dart';
import '../../../api.dart';
import '../../../repository/hr_module_repository/form_repository/form_general_repo.dart';

class FormEducationManager {
  ///post api
  Future<ApiDataRegister> posteducationscreen(
    BuildContext context,
    int employeeId,
    String graduate,
    String degree,
    String major,
    String city,
    String college,
    String phone,
    String state,
    String country,
    String startDate,
  ) async {
    try {
      var response = await ApiOffer(context).post(
        path: ProgressBarRepository.posteducationscreen(),
        data: {
          "employeeId": employeeId,
          "graduate": graduate,
          "degree": degree,
          "major": major,
          "city": city,
          "college": college,
          "phone": phone,
          "state": state,
          "country": country,
          "startDate": "${startDate}T00:00:00Z"
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = response.data;
        var educationId = data['employeeId'];
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(content: Text("Education data saved"),backgroundColor: Colors.green,),
        // );

        print("education Added");

        // orgDocumentGet(context);
        return ApiDataRegister(
            statusCode: response.statusCode!,
            success: true,
            message: response.statusMessage!,
            educationId: educationId);
      } else {
        print("Error 1");
        return ApiDataRegister(
            statusCode: response.statusCode!,
            success: false,
            message: response.data['message']);
      }
    } catch (e) {
      print("Error $e");
      return ApiDataRegister(
          statusCode: 404,
          success: false,
          message: AppString.somethingWentWrong);
    }
  }


  /// get prifillapi
  // Future<ApiDataRegister> getEmployeeEducationForm(
  //     BuildContext context,
  //      int employeeID,
  //
  //
  //    ) async {
  //   try {
  //     var response = await ApiOffer(context).get(
  //       path:  ProgressBarRepository().getEmployeeByEmpID( employeeID: employeeID )
  //
  //
  //     );
  //     print("::::::::=>${response}");
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       print("Education updates");
  //       // orgDocumentGet(context);
  //       return ApiDataRegister(
  //           statusCode: response.statusCode!,
  //           success: true,
  //           message: response.statusMessage!);
  //     } else {
  //       print("Error 1");
  //       return ApiDataRegister(
  //           statusCode: response.statusCode!,
  //           success: false,
  //           message: response.data['message']);
  //     }
  //   } catch (e) {
  //     print("Error $e");
  //     return ApiDataRegister(
  //         statusCode: 404, success: false, message: AppString.somethingWentWrong);
  //   }
  // }

  ///patch api

// Patch education
  Future<ApiDataRegister> updateEmployeeEducationForm(
      BuildContext context,
      int educationId,
      int employeeId,
      String graduate,
      String degree,
      String major,
      String city,
      String college,
      String phone,
      String state,
      String country,
      String startDate) async {
    try {
      var response = await ApiOffer(context).patch(
        path: ProgressBarRepository.patchEmployeeDucationForm(
            educationId: educationId),
        data: {
          "employeeId": employeeId,
          "graduate": graduate,
          "degree": degree,
          "major": major,
          "city": city,
          "college": college,
          "phone": phone,
          "state": state,
          "country": country,
          "startDate": "${startDate}T00:00:00Z"
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Education updates");
        // orgDocumentGet(context);
        return ApiDataRegister(
            statusCode: response.statusCode!,
            success: true,
            message: response.statusMessage!);
      } else {
        print("Error 1");
        return ApiDataRegister(
            statusCode: response.statusCode!,
            success: false,
            message: response.data['message']);
      }
    } catch (e) {
      print("Error $e");
      return ApiDataRegister(
          statusCode: 404,
          success: false,
          message: AppString.somethingWentWrong);
    }
  }

  ///
  ///

}

Future<List<EducationDataForm>> getEmployeeEducationForm(
    BuildContext context, int employeeId) async {
  String convertIsoToDayMonthYear(String isoDate) {
    // Parse ISO date string to DateTime object
    DateTime dateTime = DateTime.parse(isoDate);

    // Create a DateFormat object to format the date
    DateFormat dateFormat = DateFormat('yyyy-MM-dd');

    // Format the date into "dd mm yy" format
    String formattedDate = dateFormat.format(dateTime);

    return formattedDate;
  }

//var itemList ;
  List<EducationDataForm> itemsData = [];
  try {
    final response = await ApiOffer(context).get(
        path:
            ProgressBarRepository.getEmployeeByEmpID(employeeID: employeeId));
    if (response.statusCode == 200 || response.statusCode == 201) {
      for (var item in response.data) {
        //String startDateFormattedDate = item['startDate'] == null ? "--" :convertIsoToDayMonthYear(item['expDate']);
        //String issueFormattedDate = convertIsoToDayMonthYear(item['issueDate']);
        itemsData.add(EducationDataForm(
          docName: item['documentName'],
          educationID: item['educationId'],
          empId: item['employeeId'],
          graduate: item['graduate'],
          degree: item['degree'],
          major: item['major'],
          city: item['city'],
          college: item['college'],
          phone: item['phone'],
          state: item['state'],
          approved: item['approved'],
          // sucess: true,
          // message: response.statusMessage!,
          country: item['country'] ?? "__",
          startDate: item['startDate'] ?? "--",
        ));
        // itemsData.sort((a, b) => a.educationId.compareTo(b.educationId));
      }
    } else {
      print("Employee Education");
    }
    return itemsData;
  } catch (e) {
    print("error${e}");
    return itemsData;
  }
}
Future<List<EduactionDegree>> getDegreeDropDown(
    BuildContext context,) async {
  List<EduactionDegree> itemsList = [];
  try {
    final response = await ApiOffer(context).get(
        path: ProgressBarRepository.getEmployeeDegreeDropDown());
    if (response.statusCode == 200 || response.statusCode == 201) {
      for (var item in response.data) {
        itemsList.add(EduactionDegree(
          degreeId: item['degreeId'],
          degree: item['degree'],
          companyId: item['companyId'],
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
Future<ApiDataRegister> uploadEducationDocument(
    BuildContext context,
    int educationId,
    dynamic documentFile,
    String documentName,
    ) async {
  try {
    var document = await AppFilePickerBase64.getEncodeBase64(bytes: documentFile);
    var response = await ApiOffer(context).post(
      path: ProgressBarRepository.uploadEducationDocument(educationId: educationId, documentName: documentName),
      data: {
        "base64": document,
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Education Document Uploaded");
      // orgDocumentGet(context);
      return ApiDataRegister(
          statusCode: response.statusCode!,
          success: true,
          message: response.statusMessage!);
    } else {
      print("Error 1");
      return ApiDataRegister(
          statusCode: response.statusCode!,
          success: false,
          message: response.data['message']);
    }
  } catch (e) {
    print("Error $e");
    return ApiDataRegister(
        statusCode: 404,
        success: false,
        message: AppString.somethingWentWrong);
  }
}
