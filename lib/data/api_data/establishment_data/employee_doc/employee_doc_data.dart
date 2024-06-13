class EmpDocHealth {
 final String? name;
 final String? expiry;
 final String? reminderThreshold;

  EmpDocHealth({this.name, this.expiry, this.reminderThreshold});
}

class EmpDocCertification {
  final String? name;
  final String? expiry;
  final String? reminderThreshold;

  EmpDocCertification({this.name, this.expiry, this.reminderThreshold});
}

class EmpDocEmployment {
  final String? name;
  final String? expiry;
  final String? reminderThreshold;

  EmpDocEmployment({this.name, this.expiry, this.reminderThreshold});
}

class EmpDocClinicalVerify {
  final String? name;
  final String? expiry;
  final String? reminderThreshold;

  EmpDocClinicalVerify({this.name, this.expiry, this.reminderThreshold});
}

class EmpDocAcknowledgement {
  final String? name;
  final String? expiry;
  final String? reminderThreshold;

  EmpDocAcknowledgement({this.name, this.expiry, this.reminderThreshold});
}

class EmpDocCompensation {
  final String? name;
  final String? expiry;
  final String? reminderThreshold;

  EmpDocCompensation({this.name, this.expiry, this.reminderThreshold});
}

class EmpDocPerformance {
  final String? name;
  final String? expiry;
  final String? reminderThreshold;

  EmpDocPerformance({this.name, this.expiry, this.reminderThreshold});
}


class EmpDocAddEdit{
  final String docId;
  final String docName;
  final String docType;

  EmpDocAddEdit(this.docId, this.docName, this.docType);
}