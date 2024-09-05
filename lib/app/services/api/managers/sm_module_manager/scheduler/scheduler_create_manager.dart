import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:prohealth/data/api_data/sm_data/scheduler_create_data/schedular_data.dart';

import '../../../../../../data/api_data/api_data.dart';
import '../../../../../../data/api_data/sm_data/scheduler_create_data/create_data.dart';
import '../../../../../../presentation/screens/hr_module/manage/widgets/custom_icon_button_constant.dart';
import '../../../../../resources/const_string.dart';
import '../../../api.dart';
import '../../../repository/sm_repository/patient_data/patient_data_info_repo.dart';
import '../../../repository/sm_repository/scheduler/scheduler_create_repo.dart';

Future<ApiData> SchedulerCreate({
  required BuildContext context,
  required int patientId,
  required int clinicianId,
  required String visitType,
  required String assignDate,
  required String startTime,
  required String endTime,
  required String details,
}) async {
  try {
    var response = await Api(context).post(
      path: SchedulerSMRepo.addCreate(),
      data: {
        "patientId": patientId,
        "clinicianId": clinicianId,
        "visitType": visitType,
        "assignDate": assignDate,
        "startTime": startTime,
        "endTime": endTime,
        "details": details
      },
    );
    print(response);
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Scheduler Created");
      var patientIdresponse = response.data;
      int idPatient = patientIdresponse["patientId"];

      // orgDocumentGet(context);

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
    return ApiData(
        statusCode: 404, success: false, message: AppString.somethingWentWrong);
  }
}

/// Patch schedule
Future<ApiData> updateScheduleCalender({
  required BuildContext context,
  required int schedulerCreateId,
  required int patientId,
  required int clinicianId,
  required String visitType,
  required String assignDate,
  required String startTime,
  required String endTime,
  required String details,
}) async {
  try {
    var response = await Api(context).patch(
      path: SchedulerSMRepo.updateSchedule(schedulerCreateId: schedulerCreateId),
      data: {
        "patientId": patientId,
        "clinicianId": clinicianId,
        "visitType": visitType,
        "assignDate": assignDate,
        "startTime": startTime,
        "endTime": endTime,
        "details": details
      },
    );
    print(response);
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Scheduler Updated");
      var patientIdresponse = response.data;

      // orgDocumentGet(context);

      return ApiData(
          statusCode: response.statusCode!,
          success: true,
          message: response.statusMessage!,
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
    return ApiData(
        statusCode: 404, success: false, message: AppString.somethingWentWrong);
  }
}

///get api
Future<List<CreateDataScheduler>> getScheduler({
    required BuildContext context, required int patientId}) async {
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
    final response = await Api(context)
        .get(path: SchedulerSMRepo.getSCreate(patientId: patientId));
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

/// get calender prefill
Future<CreatePrefillDataScheduler> getPreFillCalenderData({
  required BuildContext context, required int schedulerCreateId}) async {
  var itemsData;
  try {
    final response = await Api(context)
        .get(path: SchedulerSMRepo.getPreFillSchedule(schedulerId: schedulerCreateId));
    if (response.statusCode == 200 || response.statusCode == 201) {
        itemsData = CreatePrefillDataScheduler(
          schedulerCreateId: response.data['schedulerCreateId'],
          patientId: response.data['patientId'],
          clinicianId: response.data['clinicianId'],
          visitType: response.data['visitType'],
          assignDate: response.data['assignDate'],
          startTime: response.data['startTime'],
          endTime: response.data['endTime'],
          details: response.data['details'],
        );
    } else {
      print("Scheduler Prefilled");
    }
    return itemsData;
  } catch (e) {
    print("error${e}");
    return itemsData;
  }
}

/// Calender
Future<SchedularData> getSchedularByClinitian({
  required BuildContext context,
  required int clinicialId,
}) async {
  var itemData;
  String convertIsoToDayMonthYear(String isoDate) {
    // Parse ISO date string to DateTime object
    DateTime dateTime = DateTime.parse(isoDate);

    // Create a DateFormat object to format the date
    DateFormat dateFormat = DateFormat('yyyy-MM-dd');

    // Format the date into "dd mm yy" format
    String formattedDate = dateFormat.format(dateTime);

    return formattedDate;
  }
  try {
    // Replace 'Api' and 'SchedulerSMRepo.getScheduleBuClinitian' with your actual API request code
    final response = await Api(context).get(path: SchedulerSMRepo.getScheduleBuClinitian(clinicianId: clinicialId));

    if (response.statusCode == 200 || response.statusCode == 201) {
      // Assuming response.data is a Map<String, dynamic> type representing the JSON response
      var responseData = response.data;

      // Parse the response data into SchedularData model
      itemData = SchedularData(
        zone: responseData['Zone'] ?? '',
        zoneId: responseData['ZoneId']??0,
        correntLocation: responseData['correntLocation'] ?? '',
        expertise: responseData['expertise'] ?? '',
        fullname: responseData['fullname'] ?? '',
        status: responseData['status'] ?? '',
        totalPatients: responseData['totalPatients']??0,
        compliance:Compliance(
          license: responseData['Compliance']['License'] ?? '',
          missedVisit: responseData['Compliance']['MissedVisit']??0,
          qaisisForms: responseData['Compliance']['QAISISForms'] ?? 0,
        ),
        summary: Summary(
          earning: responseData['Summary']['Earning']??0,
          travel: responseData['Summary']['Travel'] ?? '',
          totalTravel: responseData['Summary']['TotalTravel'] ?? '',
          visit: responseData['Summary']['Visit']??0,
          totalQAISIS: responseData['Summary']['TotalQAISIS']??0,
          reAssigned: responseData['Summary']['ReAssigned']??0,
          rescheduled: responseData['Summary']['Rescheduled']??0,
          totalEarning: responseData['Summary']['TotalEarning']??0,
          totalReAssigned: responseData['Summary']['TotalReAssigned']??0,
          grandTotalQAISIS: responseData['Summary']['GrandTotalQAISIS']??0,
        ),
        calender: (responseData['Calender'] as List<dynamic>?)
            ?.map((item) {
              // String convertedDate = convertIsoToDayMonthYear(item['assignDate']);
              // String convertedStartTimeDate = convertIsoToDayMonthYear(item['startTime']);
              // String convertedEndTimeDate = convertIsoToDayMonthYear(item['endTime']);
         return Calendar(
            schedulerCreateId: item['schedulerCreateId']??0,
            patientId: item['patientId']??0,
            clinicianId: item['clinicianId']??0,
            visitType: item['visitType'] ?? '',
            assignDate: item['assignDate'] ?? '',
            startTime: item['startTime'] ?? '',
            endTime: item['endTime'] ?? '',
            details: item['details'] ?? '',
           patientFirstName: item['patientFirstName']??"",
           patientLastName: item['patientLastName']??"",
           patientAddress: item['patientAddress']??"",
          );
        } )
            .toList() ??
            [],
      );
      print('Response ${response}');

      return itemData;
    } else {
      print("Failed to load data with status code: ${response.statusCode}");
      return itemData;
    }
  } catch (e) {
    print("Error fetching schedular data: $e");
    return itemData;
  }
}

