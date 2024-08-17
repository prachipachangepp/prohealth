import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../../../data/api_data/api_data.dart';
import '../../../../../../presentation/screens/hr_module/manage/widgets/custom_icon_button_constant.dart';
import '../../../../../resources/const_string.dart';
import '../../../api.dart';
import '../../../repository/sm_repository/patient_data/patient_data_info_repo.dart';

///Info save Post API
Future<ApiData> IntakeRelatedPartyAdd(
    BuildContext context,
    int patientId,
    String emergencyContact,
    String emg_telephoneNbr,
    String emg_relationship,
    String emg_contactAddress,
    String emg_City,
    String emg_State,
    String emg_Zipcode,
    String emg_priorityDisasterCode,
    String emg_comments,
    String pcg_Prefix,
    String pcg_FirstName,
    String pcg_MI,
    String pcg_LastName,
    String pcg_suffix,
    String pcg_OptforCAHPS,
    String pcg_Address,
    String pcg_SuiteApt,
    String pcg_City,
    String pcg_State,
    String pcg_Zipcode,
    String pcg_Phone,
    String pcg_Cell,
    String pcg_Email,
    String pcg_Relationship,
    String pcg_AdditionalInfo

    ///
    // String date,
    // String medicalRecord,
    // String status,
    // String firstName,
    // String lastName,
    // String mi,
    // String suffix,
    // String activeTraineeStatus,
    // String dateofbirth,
    // String street,
    // String state,
    // String zipcode,
    // String suiteApt,
    // String city,
    // String county,
    // String majorCrossStreet,
    // String primaryPhoneNbr,
    // String secondaryPhoneNbr,
    // String email,
    // String socSecNbr,
    // String langaugeSpoken,
    // String dischargeReason,
    // String raceEthinicity,
    // String religion,
    // String maritalStatus,
    // String dateofdeath,
    // int clinicianId,
    // String location,
    // String casee,
    // String Type,
    // int companyId,
    ) async {
  try {
    var response = await Api(context).post(
      path: PatientDataInfoRepo.relatedPartyAdd(),
      data: {
        "patientId": patientId,
        "emergencyContact": emergencyContact,
        "emg_telephoneNbr": emg_telephoneNbr,
        "emg_relationship": emg_relationship,
        "emg_contactAddress": emg_contactAddress,
        "emg_City": emg_City,
        "emg_State": emg_State,
        "emg_Zipcode": emg_Zipcode,
        "emg_priorityDisasterCode": emg_priorityDisasterCode,
        "emg_comments": emg_comments,
        "pcg_Prefix": pcg_Prefix,
        "pcg_FirstName": pcg_FirstName,
        "pcg_MI": pcg_MI,
        "pcg_LastName": pcg_LastName,
        "pcg_suffix": pcg_suffix,
        "pcg_OptforCAHPS": pcg_OptforCAHPS,
        "pcg_Address": pcg_Address,
        "pcg_SuiteApt": pcg_SuiteApt,
        "pcg_City": pcg_City,
        "pcg_State": pcg_State,
        "pcg_Zipcode": pcg_Zipcode,
        "pcg_Phone": pcg_Phone,
        "pcg_Cell": pcg_Cell,
        "pcg_Email": pcg_Email,
        "pcg_Relationship": pcg_Relationship,
        "pcg_AdditionalInfo": pcg_AdditionalInfo

        ///
        // 'spcdate':"${date}T00:00:00Z",
        // 'spcdate': "2024-08-14T00:00:00Z",
        // 'medicalRecord': medicalRecord,
        // 'status': status,
        // 'firstName': firstName,
        // 'lastName': lastName,
        // 'mi': mi,
        // 'suffix': suffix,
        // 'activeTraineeStatus': activeTraineeStatus,
        // // 'dateofbirth':"${dateofbirth}T00:00:00",
        // 'dateofbirth': "1985-05-15T00:00:00Z",
        // 'street': street,
        // 'state': state,
        // 'zipcode': zipcode,
        // 'suiteApt': suiteApt,
        // 'city': city,
        // 'county': county,
        // 'majorCrossStreet': majorCrossStreet,
        // 'primaryPhoneNbr': primaryPhoneNbr,
        // 'secondaryPhoneNbr': secondaryPhoneNbr,
        // 'email': email,
        // 'socSecNbr': socSecNbr,
        // 'langaugeSpoken': langaugeSpoken,
        // 'dischargeReason': dischargeReason,
        // 'raceEthinicity': raceEthinicity,
        // 'religion': religion,
        // 'maritalStatus': maritalStatus,
        // // 'dateofdeath':"${dateofdeath}T00:00:00Z",
        // 'dateofdeath':"2024-08-14T00:00:00Z",
        // 'clinicianId': clinicianId,
        // 'location': location,
        // 'case': casee,
        // 'Type': Type,
        // 'companyId': companyId,
      },
    );
    print(response);

    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Related Party Saved");
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
                        fontWeight: FontWeight.w700),
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
                          })
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
          patientId: idPatient);
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
                        fontWeight: FontWeight.w700),
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
                          onPressed: () {
                            Navigator.pop(context);
                          })
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
                      fontWeight: FontWeight.w700),
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
                        onPressed: () {
                          Navigator.pop(context);
                        })
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
