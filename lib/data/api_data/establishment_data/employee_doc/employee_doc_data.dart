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
  final String? name;
  final String? expiry;
  final String? reminderThreshold;
  final int? pageNo;
  final int? rowsNo;
  final int? employeeDocTypesetupId;
  final bool sucess;
  final String message;

  EmployeeDocumentModal( {
    this.pageNo, this.rowsNo, this.employeeDocTypesetupId,
    this.name, this.expiry,
    this.reminderThreshold,required this.sucess, required this.message,});
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

class EmployeeDocTabModal {
  final String? employeeDocType;
  final int? employeeDocMetaDataId;
  final bool success;
  final String message;

  EmployeeDocTabModal({

    this.employeeDocType,
    this.employeeDocMetaDataId,
    required this.success, required this.message,
  });
}