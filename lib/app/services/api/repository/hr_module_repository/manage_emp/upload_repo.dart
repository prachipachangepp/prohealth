class UploadDocumentRepository{
  static const String uploadEmployeeDocument = "/employee-documents/uploadDocumentbase64";

  static String uploadEmployeeDocumentGet({required int employeeDocumentTypeMetaDataId,required int employeeDocumentTypeSetupId, required int employeeId}){
    return "$uploadEmployeeDocument/$employeeDocumentTypeMetaDataId/$employeeDocumentTypeSetupId/$employeeId";
  }
}