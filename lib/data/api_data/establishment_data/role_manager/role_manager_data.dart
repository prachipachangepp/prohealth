class RoleManagerData {
  final int deptID;
  final String deptName;
  final String description;

  RoleManagerData({required this.deptID, required this.deptName, required this.description,});
}

class ModuleMetaData {
  final int appModuleMetaDataId;
  final String mainModule;
  final String iconUrl;
  final bool sucess;
  final String message;

  ModuleMetaData({required this.sucess, required this.message,required this.appModuleMetaDataId, required this.mainModule, required this.iconUrl,});
}

class RoleManagerDepartmentEmpType{
  final int employeeTypeId;
  final int DepartmentId;
  final String employeeType;
  final String color;
  final String abbreviation;
  RoleManagerDepartmentEmpType({required this.employeeTypeId, required this.DepartmentId,
    required this.employeeType, required this.color, required this.abbreviation,});
}
// "employeeTypeId": 73,
// "DepartmentId": 1,
// "employeeType": "Language Therapist",
// "color": "#00bcd4",
// "abbreviation": "LT"