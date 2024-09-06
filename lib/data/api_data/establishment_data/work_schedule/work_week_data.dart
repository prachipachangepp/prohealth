/// Work Schedule Data
class WorkWeekScheduleData {
  final int weekScheduleId;
  final String weekDays;
  final String officeStartTime;
  final String officeEndTime;
  final int companyId;
  final bool sucess;
  final String message;
  WorkWeekScheduleData(
      {required this.weekScheduleId,
      required this.weekDays,
      required this.officeStartTime,
      required this.officeEndTime,
      required this.companyId,
      required this.sucess,
      required this.message});
}

/// Work Shift Data
class WorkWeekShiftScheduleData {
  final int? weekShiftScheduleId;
  final String weekDays;
  final String shiftName;
  final String officeStartTime;
  final String officeEndTime;
  final int companyId;
  final bool sucess;
  final String message;
  WorkWeekShiftScheduleData(
      {this.weekShiftScheduleId,
      required this.weekDays,
      required this.shiftName,
      required this.officeStartTime,
      required this.officeEndTime,
      required this.companyId,
      required this.sucess,
      required this.message});
}

/// Holiday Data
class DefineHolidayData {
  final bool success;
  final String message;
  final String holidayName;
  final String date;
  final int holidayId;
  final int companyId;

  DefineHolidayData(
      {required this.success,
      required this.message,
      required this.date,
      required this.holidayName,
      required this.holidayId,
      required this.companyId});
}

/// Get prefill Holidays
/// Holiday Data
class DefinePrefillHolidayData {
  final bool success;
  final String message;
  final String holidayName;
  final String date;
  final int? holidayId;
  final int? companyId;

  DefinePrefillHolidayData(
      {required this.success,
        required this.message,
        required this.date,
        required this.holidayName,
        this.holidayId,
        this.companyId});
}

/// Get baches
class ShiftBachesData {
  final int shiftBatchScheduleId;
  final bool success;
  final String message;
  final String weekDay;
  final String shiftName;
  final String officeStartTime;
  final String officeEndTime;
  final int companyId;

  ShiftBachesData({
    required this.shiftBatchScheduleId,
    required this.weekDay,
    required this.shiftName,
    required this.officeStartTime,
    required this.officeEndTime,
    required this.companyId,
    required this.success,
    required this.message,
  });
}
