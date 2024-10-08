// "licenseId": 23,
// "country": "Country3",
// "employeeId": 77,
// "expDate": "2024-07-19T05:59:02.929Z",
// "issueDate": "2024-07-19T05:59:02.929Z",
// "licenseUrl": "__",
// "licensure": "DDL48",
// "licenseNumber": "2525252",
// "org": "RTO",
// "documentType": "__",
// "approved": true

class LicensesDataForm {
  final int licenseId;
  final String country;
  final int employeeId;
  final String? expDate;
  final String issueDate;
  final String licenseUrl;
  final String licensure;
  final String licenseNumber;
  final String org;
  final String documentType;
  bool? approved;

  LicensesDataForm({
    required this.licenseId,
    required this.country,
    required this.employeeId,
    required this.expDate,
    required this.issueDate,
    required this.licenseUrl,
    required this.licensure,
    required this.licenseNumber,
    required this.org,
    required this.documentType,
    this.approved,
  });
}
