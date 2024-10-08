class TimeOfffData {
  final int employeeTimeOffId;
  final int employeeId;
  final String employeeName;
  final String timeOffRequest;
  final String reson;
  final String startTime;
  final String endTime;
  final String sickTime;
  final String hours;
  final String imageUrl;
  bool? approved;
  TimeOfffData({
    this.approved,
    required this.imageUrl,
    required this.employeeTimeOffId,
    required this.employeeId,
    required this.employeeName,
    required this.timeOffRequest,
    required this.reson,
    required this.startTime,
    required this.endTime,
    required this.sickTime,
    required this.hours,
  });

}

class TimeOfPrefillData {
  final int employeeTimeOffId;
  final int employeeId;
  final String employeeName;
  final String timeOffRequest;
  final String reson;
  final String startTime;
  final String endTime;
  final String sickTime;
  final String hours;
  TimeOfPrefillData({
    required this.employeeTimeOffId,
    required this.employeeId,
    required this.employeeName,
    required this.timeOffRequest,
    required this.reson,
    required this.startTime,
    required this.endTime,
    required this.sickTime,
    required this.hours,
  });
}
