import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../../../data/api_data/api_data.dart';
import '../../../../../../data/api_data/sm_data/scheduler_create_data/create_data.dart';
import '../../../../../../presentation/screens/hr_module/manage/widgets/custom_icon_button_constant.dart';
import '../../../../../resources/const_string.dart';
import '../../../api.dart';
import '../../../repository/sm_repository/patient_data/patient_data_info_repo.dart';
import '../../../repository/sm_repository/scheduler/scheduler_create_repo.dart';

Future<ApiData> SchedulerCreate(
  BuildContext context,
  int patientId,
  int clinicianId,
  String visitType,
    dynamic assignDate,
    dynamic startTime,
    dynamic endTime,
  String details,
) async {
  try {
    String formatToIso8601(dynamic date) {
      DateTime parsedDate;
      if (date is String) {
        try {
          parsedDate = DateTime.parse(date);
        } catch (e) {
          throw ArgumentError("Invalid date format for string:???? $date");
        }
      } else if (date is DateTime) {
        parsedDate = date;
      } else {
        throw ArgumentError("Invalid date format:::::::: $date");
      }
      return parsedDate.toUtc().toIso8601String(); // Convert to UTC and format
    }

    //
    // String formatToIso8601(dynamic date) {
    //   DateTime parsedDate;
    //   if (date is String) {
    //     // Parse the string to DateTime, assuming it's already in ISO format or can be parsed
    //     try {
    //       parsedDate = DateTime.parse(date).toUtc();
    //     } catch (e) {
    //       throw ArgumentError("Invalid date format for string:::::::::: $date");
    //     }
    //   } else if (date is DateTime) {
    //     // If DateTime, convert to UTC
    //     parsedDate = date.toUtc();
    //   } else {
    //     throw ArgumentError("Invalid date format: $date");
    //   }
    //   return parsedDate.toIso8601String(); // Convert to ISO 8601 string
    // }

    // Convert dates to ISO 8601 format strings
    String assignDateString = formatToIso8601(assignDate);
    String startTimeString = formatToIso8601(startTime);
    String endTimeString = formatToIso8601(endTime);

    // Debug: Print out formatted date strings
   // print("assignDateString: $assignDateString");
    print("startTimeString: $startTimeString");
    print("endTimeString: $endTimeString");
/////////////////////////////////////////////////////////////
    var response = await Api(context).post(
      path: SchedulerSMRepo.addCreate(),
      data: {
        "patientId": patientId,
        "clinicianId": clinicianId,
        "visitType": visitType,
        "assignDate":                       assignDateString,
            //"${assignDate}T11:44:00Z",


        //            "2024-08-22T04:52:34.648Z",
        "startTime":    startTimeString ,//                   " 2024-08-26T09:43:36.015Z ",               // "YYYY-MM-DDThh:mm:ssTZD",       //startTime,
           // "${startTime}T00:00:00Z", //          "2024-08-22T04:52:34.648Z",
        "endTime" :  endTimeString,   // "2024-08-26T09:43:36.015Z",  //                  "YYYY-MM-DDThh:mm:ssTZD",
                            // "${endTime}T00:00:00Z", //         "2024-08-22T04:52:34.648Z",
        "details": details
      },
    );
    print(response);

    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Scheduler Created");
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




////
///get api

Future<List<CreateDataScheduler>> getScheduler(
    BuildContext context, int patientId) async {
  String convertIsoToDayMonthYear(String isoDate) {
    // Parse ISO date string to DateTime object
    DateTime dateTime = DateTime.parse(isoDate);

    // Create a DateFormat object to format the date
    DateFormat dateFormat = DateFormat('yyyy-MM-dd');

    // Format the date into "dd mm yy" format
    String formattedDate = dateFormat.format(dateTime);

    return formattedDate;
  }

  List<CreateDataScheduler> itemsData = [];
  try {
    final response = await Api(context).get(path: SchedulerSMRepo.getSCreate(patientId:patientId));
    if (response.statusCode == 200 || response.statusCode == 201) {
      for (var item in response.data) {
        //String startDateFormattedDate = item['startDate'] == null ? "--" :convertIsoToDayMonthYear(item['expDate']);
        //String issueFormattedDate = convertIsoToDayMonthYear(item['issueDate']);
        itemsData.add(CreateDataScheduler(
          schedulerCreateId: item['schedulerCreateId'],
          patientId: item['patientId'],
          clinicianId: item['clinicianId'],
          visitType: item['visitType'],
          assignDate: item['assignDate'],
          startTime: item['startTime'],
          endTime: item['endTime'],
          details: item['details'],
        ));
        // itemsData.sort((a, b) => a.educationId.compareTo(b.educationId));
      }
    } else {
      print("Scheduler create");
    }
    return itemsData;
  } catch (e) {
    print("error${e}");
    return itemsData;
  }
}
