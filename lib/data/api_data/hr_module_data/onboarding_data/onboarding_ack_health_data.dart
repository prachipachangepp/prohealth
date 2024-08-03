///get
class OnboardingAckHealthData {
  final String DocumentName;
  final String Expiry;
  final String ReminderThreshold;
  final String DocumentType;
  final int EmployeeDocumentTypeMetaDataId;
  final int EmployeeDocumentTypeSetupId;
  final String DocumentUrl;
  final int employeeDocumentId;
  final int employeeId;
  bool? approved;

  OnboardingAckHealthData({
    required this.DocumentName,
    required this.employeeDocumentId,
    required this.EmployeeDocumentTypeMetaDataId,
    required this.EmployeeDocumentTypeSetupId,
    required this.employeeId,
    required this.DocumentUrl,
    required this.ReminderThreshold,
    required this.Expiry, required this.DocumentType,
    this.approved
   // required this.approved,
  });
}

