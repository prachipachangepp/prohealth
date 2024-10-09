class LegalDocumentsRepo{
  static String onCallDocument = "/call-html";

  ///users/ByCompanyId/{companyId}
  static String getOnCallDocument({required int callHtmlId,required int employeeId}){
    return "$onCallDocument/$callHtmlId/$employeeId";
  }
}