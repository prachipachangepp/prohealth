

class HRModuleAEClinicalRepository {


 ///employee type department
      static String emplyType = "/employee-types/";
      static String dept =  "Department/";

  static String getEmployeeTypeDept(
      int deptId
      ){
    return "$emplyType$dept$deptId";
  }
}