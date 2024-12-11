class UploadDocumentRepository{
  static const String uploadEmployeeDocument = "/employee-documents/uploadDocumentbase64";
  static const String patchEmployeeDocument =  "/employee-documents";

  static String uploadEmployeeDocumentGet({required int employeeDocumentTypeMetaDataId,required int employeeDocumentTypeSetupId, required int employeeId}){
    return "$uploadEmployeeDocument/$employeeDocumentTypeMetaDataId/$employeeDocumentTypeSetupId/$employeeId";
  }
  static String PatchEmployeeDocumentGet({required int employeeDocumentId,}){
    return "$patchEmployeeDocument/$employeeDocumentId";
  }
}