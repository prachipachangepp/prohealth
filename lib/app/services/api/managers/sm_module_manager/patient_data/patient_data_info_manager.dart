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


///Info save Post API
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
  String dateofdeath,
  int clinicianId,
  String location,
  String casee,
  String Type,
  int companyId,
) async {
  try {
    var response = await Api(context).post(
      path: PatientDataInfoRepo.addInfoPatientData(),
      data: {
        // 'spcdate':"${date}T00:00:00Z",
        'spcdate': "2024-08-14T00:00:00Z",
        'medicalRecord': medicalRecord,
        'status': status,
        'firstName': firstName,
        'lastName': lastName,
        'mi': mi,
        'suffix': suffix,
        'activeTraineeStatus': activeTraineeStatus,
        // 'dateofbirth':"${dateofbirth}T00:00:00",
        'dateofbirth': "1985-05-15T00:00:00Z",
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
        // 'dateofdeath':"${dateofdeath}T00:00:00Z",
        'dateofdeath':"2024-08-14T00:00:00Z",
        'clinicianId': clinicianId,
        'location': location,
        'case': casee,
        'Type': Type,
        'companyId': companyId,
      },
    );
    print(response);

    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Patient Info Saved");
      var patientIdresponse = response.data;
      int idPatient = patientIdresponse["patientId"];

      // orgDocumentGet(context);
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
                    "Successfully saved !",
                    style: GoogleFonts.firaSans(
                      fontSize: 16.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w700
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
                          onPressed: (){Navigator.pop(context);})
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );

      ///
      // showDialog(
      //   context: context,
      //   builder: (BuildContext context) {
      //     return AlertDialog(
      //       title: Text("Success"),
      //       content: Text("Successfully saved patient data."),
      //       actions: [
      //         TextButton(
      //           child: Text("OK"),
      //           onPressed: () {
      //             Navigator.of(context).pop(); // Close the dialog
      //           },
      //         ),
      //       ],
      //     );
      //   },
      // );
      return ApiData(
          statusCode: response.statusCode!,
          success: true,
          message: response.statusMessage!,
          patientId: idPatient
      );
    } else {
      print("Error 1");
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
                    Icons.cancel_outlined,
                    color: Colors.red,
                    size: 80.0,
                  ),
                  SizedBox(height: 20.0),

                  Text(
                    "Failed, Please Try Again !",
                    style: GoogleFonts.firaSans(
                        fontSize: 16.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w700
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
                          text: 'Back',
                          onPressed: (){Navigator.pop(context);})
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
      return ApiData(
          statusCode: response.statusCode!,
          success: false,
          message: response.data['message']);
    }
  } catch (e) {
    print("Error $e");
    // Show error dialog
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
                  Icons.cancel_outlined,
                  color: Colors.red,
                  size: 80.0,
                ),
                SizedBox(height: 20.0),

                Text(
                  "Please Try Again !",
                  style: GoogleFonts.firaSans(
                      fontSize: 16.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w700
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
                        text: 'Back',
                        onPressed: (){Navigator.pop(context);})
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
    return ApiData(
        statusCode: 404, success: false, message: AppString.somethingWentWrong);
  }
}
String formatDate(DateTime date) {
  return DateFormat('yyyy-MM-dd').format(date);
}



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
//
// Future<ApiData> IntakeInfoSave(
//     BuildContext context,
//     String spcdate,
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
//     String dateofdeath,
//     int clinicianId,
//     String location,
//     String casee,
//     String Type,
//     int companyId,
//     ) async {
//   try {
//     final formattedSpcdate = formatDateToISO(spcdate) ?? "";
//     final formattedDateofbirth = formatDateToISO(dateofbirth) ?? "";
//     final formattedDateofdeath = formatDateToISO(dateofdeath) ?? "";
//
//     var response = await Api(context).post(
//       path: PatientDataInfoRepo.addInfoPatientData(),
//       data: {
//         'spcdate': formattedSpcdate,
//         'medicalRecord': medicalRecord,
//         'status': status,
//         'firstName': firstName,
//         'lastName': lastName,
//         'mi': mi,
//         'suffix': suffix,
//         'activeTraineeStatus': activeTraineeStatus,
//         'dateofbirth': formattedDateofbirth,
//         'street': street,
//         'state': state,
//         'zipcode': zipcode,
//         'suiteApt': suiteApt,
//         'city': city,
//         'county': county,
//         'majorCrossStreet': majorCrossStreet,
//         'primaryPhoneNbr': primaryPhoneNbr,
//         'secondaryPhoneNbr': secondaryPhoneNbr,
//         'email': email,
//         'socSecNbr': socSecNbr,
//         'langaugeSpoken': langaugeSpoken,
//         'dischargeReason': dischargeReason,
//         'raceEthinicity': raceEthinicity,
//         'religion': religion,
//         'maritalStatus': maritalStatus,
//         'dateofdeath': formattedDateofdeath,
//         'clinicianId': clinicianId,
//         'location': location,
//         'case': casee,
//         'Type': Type,
//         'companyId': companyId,
//       },
//     );
//     print(response);
//
//     if (response.statusCode == 200 || response.statusCode == 201) {
//       print("Patient Info Saved");
//       return ApiData(
//         statusCode: response.statusCode!,
//         success: true,
//         message: response.statusMessage!,
//       );
//     } else {
//       print("Error 1");
//       return ApiData(
//         statusCode: response.statusCode!,
//         success: false,
//         message: response.data['message'],
//       );
//     }
//   } catch (e) {
//     print("Error $e");
//     return ApiData(
//       statusCode: 404,
//       success: false,
//       message: AppString.somethingWentWrong,
//     );
//   }
// }
//
//
// String? formatDateToISO(String? date) {
//   if (date == null || date.isEmpty) return null;
//
//   try {
//     // Adjust the input format as needed
//     final DateFormat inputFormat = DateFormat('MM/dd/yyyy'); // Change this based on your input format
//     final DateTime parsedDate = inputFormat.parse(date);
//     // Return in ISO 8601 format
//     return DateFormat('yyyy-MM-dd').format(parsedDate);
//   } catch (e) {
//     print("Date format error: $e");
//     return null;
//   }
// }