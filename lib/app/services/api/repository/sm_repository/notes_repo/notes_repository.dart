class NotesRepository{
  static String intakeNotes = "/intake-misc-note";
  static String byPatientsId = "/ByPatientId";
  static String add = "/add";

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

}