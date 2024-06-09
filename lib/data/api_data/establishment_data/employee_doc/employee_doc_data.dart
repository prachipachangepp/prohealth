class EmpDocument {
 final String name;
 final String expiry;
 final String reminderThreshold;

  EmpDocument(this.name, this.expiry, this.reminderThreshold);
}

class EmpDocAddEdit{
  final String docId;
  final String docName;
  final String docType;

  EmpDocAddEdit(this.docId, this.docName, this.docType);
}