class ReferringDiagnosisModal {
  final int rDignosisPDId;
  final int rDignosisId;
  final int patientId;
  final String title;
  final String description;
  final String icdCode;
  final String pdDate;

  ReferringDiagnosisModal(
      {required this.rDignosisPDId,
      required this.rDignosisId,
      required this.patientId,
      required this.title,
      required this.description,
      required this.icdCode,
      required this.pdDate});
}
