import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/data/api_data/api_data.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/custom_icon_button_constant.dart';

import '../../../../../resources/const_string.dart';
import '../../../api.dart';
import '../../../repository/sm_repository/patient_data/patient_data_info_repo.dart';


Future<ApiData> AddAgencyInfo(
    BuildContext context,
   int patientId,
   String agency,
   String agencyName,
   int rate,
   String street,
   String suiteApt,
   String city,
   String state,
   String zipcode,
   String phone,
   String fax,
   String email,
   String unites
    ) async {
  try {
    var response = await Api(context).post(
      path: PatientDataInfoRepo.agencyInfoAdd(),
      data: {
        "patientId": patientId ?? "",
        "agency": agency ?? "",
        "agencyName": agencyName ?? "",
        "rate": rate ?? "",
        "street": street ?? "",
        "suiteApt": suiteApt ?? "",
        "city": city ?? "",
        "state": state ?? "",
        "zipcode": zipcode ?? "",
        "phone": phone ?? "",
        "fax": fax ?? "",
        "email": email ?? "" ,
        "unites": unites ?? ""
      },
    );
    print(response);

    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Agency Info Added");
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
                    "Successfully Add !",
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
