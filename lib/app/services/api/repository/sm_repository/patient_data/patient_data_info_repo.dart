class PatientDataInfoRepo{
  static String infoGet = "/intake-patient-info/";
  static String infoAdd = "/intake-patient-info/add";
  static String complianceGet = "/intake-patient-compliance";
  static String deleteCompliance = "/intake-patient-compliance/";
  static String addCompliance = "/intake-patient-compliance/add";
  static String getComplianceDoc = "/intake-patient-compliance-documents";
  static String getCompliance = "/intake-patient-compliance/ByPatientId/";
  static String addRelatedParty = "/intake-patient-related-party/add";
  static String addStayInfo = "/intake-patient-stay-info/add";
  static String addRefferalInfo = "/intake-referral-info/add";
  static String addAgencyInfo = "/intake-referral-agency-info/add";
  static String getlabReport = "/intake-lab-report/ByPatientId/";
  static String addlabReport = "/intake-lab-report/add";
  static String deletelabReport = "/intake-lab-report/";

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
  static String complianceByPatientIdGet({required int patientId}){
    return "$getCompliance$patientId";
  }
  static String complianceDocget(){
    return "$getComplianceDoc";
  }
  static String relatedPartyAdd(){
    return "$addRelatedParty";
  }
  static String stayInfoAdd(){
    return "$addStayInfo";
  }
  static String referralInfoAdd(){
    return "$addRefferalInfo";
  }
  static String agencyInfoAdd(){
    return "$addAgencyInfo";
  }
  static String labReportGet({required int patientId}){
    return "$getlabReport$patientId";
  }
  static String labReportAdd(){
    return "$addlabReport";
  }
  static String labReportDelete({required int labReportId}){
    return "$deletelabReport$labReportId";
}
}

