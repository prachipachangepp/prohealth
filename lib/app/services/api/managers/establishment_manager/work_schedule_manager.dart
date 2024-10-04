import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/services/api/api.dart';
import 'package:prohealth/app/services/api/repository/establishment_manager/establishment_repository.dart';
import 'package:prohealth/data/api_data/api_data.dart';
import 'package:prohealth/data/api_data/establishment_data/work_schedule/work_week_data.dart';

import '../../../token/token_manager.dart';
/// Work Week GET
Future<List<WorkWeekScheduleData>> workWeekScheduleGet(
    BuildContext context) async {
  List<WorkWeekScheduleData> itemsData = [];
  try {
    final response = await Api(context)
        .get(path: EstablishmentManagerRepository.workWeekScheduleGet());
    if (response.statusCode == 200 || response.statusCode == 201) {
      for (var item in response.data) {
        itemsData.add(WorkWeekScheduleData(
            companyId: item['companyId'],
            weekDays: item['weekDay'],
            officeStartTime: item['officeStartTime'],
            officeEndTime: item['officeEndTime'],
            sucess: true,
            message: response.statusMessage!,
            weekScheduleId: item['WorkWeekScheduleId']));
      }
      print(":::::${itemsData}");
    } else {
      print("Api Data Error");
    }
    return itemsData;
  } catch (e) {
    return itemsData;
  }
}

/// Work Week Schedule POST
Future<ApiData> addWorkWeekSchedule(
    BuildContext context,
    String weekDayName,
    String officeStartTime,
    String officeEndTime,
    int compantId) async {
  try {
    var response = await Api(context).post(
        path: EstablishmentManagerRepository.addWorkWeekSchedulePost(),
        data: {
          'companyId': compantId,
          'weekDay': weekDayName,
          'officeStartTime': officeStartTime,
          'officeEndTime': officeEndTime,
        });
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Week Schedule Added");
      return ApiData(
          statusCode: response.statusCode!,
          success: true,
          message: response.statusMessage!);
    } else {
      print("Error 1");
      return ApiData(
          statusCode: response.statusCode!,
          success: false,
          message: response.data['message']);
    }
  } catch (e) {
    print("Error $e");
    return ApiData(
        statusCode: 404, success: false, message: AppString.somethingWentWrong);
  }
}

/// Delete Work week
Future<ApiData> deleteWorkWeekSchedule(
    BuildContext context,
    int workWeekScheduleId) async {
  try {
    var response = await Api(context).delete(
        path: EstablishmentManagerRepository.deleteWorkWeekScheduleDelete(workWeekScheduleId: workWeekScheduleId),);
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Week Schedule Deleted");
      return ApiData(
          statusCode: response.statusCode!,
          success: true,
          message: response.statusMessage!);
    } else {
      print("Error 1");
      return ApiData(
          statusCode: response.statusCode!,
          success: false,
          message: response.data['message']);
    }
  } catch (e) {
    print("Error $e");
    return ApiData(
        statusCode: 404, success: false, message: AppString.somethingWentWrong);
  }
}

/// Work Week Shift GET
Future<List<WorkWeekShiftScheduleData>> workWeekShiftScheduleGet(
    BuildContext context,
    String weekDay) async {
  List<WorkWeekShiftScheduleData> itemsData = [];
  try {
    final companyId = await TokenManager.getCompanyId();
    final response = await Api(context).get(
        path: EstablishmentManagerRepository.workWeekShiftScheduleGet(
            companyId: companyId,weekDay: weekDay));
    if (response.statusCode == 200 || response.statusCode == 201) {
      for (var item in response.data) {
        itemsData.add(WorkWeekShiftScheduleData(
          weekShiftScheduleId: item['WorkWeekShiftScheduleId'],
          weekDays: item['weekDay'],
          shiftName: item['shiftName'],
          officeStartTime: item['officeStartTime'],
          officeEndTime: item['officeEndTime'],
          sucess: true,
          message: response.statusMessage!, companyId: item['companyId'],
        ));
      }
    } else {
      print("Api Data Error");
    }
    return itemsData;
  } catch (e) {
    return itemsData;
  }
}

/// Add work week shift POST
Future<ApiData> addWorkWeekShiftPost(
    BuildContext context,
    String weekDayName,
    String shiftName,
    String officeStartTime,
    String officeEndTime,
    ) async {
  try {
    final companyId = await TokenManager.getCompanyId();
    var response = await Api(context).post(
        path: EstablishmentManagerRepository.addWorkWeekShiftPost(),
        data: {
          'weekDay': weekDayName,
          'shiftName': shiftName,
          'officeStartTime': officeStartTime,
          'officeEndTime': officeEndTime,
          'companyId': companyId,
        });
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Week Shift Added");
      return ApiData(
          statusCode: response.statusCode!,
          success: true,
          message: response.statusMessage!);
    } else {
      print("Error 1");
      return ApiData(
          statusCode: response.statusCode!,
          success: false,
          message: response.data['message']);
    }
  } catch (e) {
    print("Error $e");
    return ApiData(
        statusCode: 404, success: false, message: AppString.somethingWentWrong);
  }
}


/// Delete work week shift
Future<ApiData> deleteWorkWeekSiftSchedule({required BuildContext context,required int workWeekShiftId}) async {
  try {
    var response = await Api(context).delete(
        path: EstablishmentManagerRepository.deleteWorkWeekShict(workWeekShiftId: workWeekShiftId));
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Shift Deleted");
      return ApiData(
          statusCode: response.statusCode!,
          success: true,
          message: response.statusMessage!);
    } else {
      print("Error 1");
      return ApiData(
          statusCode: response.statusCode!,
          success: false,
          message: response.data['message']);
    }
  } catch (e) {
    print("Error $e");
    return ApiData(
        statusCode: 404, success: false, message: AppString.somethingWentWrong);
  }
}

/// Holidays List GET
Future<List<DefineHolidayData>> holidaysListGet(BuildContext context) async {
  String convertIsoToDayMonthYear(String isoDate) {
    // Parse ISO date string to DateTime object
    DateTime dateTime = DateTime.parse(isoDate);

    // Create a DateFormat object to format the date
    DateFormat dateFormat = DateFormat('dd MMM yyyy');

    // Format the date into "dd mm yy" format
    String formattedDate = dateFormat.format(dateTime);

    return formattedDate;
  }

  List<DefineHolidayData> itemsData = [];
  try {
    final companyId = await TokenManager.getCompanyId();
    final response = await Api(context)
        .get(path: EstablishmentManagerRepository.holidaysGet());
    if (response.statusCode == 200 || response.statusCode == 201) {
      for (var item in response.data) {
        String formattedDate = convertIsoToDayMonthYear(item['date']);
        itemsData.add(DefineHolidayData(
            success: true,
            message: response.statusMessage!,
            date: formattedDate,
            holidayName: item['holidayName'],
            holidayId: item['holidayId'],
            companyId: companyId));
      }
      print("Response::::::${itemsData}");
      itemsData.sort((a, b) {
        DateTime dateA = DateFormat('dd MMM yyyy').parse(a.date);
        DateTime dateB = DateFormat('dd MMM yyyy').parse(b.date);
        return dateB.compareTo(dateA); // Reverse the comparison for descending order
      });

    } else {
      print("Holidays Api Data Error");
    }
    return itemsData;
  } catch (e) {
    return itemsData;
  }
}
/// Get holiday prefill list
Future<DefinePrefillHolidayData> holidaysPrefillGet(BuildContext context,int holidayId) async {
  String convertIsoToDayMonthYear(String isoDate) {
    // Parse ISO date string to DateTime object
    DateTime dateTime = DateTime.parse(isoDate);

    // Create a DateFormat object to format the date
    DateFormat dateFormat = DateFormat('yyyy-MM-dd');

    // Format the date into "dd mm yy" format
    String formattedDate = dateFormat.format(dateTime);

    return formattedDate;
  }

  var itemsData;
  try {
    final companyId = await TokenManager.getCompanyId();
    final response = await Api(context)
        .get(path: EstablishmentManagerRepository.holidaysPrefillGet(holidayId: holidayId));
    if (response.statusCode == 200 || response.statusCode == 201) {

        String formattedDate = convertIsoToDayMonthYear(response.data['date']);
        itemsData = DefinePrefillHolidayData(
            success: true,
            message: response.statusMessage!,
            date: formattedDate,
            holidayName: response.data['holidayName'],
            holidayId: response.data['holidayId'],
            companyId: companyId);

      print("Response::::::${itemsData}");
    } else {
      print("Holidays Api prefill Data Error");
    }
    return itemsData;
  } catch (e) {
    return itemsData;
  }
}

/// Add Holidays POST
Future<ApiData> addHolidaysPost(BuildContext context, String holidayName,
    String date, int year) async {
  try {
    final companyId = await TokenManager.getCompanyId();
    var response = await Api(context)
        .post(path: EstablishmentManagerRepository.addHolidaysPost(), data: {
      'date': "${date}T00:00:00Z",
      'holidayName': holidayName,
      'year': year,
      'CompanyId': companyId
    });
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Holidays Added");
      return ApiData(
          statusCode: response.statusCode!,
          success: true,
          message: response.statusMessage!);
    } else {
      print("Error 1");
      return ApiData(
          statusCode: response.statusCode!,
          success: false,
          message: response.data['message']);
    }
  } catch (e) {
    print("Error $e");
    return ApiData(
        statusCode: 404, success: false, message: AppString.somethingWentWrong);
  }
}

/// Update Holidays
Future<ApiData> updateHolidays(BuildContext context, int holidayId,
    String holidayName, String date, int year,) async {
  try {
    final companyId = await TokenManager.getCompanyId();
    var response = await Api(context).patch(
        path: EstablishmentManagerRepository.updateHolidaysPatch(
            holidayId: holidayId),
        data: {
          'date': "${date}T00:00:00Z",
          'holidayName': holidayName,
          'year': year,
          'CompanyId': companyId
        });
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Holidays Updated");
      return ApiData(
          statusCode: response.statusCode!,
          success: true,
          message: response.statusMessage!);
    } else {
      print("Error 1");
      return ApiData(
          statusCode: response.statusCode!,
          success: false,
          message: response.data['message']);
    }
  } catch (e) {
    print("Error $e");
    return ApiData(
        statusCode: 404, success: false, message: AppString.somethingWentWrong);
  }
}

/// Delete Holidays
Future<ApiData> deleteHolidays(
  BuildContext context,
  int holidayId,
) async {
  try {
    var response = await Api(context).delete(
        path: EstablishmentManagerRepository.deleteHolidaysDelete(
            holidayId: holidayId));
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Holiday Deleted");
      return ApiData(
          statusCode: response.statusCode!,
          success: true,
          message: response.statusMessage!);
    } else {
      print("Error 1");
      return ApiData(
          statusCode: response.statusCode!,
          success: false,
          message: response.data['message']);
    }
  } catch (e) {
    print("Error $e");
    return ApiData(
        statusCode: 404, success: false, message: AppString.somethingWentWrong);
  }
}


/// Get Shiftwise batches GET
Future<List<ShiftBachesData>> shiftBatchesGet(
    BuildContext context, String shiftName,String weekDay) async {
  List<ShiftBachesData> itemsData = [];
  try {
    final companyId = await TokenManager.getCompanyId();
    final response = await Api(context).get(
        path: EstablishmentManagerRepository.getShiftBatches(
            shiftName: shiftName, companyId: companyId,weekDay: weekDay));
    if (response.statusCode == 200 || response.statusCode == 201) {
      for (var item in response.data) {
        itemsData.add(
            ShiftBachesData(
                shiftBatchScheduleId: item['ShiftBatchScheduleId'],
                weekDay: item['weekDay'],
                shiftName: item['shiftName'],
                officeStartTime: item['officeStartTime'],
                officeEndTime: item['officeEndTime'],
                companyId: item['companyId'],
                success: true,
                message: response.statusMessage!),
        );

      }

    } else {
      print("Api Shift batch Data Error");
    }
    return itemsData;
  } catch (e) {
    return itemsData;
  }
}


/// Get pre fill baches shift wise
Future<ShiftBachesData> shiftPrefillBatchesGet(
    BuildContext context, int shiftBatchId) async {
  var itemsData;
  try {
    final response = await Api(context).get(
        path: EstablishmentManagerRepository.getShiftPrefillBatches(
            shiftBatchId: shiftBatchId));
    if (response.statusCode == 200 || response.statusCode == 201) {

        itemsData =
            ShiftBachesData(
            shiftBatchScheduleId: response.data['ShiftBatchScheduleId'],
            weekDay: response.data['weekDay'],
            shiftName: response.data['shiftName'],
            officeStartTime: response.data['officeStartTime'],
            officeEndTime: response.data['officeEndTime'],
            companyId: response.data['companyId'],
            success: true,
            message: response.statusMessage!);

    } else {
      print("Api Shift batch Data Error");
    }
    return itemsData;
  } catch (e) {
    return itemsData;
  }
}

/// Add shift batches POST
Future<ApiData> addShiftBatch(BuildContext context,
    String shiftName,String weekDay,String batchStartTime,String batchEndTime) async {
  try {
    final companyId = await TokenManager.getCompanyId();
    var response = await Api(context).post(
        path: EstablishmentManagerRepository.addShiftBatches(),
        data: {
          "weekDay": weekDay,
          "shiftName": shiftName,
          "officeStartTime": batchStartTime,
          "officeEndTime": batchEndTime,
          "companyId": companyId,
        });
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Batch added");
      return ApiData(
          statusCode: response.statusCode!,
          success: true,
          message: response.statusMessage!);
    } else {
      print("Error 1");
      return ApiData(
          statusCode: response.statusCode!,
          success: false,
          message: response.data['message']);
    }
  } catch (e) {
    print("Error1111 $e");
    return ApiData(
        statusCode: 404, success: false, message: AppString.somethingWentWrong);
  }
}

/// update batch
Future<ApiData> updateShiftBatch(BuildContext context,
    String shiftName,String weekDay,String batchStartTime,String batchEndTime,int shiftBatchScheduleId) async {
  try {
    final companyId = await TokenManager.getCompanyId();
    var response = await Api(context).patch(
        path: EstablishmentManagerRepository.modifyShiftBatches(shiftBatchScheduleId: shiftBatchScheduleId),
        data: {
          "weekDay": weekDay,
          "shiftName": shiftName,
          "officeStartTime": batchStartTime,
          "officeEndTime": batchEndTime,
          "companyId": companyId,

        });
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Batch Updated");
      return ApiData(
          statusCode: response.statusCode!,
          success: true,
          message: response.statusMessage!);
    } else {
      print("Error 1");
      return ApiData(
          statusCode: response.statusCode!,
          success: false,
          message: response.data['message']);
    }
  } catch (e) {
    print("Error1111 $e");
    return ApiData(
        statusCode: 404, success: false, message: AppString.somethingWentWrong);
  }
}

/// delete batch
Future<ApiData> deleteShiftBatch(BuildContext context,int shiftBatchScheduleId) async {
  try {
    var response = await Api(context).delete(
        path: EstablishmentManagerRepository.modifyShiftBatches(shiftBatchScheduleId: shiftBatchScheduleId));
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Batch deleted");
      return ApiData(
          statusCode: response.statusCode!,
          success: true,
          message: response.statusMessage!);
    } else {
      print("Error 1");
      return ApiData(
          statusCode: response.statusCode!,
          success: false,
          message: response.data['message']);
    }
  } catch (e) {
    print("Error1111 $e");
    return ApiData(
        statusCode: 404, success: false, message: AppString.somethingWentWrong);
  }
}




