class SchedulerSMRepo{

  static String postscreate ="/scheduler-create/add";
  static String getscreate ="/scheduler-create/ByPatientId";
  static String schecularCalender = "/scheduler-create/ByClinician";
  static String schedule = "/scheduler-create";

  static  String addCreate(){
    return "$postscreate";
  }
  static  String updateSchedule({required int schedulerCreateId}){
    return "$schedule/$schedulerCreateId";
  }

  static String getSCreate({required int patientId}){
    return "$getscreate/$patientId";
  }
  static String getPreFillSchedule({required int schedulerId}){
    return "$schedule/$schedulerId";
  }
  static String getScheduleBuClinitian({required int clinicianId}){
    return "$schecularCalender/$clinicianId";
  }
}