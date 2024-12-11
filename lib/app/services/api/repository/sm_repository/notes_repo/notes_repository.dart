class NotesRepository{
  static String intakeNotes = "/intake-misc-note";
  static String byPatientsId = "/ByPatientId";
  static String add = "/add";
  static String patch ="/intake-misc-note";
  static String postUploadLabReport ="/intake-lab-report/UploadReportbase64/";
  static String getTypeDocMN ="/misc-document-type";
  static String uploadDocMN ="/intake-misc-note/UploadNotesbase64/";





  static  String getMiscNoteByPatientId({required int patientId}){
    return "$intakeNotes$byPatientsId/$patientId";
  }

  ///intake-misc-note/{miscNoteId}
  static  String deleteMiscNote({required int miscNoteId}){
    return "$intakeNotes/$miscNoteId";
  }

  ///intake-misc-note/add
  static String addMiscNote(){
    return "$intakeNotes$add";
  }


  static String patchMiscNote({required int miscNoteId}){
    return "$patch/$miscNoteId";
  }

  static String uploadDocPostLabReport({required int labReportId}){
    return "$postUploadLabReport$labReportId";
  }

  static String getDocTypeMisNotes(){
    return "$getTypeDocMN";
  }

  static String postUploadMN({required int miscNoteId}){
    return "$uploadDocMN$miscNoteId";
}
}