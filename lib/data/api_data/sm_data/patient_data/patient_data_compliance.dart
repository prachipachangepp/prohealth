class  PatientDataComplianceModal{
  final int? complianceId;
  final int? patientId;
  final int? docTypeId;
  final String? docName;
  final String? docUrl;
  final String? expDate;

  PatientDataComplianceModal({
    this.complianceId,
    this.patientId,
    this.docTypeId,
    this.docName,
    this.docUrl,
    this.expDate
 });
}

class PatientDataComplianceDoc{
  final int? docTypeId;
  final int? companyId;
  final String? docType;
  final String? docName;
  final String? expireType;
  final String? expDate;

  PatientDataComplianceDoc({
    this.docTypeId,
    this.companyId,
    this.docType,
    this.docName,
    this.expireType,
    this.expDate
});
}