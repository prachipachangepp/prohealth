class ManageEmployeeReposotory{
  static String employee_licenses = "/employee-licenses";

  static String getEmployeeLicenses({required int employeeid}){
    return "$employee_licenses/ByemployeeId/$employeeid";
  }
}