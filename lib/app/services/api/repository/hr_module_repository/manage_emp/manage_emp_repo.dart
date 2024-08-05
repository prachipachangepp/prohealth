class ManageReposotory{
  static String employee_licenses = "/employee-licenses";
  static String references = "/reference";
  static String add = "/add";
  static String education = "/employee-educations";
  static String byemployeeId = "ByemployeeId";
  static String employement = "/employee-employment-histories";
  static String selectDocuments = "/corporate-document";
  static String banking = "/employee-bankings";

  static String equipement = "/employee-inventories";

  static String payrates = "/employee-payrates/ByEmployeeId";

  static String gettermination = "/employees/allTerminatedEmployee";

  static String employeeTimeOff = "/employee-time-off";

  static String licenseStatus = "/employee-licenses/LicenseDetailByemployeeId";


  /// Licenses status wise

  static String getLicenseStatus({required int employeeId,required String approvedOnly}){
    return "$licenseStatus/$employeeId/$approvedOnly";
  }

  /// Employeement
  static String getEmployeement({required int employeeId,required String approveOnly}){
    return "$employement/$byemployeeId/$employeeId/$approveOnly";
  }
  static String addEmployeement(){
    return "$employement$add";
  }
  static String updateEmployeement({required int employeementId}){
    return "$employement/$employeementId";
  }
  /// Education
  static String getEmployeeDucation({required int employeeId,required String approveOnly}){
    return "$education/$byemployeeId/$employeeId/$approveOnly";
  }
  static String addEmployeeDucation(){
    return "$education$add";
  }
  static String patchEmployeeDucation({required int educationId}){
    return "$education/$educationId";
  }
  /// Employee licences
  static String getEmployeeLicenses({required int employeeid,required String approveOnly}){
    return "$employee_licenses/ByemployeeId/$employeeid/$approveOnly";
  }
  static String getselectDocuments(){
    return "$selectDocuments";
  }
  static String addEmployeeLicenses(){
    return "$employee_licenses$add";
  }
  static String attachLicenseDocument({required int licenseId}){
    return "$employee_licenses/attach-licensebase64/$licenseId";
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
  static String referenceByemployeeIdGet({required int employeeId,required String approveOnly}){
    return "$references/ByemployeeId/$employeeId/$approveOnly";
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
  static String getBankingEmployee({required int employeeId,required String approveOnly}){
    return "$banking/$byemployeeId/$employeeId/$approveOnly";
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

  static String uploadBanckingDocuments({required int empBankingId}){
    return "$banking/attach-checkbase64/$empBankingId";
  }

  static String approveBankingEmployee({required int empBankingId}){
    return "/employee-bankings/approve/$empBankingId";
  }

  static String rejectBankingEmployee({required int empBankingId}){
    return "/employee-bankings/reject/$empBankingId";
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

  /// Payrates

  static String getEmployeePayrates({required int employeeID, required int pagNo, required int noOfRows}){
    return "$payrates/$employeeID/$pagNo/$noOfRows";
  }

  static String deleteEmployeePayrates({required int employeePayratesId}){
    return "$payrates/$employeePayratesId";
  }

  /// Termination
  static String getTermination({required int companyId}){
    return "$gettermination/$companyId";
  }
  /// Time offf
  static String getEmployeeTimeOff({required int companyId}){
    return "$employeeTimeOff/ByCompany/$companyId";
  }
  static String getEmployeePrefillTimeOff({required int employeeTimeOffId}){
    return "$employeeTimeOff/$employeeTimeOffId";
  }
  static String patchEmployeeTimeOff({required int employeeTimeOffId}){
    return "$employeeTimeOff/$employeeTimeOffId";
  }
  static String approveTimeOffPatch({required int employeeTimeOffId}){
    return"$employeeTimeOff/approve/$employeeTimeOffId";
  }
  static String rejectTimeOffPatch({required int employeeTimeOffId}){
    return"$employeeTimeOff/reject/$employeeTimeOffId";
  }
}