class PatientDataInfoRepo{
  static String infoGet = "/intake-patient-info/";
  static String infoAdd = "/intake-patient-info/add";
  static  String getInfoPatientData({required int patientId} ){
    return "$infoGet$patientId";
  }
  static  String addInfoPatientData(){
    return "$infoAdd";
  }
}

