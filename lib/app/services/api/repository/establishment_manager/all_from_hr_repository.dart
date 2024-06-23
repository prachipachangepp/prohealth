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

///zone
class AllZoneRepository{
  static String zone = "/zone";
  static String county = "/county";
  static String zipcodesetup = "/zipcode-setup";

  static String zoneGet(){
    return "$zone";
  }
  /// get
  static String zoneBYcompOfficeGet({required int companyId,required String officeId,required int pageNo,required int noOfRow}){
    return "$zone/$companyId/$officeId/$pageNo/$noOfRow";
  }
  ///county get last
  static String countyGet({required int companyId,required String officeId,required int pageNo,required int noOfRow}){
    return "$county/$companyId/$officeId/$pageNo/$noOfRow";
  }
  ///zipcode,zone get
  static String zipcodeSetupGet({required int companyId,required String officeId,required int pageNo,required int noOfRow}){
    return "$zipcodesetup/$companyId/$officeId/$pageNo/$noOfRow";
  }

}