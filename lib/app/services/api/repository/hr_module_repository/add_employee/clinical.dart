

class HRModuleAEClinicalRepository {


      ///employee type department
      static String emplyType = "/employee-types/";
      static String dept =  "Department/";
      ///city
      static String city = "/city";
      ///Reporting office
      static String companyOffice = "/company-office/";
      static String zone = "/zone/";

  static String getEmployeeTypeDept(int deptId){
    return "$emplyType$dept$deptId";
  }
  static String getAddEmployeeTypeCity(){
    return "$city";
  }
  static String getAddEmplyReportingOffice(int companyID){
    return "$companyOffice$companyID";
  }
  static String getAddEmplyZone(
      // { required int companyID,
      //   required int officeID,
      //   required int countyID,
      //   required int pageNo,
      //   required int rowsNo}
      ){
    return "$zone";
  }
}