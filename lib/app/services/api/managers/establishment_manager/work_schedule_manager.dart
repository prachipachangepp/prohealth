import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/services/api/api.dart';
import 'package:prohealth/app/services/api/repository/establishment_manager/establishment_repository.dart';
import 'package:prohealth/data/api_data/api_data.dart';
import 'package:prohealth/data/api_data/establishment_data/work_schedule/work_week_data.dart';

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
            companyId: 11,
            weekDays: item['weekDay'],
            officeStartTime: item['officeStartTime'],
            officeEndTime: item['officeEndTime'],
            officeId: 'Office 1',
            sucess: true,
            message: response.statusMessage!));
      }
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
    String officeId,
    int compantId) async {
  try {
    var response = await Api(context).post(
        path: EstablishmentManagerRepository.addWorkWeekSchedulePost(),
        data: {
          'companyId': compantId,
          'officeId': officeId,
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

/// Work Week Shift GET
Future<List<WorkWeekShiftScheduleData>> workWeekShiftScheduleGet(
    BuildContext context) async {
  List<WorkWeekShiftScheduleData> itemsData = [];
  try {
    final response = await Api(context)
        .get(path: EstablishmentManagerRepository.workWeekShiftScheduleGet());
    if (response.statusCode == 200 || response.statusCode == 201) {
      for (var item in response.data) {
        itemsData.add(WorkWeekShiftScheduleData(
          companyId: 11,
          weekDays: item['weekDay'],
          shiftName: item['shiftName'],
          officeStartTime: item['officeStartTime'],
          officeEndTime: item['officeEndTime'],
          officeId: 'Office 1',
          sucess: true,
          message: response.statusMessage!,
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

/// Holidays List GET
Future<List<DefineHolidayData>> holidaysListGet(BuildContext context) async {
  List<DefineHolidayData> itemsData = [];
  try {
    final response = await Api(context)
        .get(path: EstablishmentManagerRepository.holidaysGet());
    if (response.statusCode == 200 || response.statusCode == 201) {
      for (var item in response.data) {
        itemsData.add(DefineHolidayData(
            success: true,
            message: response.statusMessage!,
            date:  DateFormat('dd MMM yyyy').format(item['date']),
            holidayName: item['holidayName'],
            holidayId: item['holidayId'],
            companyId: 11));
      }
    } else {
      print("Holidays Api Data Error");
    }
    return itemsData;
  } catch (e) {
    return itemsData;
  }
}

/// Add Holidays POST
Future<ApiData> addHolidaysPost(
    BuildContext context,
    String holidayName,
    String date,
    int year,
    int compantId) async {
  try {
    var response = await Api(context).post(
        path: EstablishmentManagerRepository.addHolidaysPost(), data: {
          'date':date,
      'holidayNmae':holidayName,
      'year':year,
      'CompanyId':compantId
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
Future<ApiData> updateHolidays(
    BuildContext context,
    int holidayId,
    String holidayName,
    String date,
    int year,
    int compantId) async {
  try {
    var response = await Api(context).patch(path: EstablishmentManagerRepository.updateHolidaysPatch(holidayId: holidayId),
        data: {
        'date':date,
          'holidayName':holidayName,
          'year':year,
          'CompanyId':compantId
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
    int holidayId,) async {
  try {
    var response = await Api(context).delete(path: EstablishmentManagerRepository.deleteHolidaysDelete(holidayId: holidayId));
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

