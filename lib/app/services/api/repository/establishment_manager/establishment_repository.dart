class EstablishmentManagerRepository {
  ///Company
  static String addCompany = "/Company/Insert";
  static String company = "/Company";
  static String details = "Details";
  static String companyLogo = "/company-logo";
  static String uploadLogo = "uploadLogo";
  static String companyOffice = "/company-office";
  static String add = "/add";
  static String document = "/document";
  static String addDocument = "/document/addDocument";
  static String companyOfficeService = "/company-office-service";
  static String identity = "/identity";
  static String companyList = "/companyList";
  static String officeDetails = "officeDetailWithServiceByCompany";
  static String getDocType = "/GetDocType";
  static String getDocTypeManageCC = "/document-type";
  static String getDocListCompany = "/GetDocumentListByCompany";
  static String visit = "/visits";
  static String documentType = "/document-type";
  static String identityDocumentType = "/identity/GetDocType";
  static String getlistByCompany = "/officeListByCompany";
  static String addCorporateDocument = "/corporate-document/addDocument";
  static String workWeekSchedule = "/work-week-schedule";
  static String workWeekShiftSchedule = "/work-week-shift-schedule";
  static String holidays = "/holidays";
  static String employeedocSetup = "/employee-document-type-setup";
  static String getEmployeedocTab= "/employee-document-type-meta-data";
  static String payRatesSetup = "/payrates-setup";
  static String employeeType = "/employee-types";
  static String user = "/users";


  static String companyAll(){
    return "$company";
  }
  static String companyById({required int companyId}) {
    return "$company/$companyId";
  }

  static String companyDetails({required int companyId}) {
    return "$company/$companyId/$details";
  }

  static String uploadCompanyLogo(
      {required int companyId, required String type}) {
    return "$companyLogo/$type/$companyId/$uploadLogo";
  }

  static String addNewOffice() {
    return "$companyOffice/$add";
  }
///identity get all
  static String companyOfficeGet({required int pageNo, required int rowsNo }) {
    return "$identity/$companyList/$pageNo/$rowsNo";
  }

  static String orgDocumentGet(){
    return "$document";
  }
  static String addOrgDocumentPost(){
    return "$addDocument";
  }
  static String updateOrgCocument({required int docId}){
    return "$document/$docId";
  }
  static String companyOfficeServiceGet(){
    return "$companyOfficeService";
  }
  static String postCompanyOffice(){
    return "$companyOffice/$add";
  }
  ///manage cc 5 screens
  static String getManageCorporateComp(){
    return "$getDocTypeManageCC";
  }
  ///manage details
  static String getManageDetails({required int companyID, required String officeId}){
    return "$identity/$officeDetails/$companyID/$officeId";
  }
  ///manage details service post
  static String companyOfficeServicePost(){
    return "$companyOfficeService/$add";
  }
  ///manage corporate and compliance flow
  static String corporateGetDocType({required int docTypeId}){
    return "$identity/$getDocType";
  }
  ///
 static String corporateGetListbyCompany({required int companyId,required String officeId,required int docTypeID,required int docSubTypeID,required int pageNo, required int rowsNo}){
    return "$identity/$getDocListCompany/$companyId/$officeId/$docTypeID/$docSubTypeID/$pageNo/$rowsNo";
}
  static String getCiOrgDLicense({required int companyId,required int docTypeID,required int docSubTypeID,required int pageNo, required int rowsNo}){
    return "$identity/$getDocListCompany/$companyId/$docTypeID/$docSubTypeID/$pageNo/$rowsNo";
  }
static String getOrgDocument(){
    return "/$document";
}
static String getCiVisit(){
    return "/$visit";
}
static String postCiVisit(){
    return "/$visit/$add";
}
  static String documentTypeGet(){
    return "/$documentType";
  }
  static String identityDocumentTypeGet({required int docId}){
    return "/$identityDocumentType/$docId";
  }
  static String companyOfficeListGet({required int companyId,
    required int pageNo, required int rowsNo }){
    return "/$identity$getlistByCompany/$companyId/$pageNo/$rowsNo";
  }
  static String addCorporateDocumentPost(){
    return "$addCorporateDocument";
  }
  /// Work Schedule
  static String workWeekScheduleGet(){
    return "$workWeekSchedule";
  }
  static String workWeekShiftScheduleGet({required int companyId,required String officeId, required String weekDay}){
    return "$workWeekShiftSchedule/$weekDay/$companyId/$officeId";
  }
  static String addWorkWeekShiftPost(){
    return "$workWeekShiftSchedule$add";
  }
  static String addWorkWeekSchedulePost(){
    return "$workWeekSchedule$add";
  }

  // Hlidays
  static String holidaysGet(){
    return "$holidays";
  }
  static String addHolidaysPost(){
    return "$holidays$add";
  }
  static String deleteHolidaysDelete({required int holidayId}){
    return "$holidays/$holidayId";
  }
  static String updateHolidaysPatch({required int holidayId}){
    return "$holidays/$holidayId";
  }
    ///employee doc list
  static String getEmployeeDocSetUpMetaId({
    /// required int metaDocId
    required int pageNo, required int rowsNo,
    required int employeeDocTypeMetaDataId
  }){
    /// return "$employeedocSetup/$metaDocId";
     return "$employeedocSetup/$employeeDocTypeMetaDataId/$pageNo/$rowsNo";
  }
   ///employee doc tab bar
  static String getEmployeeDocSetup(){
    return "$getEmployeedocTab";
  }

  /// Pay Rates get data
  static String payRatesSetupGet({required int pageNo,required int noOfRows}){
    return "$payRatesSetup/$pageNo/$noOfRows";
  }

  /// Employee type add POST
  static String addEmployeeTypePost(){
    return "$employeeType$add";
  }

  static String deleteEmployeeTypes({
    required int employeeTypeId
   }){
    return "$employeeType/$employeeTypeId";
  }
  static String deleteEmployeedoctypesetup({
    required int employeeDoctypeSetupId
   }){
    return "$employeedocSetup/$employeeDoctypeSetupId";
  }
  static String postEmployeedocTypesetup(){
    return "$employeedocSetup/$add";
  }
  static String userGet(){
    return "$user";
  }
}
