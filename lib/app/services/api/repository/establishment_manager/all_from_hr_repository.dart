class AllFromHrRepository{
  ///Clinical
  static String empType = "/employee-types";
  static String companyDept = "/company-department";

  static String getEmployeeType(){
    return "$empType";
  }
  static String getHrType(){
    return "$companyDept";
  }
  static String patchHRType({required int empId}){
    return "$empType/$empId";
  }
  static String getEmpTypeById({required int empId}){
    return "$empType/$empId";
  }
}