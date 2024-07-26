

// GET/employee-offers/GetEmployeeOffer/{EmployeeId}/{templateId
// 3.Upload signature-----POST/employees/upload-signature/{employeeId}
// 4.accept offer----PATCH/employee-offers/acceptOffer/{offerId}

class OfferLetterHtmlRepo{
  ///get offer letter /employee-offers/GetEmployeeOffer/{EmployeeId}/{templateId}
  static String getOfferLetter = "/employee-offers/GetEmployeeOffer/";
  static String getOfferLetterHtml({ required  int employeeId, required int templateId}){
    return "$getOfferLetter$employeeId/$templateId";
  }

  ///upload sign
  static String uploadSignature = "/employees/upload-signature/";
  static String getUploadSign({employeeId}){
    return "$uploadSignature$employeeId";
  }

  ///accept offer
  static String  updateOfferLetter = "/employee-offers/acceptOffer/";
  static String  patchAcceptOffer({offerId}){
    return "$updateOfferLetter$offerId";
  }


}