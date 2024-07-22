class OnboardingAckHealthData {
  final int employeeDocumentId;
  final int EmployeeDocumentTypeMetaDataId;
  final int EmployeeDocumentTypeSetupId;
  final int employeeId;
  final String DocumentUrl;
  final String UploadDate;
  final bool approved;

  OnboardingAckHealthData({
    required this.employeeDocumentId,
    required this.EmployeeDocumentTypeMetaDataId,
    required this.EmployeeDocumentTypeSetupId,
    required this.employeeId,
    required this.DocumentUrl,
    required this.UploadDate,
    required this.approved,
  });
}
