class OnboardingQualificationRepo{
  static String emp_employment = "/employee-employment-histories";
  static String education = "/employee-educations";
  static String byemployeeId = "ByemployeeId";
  static String references = "/reference";
  static String employee_licenses = "/employee-licenses";
  static String employee_banking = "/employee-bankings";


  ///onboarding qualification
/// /employee-employment-histories
static String getEmpEmploymentHistories({required int employeeid}){
  return "$emp_employment/ByemployeeId/$employeeid";
}

/// /employee-educations
static String getEmpEducation({required int employeeid}){
  return "$education/$byemployeeId/$employeeid";
}
/// /reference
static String getEmpReference({required int employeeid}){
  return "$references/ByemployeeId/$employeeid";
}
/// /employee-licenses
static String getEmpLicense({required int employeeid}){
  return "$employee_licenses/ByemployeeId/$employeeid";
}

///onboarding Banking
static String getOnboardBanking({required int employeeid}){
  return "$employee_banking/ByemployeeId/$employeeid";
  }
}