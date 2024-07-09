class OnboardingQualificationRepo{
  static String emp_employment = "/employee-employment-histories";
  static String education = "/employee-educations";
  static String byemployeeId = "ByemployeeId";
  static String references = "/reference";
  static String employee_licenses = "/employee-licenses";

/// /employee-employment-histories/ByemployeeId/{employeeId}
static String getEmpEmploymentHistories({required int employeeid}){
  return "$emp_employment/ByemployeeId/$employeeid";
}

/// /employee-educations/ByemployeeId/{employeeId}
static String getEmpEducation({required int employeeid}){
  return "$education/$byemployeeId/$employeeid";
}
/// /reference/ByemployeeId/{employeeId}
static String getEmpReference({required int employeeid}){
  return "$references/ByemployeeId/$employeeid";
}
/// /employee-licenses/ByemployeeId/{employeeId}
static String getEmpLicense({required int employeeid}){
  return "$employee_licenses/ByemployeeId/$employeeid";
}
}