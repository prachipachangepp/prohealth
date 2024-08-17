class PatientDataInfoRepo{
  static String infoGet = "/intake-patient-info/";
  static String infoAdd = "/intake-patient-info/add";
  static String complianceGet = "/intake-patient-compliance";
  static String deleteCompliance = "/intake-patient-compliance/";
  static String addCompliance = "/intake-patient-compliance/add";
  static String getComplianceDoc = "/intake-patient-compliance-documents";
  static String addRelatedParty = "/intake-patient-related-party/add";

  static  String getInfoPatientData({required int patientId} ){
    return "$infoGet$patientId";
  }
  static  String addInfoPatientData(){
    return "$infoAdd";
  }
  static String getPatientCompliance(){
    return "$complianceGet";
  }
  static String deletePDCompliance({required int ComplianceId }){
    return "$deleteCompliance$ComplianceId";
  }
  static String postPDCompliance(){
    return "$addCompliance";
  }
  static String complianceDocget(){
    return "$getComplianceDoc";
  }
  static String relatedPartyAdd(){
    return "$addRelatedParty";
  }
}

