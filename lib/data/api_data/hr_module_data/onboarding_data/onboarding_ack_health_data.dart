///get
class OnboardingAckHealthData {
  final String DocumentName;
  final int employeeDocumentId;
  final int EmployeeDocumentTypeMetaDataId;
  final int EmployeeDocumentTypeSetupId;
  final int employeeId;
  final String DocumentUrl;
  final String ReminderThreshold;
  final bool approved;

  OnboardingAckHealthData({
    required this.DocumentName,
    required this.employeeDocumentId,
    required this.EmployeeDocumentTypeMetaDataId,
    required this.EmployeeDocumentTypeSetupId,
    required this.employeeId,
    required this.DocumentUrl,
    required this.ReminderThreshold,
    required this.approved,
  });
}

