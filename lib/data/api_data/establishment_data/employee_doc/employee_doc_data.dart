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

class EmployeeDocumentModal {
  final String docName;
  final String expiry;
  final String reminderThreshold;
  final String idOfDocument;
  final int employeeDocTypesetupId;
  final int employeeDocTypeMetaId;
  final bool sucess;
  final String message;

  EmployeeDocumentModal({
    required this.employeeDocTypeMetaId,
    required this.employeeDocTypesetupId,
    required this.docName,
    required this.idOfDocument,
    required this.expiry,
    required this.reminderThreshold,
    required this.sucess,
    required this.message,
  });
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

class EmpDocAddEdit {
  final String docId;
  final String docName;
  final String docType;

  EmpDocAddEdit(this.docId, this.docName, this.docType);
}

class EmployeeDocTabModal {
  final String employeeDocType;
  final int employeeDocMetaDataId;
  final bool success;
  final String message;

  EmployeeDocTabModal({
    required this.employeeDocType,
    required this.employeeDocMetaDataId,
    required this.success,
    required this.message,
  });
}

class EmployeeDocSetupModal {
  final int employeeDocTypeSetupId;
  final int employeeDocMetaDataId;
  final String documentName;
  final String reminderThreshould;
  final String expiry;
  final bool success;
  final String message;

  EmployeeDocSetupModal({
    required this.employeeDocTypeSetupId,
    required this.employeeDocMetaDataId,
    required this.documentName,
    required this.expiry,
    required this.reminderThreshould,
    required this.success,
    required this.message,
  });
}

class GetEmployeeSetupPrefillData {
  final String docName;
  final String expiry;
  final String reminderThreshold;
  final String idOfDocument;
  final int employeeDocTypesetupId;
  final int employeeDocTypeMetaId;
  final bool sucess;
  final String message;

  GetEmployeeSetupPrefillData({
    required this.docName,
    required this.expiry,
    required this.reminderThreshold,
    required this.idOfDocument,
    required this.employeeDocTypesetupId,
    required this.employeeDocTypeMetaId,
    required this.sucess,
    required this.message,
  });
}
