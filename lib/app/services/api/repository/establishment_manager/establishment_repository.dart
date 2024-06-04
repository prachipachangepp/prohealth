class EstablishmentManagerRepository {
  ///Company
  static String addCompany = "/Company/Insert";
  static String company = "/Company";
  static String details = "Details";
  static String companyLogo = "/company-logo";
  static String uploadLogo = "uploadLogo";
  static String companyContact = "/company-contact";
  static String add = "add";
  static String companyOffice = "/company-office/";
  static String companyOfficeservice ="/company-office-service";
  static String companyOfficeZone ="/company-office-zone";
  static String documentType = "/document-type";
  static String documentSubType ="/document-sub-type";
  static String document ="/document";
  static String adddocument ="/document/addDocument";
  static String attachDocument = "/attachDocument";
  static String companyOfficeDocument = "/company-office-document";

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

  ///post company-contact add
  static String companyContactAdd(){
    return "$companyContact/$add";
  }

  static String getCompanyContact(){
    return "$companyContact";
  }

  ///company-office/add
  static String companyOfficeAdd(){
    return "$companyOffice/$add";
  }

  static String getCompanyOffice(){
    return"$companyOffice";
  }

  static String companyOfficeById(
      {required int companyId})
  {
    return "$companyOffice/$companyId";
  }

  static String companyOfficeId(
      {required int officeId})
  {
    return "$companyOffice/$officeId";
  }

  /// company-office-service
  static String companyOfficeServiceAdd(){
    return "$companyOfficeservice/$add";
  }

  static String companyofficeService(){
    return"$companyOfficeservice";
  }

  static String companyOfficeServiceCompanyId({
    required int comapanyId
  }) {
    return "$companyOfficeservice/$comapanyId";
  }

  static String companyOfficeServiceOfficeServiceId(
      {
        required int officeServiceId
      }
      ){
    return "$companyOfficeservice/$officeServiceId";
  }


  static String deleteCompanyOfficeService({
    required int officeServiceId
  }){
    return "$companyOfficeservice/$officeServiceId";
  }


  ///company-office-zone
  static String addCompanyOfficeZone(){
    return "$companyOfficeZone/$add";
  }


  static String getCompanyOfficeZone(){
    return "$companyOfficeZone";
  }


  static String companyOfficeZoneCompanyId(
      {required int companyId }
      ){
    return "$companyOfficeZone/$companyId";
  }


  static String companyOfficeZoneOfficeZoneId(
      {required int officeZoneId }
      ){
    return "$companyOfficeZone/$officeZoneId";
  }


  static String deleteCompanyOfficeZoneOfficeZoneId(
      {required int officeZoneId }
      ){
    return "$companyOfficeZone/$officeZoneId";
  }


  ///document-type
  static String DocumentTypeAdd(){
    return "$documentType/$add";
  }
  static String getDocumentType(){
    return "$documentType";
  }
  static String getDocumentTypeById(
      { required int documentTypeId}
      ){
    return "$documentType/$documentTypeId";
  }
  static String patchDocumentTypeById(
      { required int documentTypeId}
      ){
    return "$documentType/$documentTypeId";
  }
  static String deleteDocumentTypeById(
      { required int documentTypeId}
      ){
    return "$documentType/$documentTypeId";
  }

  ///document-sub-type
  static String addDocumentSubType(){
    return "$documentSubType/$add";
  }

  static String getDocumentSubType(){
    return "$documentSubType";
  }

  static String getdocumentSubTypeById({
    required int documentSubTypeId
  }){
    return "$documentSubType/$documentSubTypeId";
  }

  static String patchDocumentSubTypeById({
    required int documentSubTypeId}
      ){
    return "$documentSubType/$documentSubTypeId";
  }

  static String deleteDocumentSubTypeById({
    required int documentSubTypeId}
      ){
    return "$documentSubType/$documentSubTypeId";
  }

  ///document
  static String addDocument(){
    return "/$document/$adddocument";
  }

  static String postAttachDocument({
    required int documentId
  }){
    return "/$document/$attachDocument/$documentId";
  }

  static String getDocument(){
    return "/$document";
  }

  static String getDocumentById({
    required int documentId
  }){
    return "/$document/$documentId";
  }

  static String patchDocumentById({
    required int documentId
  }){
    return "/$document/$documentId";
  }

  static String deleteDocumentById({
    required int documentId
  }){
    return "/$document/$documentId";
  }

  ///company-office-document
  static String addCompanyOfficeDocument(){
    return "/$companyOfficeDocument/$add";
  }

  static String getCompanyOfficeDocument(){
    return "/$companyOfficeDocument";
  }

  static String getCompanyOfficeDocumentByCompanyOfficeDocumentId({
    required int companyOfficeDocumentId
  }){
    return "/$companyOfficeDocument/$companyOfficeDocumentId";
  }

  static String patchCompanyOfficeDocumentByCompanyOfficeDocumentId({
    required int companyOfficeDocumentId
  }){
    return "/$companyOfficeDocument/$companyOfficeDocumentId";
  }

  static String deleteCompanyOfficeDocumentByCompanyOfficeDocumentId({
    required int companyOfficeDocumentId
  }){
    return "/$companyOfficeDocument/$companyOfficeDocumentId";
  }

  static String companyOfficeDocumentByCompanyId({
    required int companyId
  }){
    return "/$companyOfficeDocument/$companyId";
  }

  static String companyOfficeDocumentByOfficeId({
    required int officeId
  }){
    return "/$companyOfficeDocument/$officeId";
  }
///
}