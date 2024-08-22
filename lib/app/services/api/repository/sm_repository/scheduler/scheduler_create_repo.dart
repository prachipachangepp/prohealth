class SchedulerSMRepo{

  static String postscreate ="/scheduler-create/add";
  static String getscreate ="/scheduler-create/ByPatientId";

  static  String addCreate(){
    return "$postscreate";
  }

  static String getSCreate({required int patientId}){
    return "$getscreate/$patientId";
  }
}