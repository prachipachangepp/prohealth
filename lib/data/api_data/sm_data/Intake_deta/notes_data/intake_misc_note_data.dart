class  IntakeNotesMiscData{
  final int miscNoteId;
  final int patientId;
  final int docTypeId;
  final String docType;
  final String docUrl;
  final String name;
  final String createdAt;
  final String expDate;

  IntakeNotesMiscData({
   required this.miscNoteId,
    required this.patientId,
    required this.docTypeId,
    required this.docType,
    required this.docUrl,
    required this.name,
    required this.createdAt,
    required this.expDate,
  });
}