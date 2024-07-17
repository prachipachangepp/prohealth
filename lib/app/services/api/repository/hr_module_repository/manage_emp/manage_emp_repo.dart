class ManageReposotory{
  static String employee_licenses = "/employee-licenses";
  static String references = "/reference";
  static String add = "/add";
  static String education = "/employee-educations";
  static String byemployeeId = "ByemployeeId";
  static String employement = "/employee-employment-histories";

  static String banking = "/employee-bankings";

  static String equipement = "/employee-inventories";

  static String gettermination = "/employees/allTerminatedEmployee";

  /// Employeement
  static String getEmployeement({required int employeeId}){
    return "$employement/$byemployeeId/$employeeId";
  }
  static String addEmployeement(){
    return "$employement$add";
  }
  static String updateEmployeement({required int employeementId}){
    return "$employement/$employeementId";
  }
  /// Education
  static String getEmployeeDucation({required int employeeId}){
    return "$education/$byemployeeId/$employeeId";
  }
  static String addEmployeeDucation(){
    return "$education$add";
  }
  static String patchEmployeeDucation({required int educationId}){
    return "$education/$educationId";
  }
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
  static String addReferences(){
    return "$references$add";
  }
  static String updateReferences({required int referenceId}){
    return "$references/$referenceId";
  }
  static String rejectReferences({required int referenceId}){
    return "$references/reject/$referenceId";
  }
  static String approveReferences({required int referenceId}){
    return "$references/approve/$referenceId";
  }

  /// Employee Banking
  static String getBankingEmployee({required int employeeId}){
    return "$banking/$byemployeeId/$employeeId";
  }

  static String getPrefillBankingEmployee({required int empBankingId}){
    return "$banking/$empBankingId";
  }

  static String addBankingEmployee(){
    return "$banking$add";
  }

  static String updateBankingEmployee({required int empBankingId}){
    return "$banking/$empBankingId";
  }
  /// Equipment

  static String addEquipement(){
    return "$equipement$add";
  }
  static String getEquipement(){
    return "$equipement";
  }
  static String getPrefillEquipement({required int empInventoryId}){
    return "$equipement/$empInventoryId";
  }
  static String patchEquipement({required int empInventoryId}){
    return "$equipement/$empInventoryId";
  }

  /// Termination
  static String getTermination({required int companyId}){
    return "$gettermination/$companyId";
  }
}