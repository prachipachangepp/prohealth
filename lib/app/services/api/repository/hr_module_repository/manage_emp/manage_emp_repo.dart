class ManageReposotory{
  static String employee_licenses = "/employee-licenses";
  static String references = "/reference";
  static String add = "/add";

  /// Employee licences
  static String getEmployeeLicenses({required int employeeid}){
    return "$employee_licenses/ByemployeeId/$employeeid";
  }
  static String addEmployeeLicenses(){
    return "$employee_licenses$add";
  }
  static String rejectEmployeeLicenses({required int licensedId}){
    return "$employee_licenses/reject/$licensedId";
  }
  static String approveEmployeeLicenses({required int licensedId}){
    return "$employee_licenses/approve/$licensedId";
  }
  static String updateEmployeeLicenses({required int licensedId}){
    return "$employee_licenses/$licensedId";
  }
  static String dropdownAttaceLicences({required int licensedId}){
    return "$employee_licenses/attach-license/$licensedId";
  }


  /// References
  static String referenceByemployeeIdGet({required int employeeId}){
    return "$references/ByemployeeId/$employeeId";
  }
  static String rejectReferences({required int referenceId}){
    return "$references/reject/$referenceId";
  }
  static String approveReferences({required int referenceId}){
    return "$references/approve/$referenceId";
  }
}