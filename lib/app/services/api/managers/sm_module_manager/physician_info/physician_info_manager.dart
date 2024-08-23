import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../../../data/api_data/api_data.dart';
import '../../../../../../data/api_data/sm_data/scheduler_create_data/create_data.dart';
import '../../../../../../presentation/screens/hr_module/manage/widgets/custom_icon_button_constant.dart';
import '../../../../../resources/const_string.dart';
import '../../../api.dart';
import '../../../repository/sm_repository/medications/medications_repo.dart';
import '../../../repository/sm_repository/patient_data/patient_data_info_repo.dart';
import '../../../repository/sm_repository/physician_info/physician_info_repo.dart';

///Info save Post API
Future<ApiData> postPhysicianInfoScreen(
  BuildContext context,
  int patientId,
  int companyId,
  String primaryPhysician,
  String pr_FirstName,
  String pr_LastName,
  String pr_PECOSStatus,
  String pr_UPINNbr,
  String pr_NPINbr,
  String pr_Street,
  String pr_SuiteApt,
  String pr_City,
  String pr_State,
  String pr_Zipcode,
  String pr_Phone,
  String pr_Fax,
  String pr_Protocol,
  String contractF2FPhysician,
  String f2f_FirstName,
  String f2f_LastName,
  String f2f_PECOSStatus,
  String f2f_UPINNbr,
  String f2f_NPINbr,
  String f2f_Street,
  String f2f_SuiteApt,
  String f2f_City,
  String f2f_State,
  String f2f_Zipcode,
  String f2f_Phone,
  String f2f_Fax,
  String f2f_Protocol,
) async {
  try {
    var response = await Api(context).post(
      path: physicianInfo.addPIinfo(),
      data: {
        "patientId": patientId,
        "companyId": companyId,
        "primaryPhysician": primaryPhysician,
        "pr_FirstName": pr_FirstName,
        "pr_LastName": pr_LastName,
        "pr_PECOSStatus": pr_PECOSStatus,
        "pr_UPINNbr": pr_UPINNbr,
        "pr_NPINbr": pr_NPINbr,
        "pr_Street": pr_Street,
        "pr_SuiteApt": pr_SuiteApt,
        "pr_City": pr_City,
        "pr_State": pr_State,
        "pr_Zipcode": pr_Zipcode,
        "pr_Phone": pr_Phone,
        "pr_Fax": pr_Fax,
        "pr_Protocol": pr_Protocol,
        "contractF2FPhysician": contractF2FPhysician,
        "f2f_FirstName": f2f_FirstName,
        "f2f_LastName": f2f_LastName,
        "f2f_PECOSStatus": f2f_PECOSStatus,
        "f2f_UPINNbr": f2f_UPINNbr,
        "f2f_NPINbr": f2f_NPINbr,
        "f2f_Street": f2f_Street,
        "f2f_SuiteApt": f2f_SuiteApt,
        "f2f_City": f2f_City,
        "f2f_State": f2f_State,
        "f2f_Zipcode": f2f_Zipcode,
        "f2f_Phone": f2f_Phone,
        "f2f_Fax": f2f_Fax,
        "f2f_Protocol": f2f_Protocol
      },
    );
    print(response);

    if (response.statusCode == 200 || response.statusCode == 201) {
      print("physician info data Saved");
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
///////////

Future<List<statedata>> getStateDropDown(
  BuildContext context,
) async {
  List<statedata> itemsList = [];
  try {
    final response = await Api(context).get(path: physicianInfo.stateDD());
    if (response.statusCode == 200 || response.statusCode == 201) {
      for (var item in response.data) {
        itemsList.add(statedata(
          stateId: item['stateId'],
          name: item['name'],
          short: item['short'],
          countryId: item['countryId'],
          country: item['country'],
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

//////

Future<List<citydata>> getCityDropDown(
  BuildContext context,
) async {
  List<citydata> itemsList = [];
  try {
    final response = await Api(context).get(path: physicianInfo.cityDD());
    if (response.statusCode == 200 || response.statusCode == 201) {
      for (var item in response.data) {
        itemsList.add(citydata(
          city_id: item['city_id'],
          cityName: item['cityName'],
          state: item['state'],
          Country: item['Country'],
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

///////

Future<List<relationshipdata>> getRelationshipDropDown(
  BuildContext context,
) async {
  List<relationshipdata> itemsList = [];
  try {
    final response = await Api(context).get(path: physicianInfo.relationshipDD());
    if (response.statusCode == 200 || response.statusCode == 201) {
      for (var item in response.data) {
        itemsList.add(relationshipdata(
          relationshipId: item['relationshipId'],
          relationship: item['relationship'],
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


///////


Future<List<languageSpokendata>> getlanguageSpokenDropDown(
    BuildContext context,
    ) async {
  List<languageSpokendata> itemsList = [];
  try {
    final response = await Api(context).get(path: physicianInfo.languageSpokenDD());
    if (response.statusCode == 200 || response.statusCode == 201) {
      for (var item in response.data) {
        itemsList.add(languageSpokendata(
          languageSpokenId: item['languageSpokenId'],
          languageSpoken: item['languageSpoken'],
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



///////

Future<List<metrialStatusdata>> getMaritalStatusDropDown(
    BuildContext context,
    ) async {
  List<metrialStatusdata> itemsList = [];
  try {
    final response = await Api(context).get(path: physicianInfo.metrialstatusDD());
    if (response.statusCode == 200 || response.statusCode == 201) {
      for (var item in response.data) {
        itemsList.add(metrialStatusdata(
          maritalStatusId: item['maritalStatusId'],
          maritalStatus: item['maritalStatus'],
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

/////////

Future<List<racedata>> getRaceDropDown(
    BuildContext context,
    ) async {
  List<racedata> itemsList = [];
  try {
    final response = await Api(context).get(path: physicianInfo.raceDD());
    if (response.statusCode == 200 || response.statusCode == 201) {
      for (var item in response.data) {
        itemsList.add(racedata(
          raceId: item['raceId'],
          race: item['race'],
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




////////
Future<List<religiondata>> getReligionDropDown(
    BuildContext context,
    ) async {
  List<religiondata> itemsList = [];
  try {
    final response = await Api(context).get(path: physicianInfo.religionDD());
    if (response.statusCode == 200 || response.statusCode == 201) {
      for (var item in response.data) {
        itemsList.add(religiondata(
          religionId: item['religionId'],
          religion: item['religion'],
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




//////
Future<List<patientStatusdata>> StatusChange(
    BuildContext context,
    ) async {
  List<patientStatusdata> itemsList = [];
  try {
    final response = await Api(context).get(path: physicianInfo.statuschange());
    if (response.statusCode == 200 || response.statusCode == 201) {
      for (var item in response.data) {
        itemsList.add(patientStatusdata(
          patientStatusId: item['patientStatusId'],
          patientStatus: item['patientStatus'],
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

