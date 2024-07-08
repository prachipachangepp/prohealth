class OnboardingQualificationRepo{
  static String emp_employment = "/employee-employment-histories";
  static String byEmpId = "/ByemployeeId";

/// /employee-employment-histories/ByemployeeId/{employeeId}
static String getEmpEmploymentHistories({required int employeeid}){
  return "$emp_employment/ByemployeeId/$employeeid";
}
}