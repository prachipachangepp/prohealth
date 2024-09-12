import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/services/api/repository/sm_repository/patient_data/patient_data_info_repo.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/custom_icon_button_constant.dart';

import '../../../../../../data/api_data/api_data.dart';
import '../../../../../../data/api_data/sm_data/patient_data/patient_data_info_data.dart';
import '../../../api.dart';


///get Employee API
Future<List<PatientDataInfoModal>> PatientDataInfoGet(
  BuildContext context,
) async {
  List<PatientDataInfoModal> itemsList = [];
  try {
    final response = await Api(context).get(path: PatientDataInfoRepo.infoGet);
    if (response.statusCode == 200 || response.statusCode == 201) {
      for (var item in response.data) {
        itemsList.add(
          PatientDataInfoModal(
            patientId: item['patientId'],
            spcdate: item['spcdate'],
            medicalRecord: item['medicalRecord'],
            status: item['status'],
            firstName: item['firstName'],
            lastName: item['lastName'],
            mi: item['mi'],
            suffix: item['suffix'],
            activeTraineeStatus: item['activeTraineeStatus'],
            dateofbirth: item['dateofbirth'],
            street: item['street'],
            state: item['state'],
            zipcode: item['zipcode'],
            suiteApt: item['suiteApt'],
            city: item['city'],
            county: item['county'],
            majorCrossStreet: item['majorCrossStreet'],
            primaryPhoneNbr: item['primaryPhoneNbr'],
            secondaryPhoneNbr: item['secondaryPhoneNbr'],
            email: item['email'],
            socSecNbr: item['socSecNbr'],
            langaugeSpoken: item['langaugeSpoken'],
            dischargeReason: item['dischargeReason'],
            raceEthinicity: item['raceEthinicity'],
            religion: item['religion'],
            maritalStatus: item[' maritalStatus'],
            dateofdeath: item['dateofdeath'],
            clinicianId: item['clinicianId'],
            location: item['location'],
            Type: item['Type'],
            companyId: item['companyId'],
          ),
        );
      }
      print("Response:::::${response}");
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







/// intake info save button post api



Future<ApiData> IntakeInfoSave(
    BuildContext context,
    String date,
    String medicalRecord,
    String status,
    String firstName,
    String lastName,
    String mi,
    String suffix,
    String activeTraineeStatus,
    String dateofbirth,
    String street,
    String state,
    String zipcode,
    String suiteApt,
    String city,
    String county,
    String majorCrossStreet,
    String primaryPhoneNbr,
    String secondaryPhoneNbr,
    String email,
    String socSecNbr,
    String langaugeSpoken,
    String dischargeReason,
    String raceEthinicity,
    String religion,
    String maritalStatus,
    String? dateofdeath,
    int clinicianId,
    String location,
    String casee,
    String Type,
    int companyId,
    ) async {
  try {
    // Initialize the request data map
    Map<String, dynamic> requestData = {
      'spcdate': "${date}T00:00:00Z",
      'medicalRecord': medicalRecord,
      'status': status,
      'firstName': firstName,
      'lastName': lastName,
      'mi': mi,
      'suffix': suffix,
      'activeTraineeStatus': activeTraineeStatus,
      'dateofbirth': "${dateofbirth}T00:00:00Z",
      'dateOfDeath': dateofdeath?.isNotEmpty == true ? "${dateofdeath}T00:00:00Z" : '',
      'street': street,
      'state': state,
      'zipcode': zipcode,
      'suiteApt': suiteApt,
      'city': city,
      'county': county,
      'majorCrossStreet': majorCrossStreet,
      'primaryPhoneNbr': primaryPhoneNbr,
      'secondaryPhoneNbr': secondaryPhoneNbr,
      'email': email,
      'socSecNbr': socSecNbr,
      'langaugeSpoken': langaugeSpoken,
      'dischargeReason': dischargeReason,
      'raceEthinicity': raceEthinicity,
      'religion': religion,
      'maritalStatus': maritalStatus,
      'clinicianId': clinicianId,
      'location': location,
      'case': casee,
      'Type': Type,
      'companyId': companyId,
    };

    // Add dateOfDeath field only if it is not null or empty
    if (dateofdeath != null && dateofdeath.isNotEmpty) {
      requestData['dateOfDeath'] = "${dateofdeath}T00:00:00Z";
    } else {
      requestData.remove('dateOfDeath');
    }

    // Make the API request
    var response = await Api(context).post(
      path: PatientDataInfoRepo.addInfoPatientData(),
      data: requestData,
    );

    print(response);

    // Check the response status
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Patient Info Saved");
      var patientIdresponse = response.data;
      int idPatient = patientIdresponse["patientId"];

      // Show success dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0), // Rounded corners
            ),
            child: Container(
              height: 270,
              width: 300,
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0), // Rounded corners
                color: Colors.white, // Background color
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(
                    Icons.check_circle_outline,
                    color: Color(0xFF50B5E5),
                    size: 80.0,
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    "Successfully saved!",
                    style: GoogleFonts.firaSans(
                      fontSize: 16.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 30.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CustomButton(
                        height: 30,
                        width: 130,
                        text: 'Continue',
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context); // Close the dialog and the current screen
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );

      // Return a valid ApiData object (adjust according to your actual ApiData structure)
      return ApiData(
        patientId: idPatient,
        statusCode: response.statusCode!,
        success: true,
        message: response.statusMessage!,
      ); // Replace with your actual ApiData constructor
    } else {
      // Handle other status codes or errors
      print("Failed to save patient info: ${response.statusCode}");
      throw Exception('Failed to save patient info'); // Rethrow or handle appropriately
    }
  } catch (e) {
    // Handle exceptions
    print("Error occurred: $e");
    throw e; // Rethrow or handle appropriately
  }
}


///
// Future<ApiData> IntakeInfoSave(
//     BuildContext context,
//     String date,
//     String medicalRecord,
//     String status,
//     String firstName,
//     String lastName,
//     String mi,
//     String suffix,
//     String activeTraineeStatus,
//     String dateofbirth,
//     String street,
//     String state,
//     String zipcode,
//     String suiteApt,
//     String city,
//     String county,
//     String majorCrossStreet,
//     String primaryPhoneNbr,
//     String secondaryPhoneNbr,
//     String email,
//     String socSecNbr,
//     String langaugeSpoken,
//     String dischargeReason,
//     String raceEthinicity,
//     String religion,
//     String maritalStatus,
//     String? dateofdeath,
//     int clinicianId,
//     String location,
//     String casee,
//     String Type,
//     int companyId,
//     ) async {
//   try {
//     // Initialize the request data map
//     Map<String, dynamic> requestData = {
//       'spcdate': "${date}T00:00:00Z",
//       'medicalRecord': medicalRecord,
//       'status': status,
//       'firstName': firstName,
//       'lastName': lastName,
//       'mi': mi,
//       'suffix': suffix,
//       'activeTraineeStatus': activeTraineeStatus,
//        'dateofbirth': "${dateofbirth}T00:00:00Z",
//        'dateOfDeath': dateofdeath?.isNotEmpty == true ? "${dateofdeath}T00:00:00Z" : '',
//       'street': street,
//       'state': state,
//       'zipcode': zipcode,
//       'suiteApt': suiteApt,
//       'city': city,
//       'county': county,
//       'majorCrossStreet': majorCrossStreet,
//       'primaryPhoneNbr': primaryPhoneNbr,
//       'secondaryPhoneNbr': secondaryPhoneNbr,
//       'email': email,
//       'socSecNbr': socSecNbr,
//       'langaugeSpoken': langaugeSpoken,
//       'dischargeReason': dischargeReason,
//       'raceEthinicity': raceEthinicity,
//       'religion': religion,
//       'maritalStatus': maritalStatus,
//       'clinicianId': clinicianId,
//       'location': location,
//       'case': casee,
//       'Type': Type,
//       'companyId': companyId,
//     };
//
//     // Add dateofdeath field only if it is not null or empty
//     // if (dateofdeath != null && dateofdeath.isNotEmpty) {
//     //   requestData['dateofdeath'] = "${dateofdeath}T00:00:00Z";
//     // }else{
//     //   requestData['dateofdeath'] ="2024-08-14T00:00:00Z";
//     // }
//     // Add dateofdeath field only if it is not null or empty
//     if (dateofdeath != null && dateofdeath.isNotEmpty) {
//       requestData['dateOfDeath'] = "${dateofdeath}T00:00:00Z";
//     } else {
//       // Remove dateOfDeath if it's null or empty
//       requestData.remove('dateOfDeath');
//     }
//     // Make the API request
//     var response = await Api(context).post(
//       path: PatientDataInfoRepo.addInfoPatientData(),
//       data: requestData,
//     );
//
//     print(response);
//
//     // Check the response status
//     if (response.statusCode == 200 || response.statusCode == 201) {
//       print("Patient Info Saved");
//       var patientIdresponse = response.data;
//       int idPatient = patientIdresponse["patientId"];
//       // Return a valid ApiData object (adjust according to your actual ApiData structure)
//       return ApiData(patientId: idPatient,
//           statusCode:response.statusCode!,
//           success: false, message: response.statusMessage!); // Replace with your actual ApiData constructor
//     } else {
//       // Handle other status codes or errors
//       print("Failed to save patient info: ${response.statusCode}");
//       throw Exception('Failed to save patient info'); // Rethrow or handle appropriately
//     }
//   } catch (e) {
//     // Handle exceptions
//     print("Error occurred: $e");
//     throw e; // Rethrow or handle appropriately
//   }
// }
