class OnboardingQualificationRepo{
  static String emp_employment = "/employee-employment-histories";
  static String byEmpId = "/ByemployeeId";

/// /employee-employment-histories/ByemployeeId/{employeeId}
static String getEmpEmploymentHistories({required int employeeid}){
  return "$emp_employment/ByemployeeId/$employeeid";
}

/// /employee-educations/ByemployeeId/{employeeId}
static String getEmpEducation({required int employeeid}){
  return "$emp_employment$byEmpId/$employeeid";
}
/// /reference/ByemployeeId/{employeeId}
static String getEmpReference({required int employeeid}){
  return "$emp_employment$byEmpId/$employeeid";
}
/// /employee-licenses/ByemployeeId/{employeeId}
static String getEmpLicense({required int employeeid}){
  return "$emp_employment$byEmpId/$employeeid";
}
}