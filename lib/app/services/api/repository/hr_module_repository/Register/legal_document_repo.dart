class LegalDocumentsRepo{
  static String onCallDocument = "/call-html";
  static String covidTestDocument = "/covid-test-policy-html";
  static String ConfidentialStatementDocument = "/confidentiality-statement-html";
  static String reportingAbuseDocument = "/reporting-abuse";
  static String policyConcerningDocument = "/policy-concerning-third-party";
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
  static String postHemlTemplateFormSignature(){
    return "$htmlFormTemplateSignatureAdd";
  }
}