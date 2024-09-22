class AllRegisterRepository{

  static String empEnroll = "/employee-enroll";
  static String add = "/add";
  static String offers = "/addOffers";
  static String addZipCode = "/addZipCodes";
  static String addCompensation = "/addCompensations";
  static String cities = "/addCities";
  static String addCoverage = "/addCoverage";
  static String filter = "/Filter";
  static String onboarbingUser = "/employees/onboard";

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
  ///employee-enroll/add
  static String addEmpEnrollAdd(){
    return "$empEnroll$add";
  }
  ///employee-enroll/addOffers
  static String addEmpEnrollOffers(){
    return "$empEnroll$offers";
  }
  ///employee-enroll/addZipCodes
  static String addEmpEnrollZipCodes(){
    return "$empEnroll$addZipCode";
  }
  ///employee-enroll/addCompensations
  static String addEmpEnrollCompensation(){
    return "$empEnroll$addCompensation";
  }
  ///employee-enroll/addCities
  static String addEmpEnrollCities(){
    return "$empEnroll$cities";
  }
  ///employee-enroll/addCoverage
  static String addEmpEnrolladdCoverage(){
    return "$empEnroll$addCoverage";
  }
  ///employee-enroll/addCoverage
  static String PatchEmpEnrolladdCoverage({required int empEnrollId}){
    return "$empEnroll/updateCoverage/$empEnrollId";
  }
  /// employee_onboarding patch
  static String patchOnboardingEmployee({required int employeeId}){
    return "$onboarbingUser/$employeeId";
  }
}