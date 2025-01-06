import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../../data/api_data/api_data.dart';
import '../../../../../../presentation/screens/hr_module/manage/widgets/custom_icon_button_constant.dart';
import '../../../../../resources/common_resources/common_theme_const.dart';
import '../../../../../resources/const_string.dart';
import '../../../api.dart';
import '../../../repository/sm_repository/insurance/insurance_repo.dart';


///Info save Post API
Future<ApiData> postISecondaryScreen(
    BuildContext context,
    int patientId,
    String secondaryInsurance,
    String name,
    String street,
    String code,
    String suiteApt,
    String city,
    String state,
    String zipcode,
    String type,
    String phone,
    String category,
    String authorisation,
    String effectiveFrom,
    String effectiveTo,
    String groupNbr,
    String groupName,
    String policyHICNbr,
    String eligiblityStatus,
    String insuranceVerified,
    String comment,
    ) async {
  try {
    var response = await Api(context).post(
      path: Insuranceclass.addSecondary(),
      data: {
        "patientId": patientId,
        "secondaryInsurance": secondaryInsurance,
        "name": name,
        "street": street,
        "code": code,
        "suiteApt": suiteApt,
        "city": city,
        "state": state,
        "zipcode": zipcode,
        "type": type,
        "phone": phone,
        "category": category,
        "authorisation": authorisation,
        "effectiveFrom":
        "${effectiveFrom}T00:00:00Z", //"2024-08-18T08:29:51.862Z",
        "effectiveTo": "${effectiveTo}T00:00:00Z", //"2024-08-18T08:29:51.862Z",
        "groupNbr": groupNbr,
        "groupName": groupName,
        "policyHICNbr": policyHICNbr,
        "eligiblityStatus": eligiblityStatus,
        "insuranceVerified": insuranceVerified,
        "comment": comment
      },
    );
    print(response);

    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Secondary data Saved");
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
                    style: APIErrorTextConst.customTextStyle(context),
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
                    style: APIErrorTextConst.customTextStyle(context),
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
                  style: APIErrorTextConst.customTextStyle(context),
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
