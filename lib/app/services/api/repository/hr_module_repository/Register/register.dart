class AllRegisterRepository{

  static String empEnroll = "/employee-enroll";
  static String filter = "/Filter";

  ///employee-enroll/Filter/{companyId}/{filter}
  static String getEmpEnrollFilter({required int compId,required String filter}){
    return "$empEnroll$filter/$compId/$filter";
  }
  ///employee-enroll/
  static String getEmployeeEnroll(){
    return "$empEnroll";
  }
  ///employee-enroll/{employeeEnrollId}
  static String getEmpEnrollByEnrollId({required int empEnrollId}){
    return "$empEnroll/$empEnrollId";
  }
}