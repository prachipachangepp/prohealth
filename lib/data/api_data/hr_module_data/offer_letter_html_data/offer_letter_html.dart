

class OfferLetterData{
  final String docUploadStatus;
  final String templateName;
  final String template;
  final int offerId;
  final int? statusCode;

  OfferLetterData( {
    this.statusCode,
    required this.offerId,
    required this.docUploadStatus, required this.templateName, required this.template,

  });
}

class EmployeeIdByEmail{
  final int employeeID;

  EmployeeIdByEmail({required this.employeeID,
  });
}