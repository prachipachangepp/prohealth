class OnboardingQualificationRepo {
  static String emp_employment = "/employee-employment-histories";
  static String education = "/employee-educations";
  static String byEmployeeId = "/ByemployeeId";
  static String references = "/reference";
  static String employee_licenses = "/employee-licenses";
  static String employee_banking = "/employee-bankings";
  static String employee_doc = "/employee-documents";
  static String approve = "/approve";
  static String reject = "/reject";

  /// /employee-employment-histories
  static String getEmpEmploymentHistories({required int employeeid}) {
    return "$emp_employment/ByemployeeId/$employeeid";
  }

  static String rejectEmpEmployment({required int employmentId}) {
    return "$emp_employment/reject/$employmentId";
  }

  static String approveEmpEmployment({required int employmentId}){
    return "$emp_employment/approve/$employmentId";
  }

  /// /employee-educations
  static String getEmpEducation({required int employeeid}) {
    return "$education/$byEmployeeId/$employeeid";
  }

  static String rejectEmpEducation({required int educationId}) {
    return "$education/reject/$educationId";
  }

  static String approveEmpEducation({required int educationId}){
    return "$education/approve/$educationId";
  }

  /// /reference
  static String getEmpReference({required int employeeid}) {
    return "$references/ByemployeeId/$employeeid";
  }

  static String rejectEmpReference({required int referenceId}) {
    return "$references/reject/$referenceId";
  }

  static String approveEmpReference({required int referenceId}){
    return "$references/approve/$referenceId";
  }

  /// /employee-licenses
  static String getEmpLicense({required int employeeid}) {
    return "$employee_licenses/ByemployeeId/$employeeid";
  }

  static String rejectEmpLicenses({required int licensedId}) {
    return "$employee_licenses/reject/$licensedId";
  }

  static String approveEmpLicenses({required int licensedId}){
    return "$employee_licenses/approve/$licensedId";
  }

  ///onboarding Banking
  static String getOnboardBanking({required int employeeid}) {
    return "$employee_banking/ByemployeeId/$employeeid";
  }

  static String rejectOnboardBank({required int empBankingId}) {
    return "$employee_banking/reject/$empBankingId";
  }


  ///onboarding Acknowledment & health record
  //employee-documents/ByemployeeId/{EmployeeDocumentTypeMetaDataId}/{EmployeeDocumentTypeSetupId}/{employeeId}
  static String getAckHealthRecord({required int EmpDocTypeMetaDataId,required int EmpDocTypeSetupId,required int employeeId}) {
    return "$employee_doc$byEmployeeId/$EmpDocTypeMetaDataId/$EmpDocTypeSetupId/$employeeId";
  }
  //employee-documents/approve/{employeeDocumentId}
  static String approveAckHealthRecord({required int employeeDocumentId}) {
    return "$employee_doc$approve/$employeeDocumentId";
  }
  //employee-documents/reject/{employeeDocumentId}
  static String rejectAckHealthRecord({required int employeeDocumentId}) {
    return "$employee_doc$reject/$employeeDocumentId";
  }
}
