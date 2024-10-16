class LegalDocumentsRepo{
  static String onCallDocument = "/call-html";
  static String covidTestDocument = "/covid-test-policy-html";
  static String ConfidentialStatementDocument = "/confidentiality-statement-html";
  static String reportingAbuseDocument = "/reporting-abuse";
  static String policyConcerningDocument = "/policy-concerning-third-party";
  static String standardConductDocument = "/standards-of-conduct";
  static String sexualHaressmentDocument = "/california-sexual-harassment";
  static String sexualAndUnlawfulDocument = "/sexual-and-other-unlawful/template";
  static String preAuthPatientVisitsDocument = "/pre-authorized-patient-visits";
  static String pro65Document = "/prop-65";
  static String returnOfCompanyDocument = "/return-of-company-property";
  static String hepBDocument = "/hep-b-declination-form";
  static String tDapDocument = "/tdap-declination-form";
  static String covidVaccineDocument = "/february-covid-vaccination-policy-mandatory";
  static String htmlFormTemplateSignatureAdd = "/form-html-templates-status/add/employee/form/Signatures";



  ///users/ByCompanyId/{companyId}
  static String getOnCallDocument({required int callHtmlId,required int employeeId}){
    return "$onCallDocument/$callHtmlId/$employeeId";
  }
  static String getCovidTestPolicyDocument({required int covidTestId,required int employeeId}){
    return "$covidTestDocument/$covidTestId/$employeeId";
  }
  static String getConfidentialStatementDocument({required int confidentialId,required int employeeId}){
    return "$ConfidentialStatementDocument/$confidentialId/$employeeId";
  }
  static String getreportingAbuseDocument({required int reportingAbuseId,required int employeeId}){
    return "$reportingAbuseDocument/$reportingAbuseId/$employeeId";
  }
  static String getpolicyConcerningDocument({required int policyConcerningId,required int employeeId}){
    return "$policyConcerningDocument/$policyConcerningId/$employeeId";
  }
  static String getStandardConductDocument({required int standardConductId,required int employeeId}){
    return "$standardConductDocument/$standardConductId/$employeeId";
  }
  static String getSexualHaressmentDocument({required int templateId,required int employeeId}){
    return "$sexualHaressmentDocument/$templateId/$employeeId";
  }
  static String getSexualAndUnlawfulDocument({required int templateId,required int employeeId}){
    return "$sexualAndUnlawfulDocument/$templateId/$employeeId";
  }
  static String getPreAuthPatientVisitsDocument({required int templateId,required int employeeId}){
    return "$preAuthPatientVisitsDocument/$templateId/generate-html/$employeeId";
  }
  static String getPro65Document({required int templateId,required int employeeId}){
    return "$pro65Document/$templateId/generate-html/$employeeId";
  }
  static String getReturnOfCompanyDocument({required int templateId,required int employeeId}){
    return "$returnOfCompanyDocument/$templateId/generate-html/$employeeId";
  }
  static String getHepBDocument({required int templateId,required int employeeId}){
    return "$hepBDocument/$templateId/generate-html/$employeeId";
  }
  static String getTDapDocument({required int templateId,required int employeeId}){
    return "$tDapDocument/$templateId/generate-html/$employeeId";
  }
  static String getCovidVaccineDocument({required int templateId,required int employeeId}){
    return "$covidVaccineDocument/$templateId/generate-html/$employeeId";
  }
  static String postHemlTemplateFormSignature(){
    return "$htmlFormTemplateSignatureAdd";
  }
}
