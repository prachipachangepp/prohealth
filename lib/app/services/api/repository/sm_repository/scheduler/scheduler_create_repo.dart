class SchedulerSMRepo{

  static String postscreate ="/scheduler-create/add";
  static String getscreate ="/scheduler-create/ByPatientId";
  static String schecularCalender = "/scheduler-create/ByClinician";

  static  String addCreate(){
    return "$postscreate";
  }

  static String getSCreate({required int patientId}){
    return "$getscreate/$patientId";
  }

  static String getScheduleBuClinitian({required int clinicianId}){
    return "$schecularCalender/$clinicianId";
  }
}