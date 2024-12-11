import 'dart:ui';
///hr head bar
class HRHeadBar{
  final int deptId;
  final String deptName;
  final String deptDescp;
  final bool sucess;
  final String message;
   HRHeadBar({required this.deptId,required this.deptName, required this.deptDescp,required this.sucess,required this.message,});
}
///getby id
class HRGetEmpId{
  final int empTypeId;
  final int deptId;
  final bool? success;
  final String? message;
  final String? empType;
  final String? abbrivation;
  final String? color;
  HRGetEmpId({required this.empTypeId, required this.deptId, this.success, this.message, this.empType, this.abbrivation, this.color,});
}
///hr clinical
class HRClinical {
  final bool? success;
  final String? message;
  final String? empType;
  final String? abbrivation;
  final String? color;
  final int employeeTypesId;

  HRClinical( {
    required this.employeeTypesId,
      this.success, this.message, this.empType, this.abbrivation, this.color});
}

/// Hr All
class HRAllData {
  final int deptID;
  final bool? success;
  final String? message;
  final String? empType;
  final String? abbrivation;
  final String? color;
  final int employeeTypesId;
  final DateTime? createdAt;

  HRAllData({required this.deptID,
    required this.employeeTypesId,
    this.success, this.message, this.empType, this.abbrivation, this.color, this.createdAt, });
}

///hr sales
class HRSales {
  final bool? success;
  final String? message;
  final String? empType;
  final String? abbrivation;
  final String? color;

  HRSales({
      this.success, this.message, this.empType, this.abbrivation, this.color});
}

///hr administration
class HRAdministration {
  final bool? success;
  final String? message;
  final String? empType;
  final String? abbrivation;
  final String? color;

  HRAdministration({
      this.success, this.message, this.empType, this.abbrivation, this.color});
}

///hr all add/edit
class HRAdd {
  String employeeType;
  String shorthand;
  String typeOfEmployee;
  Color color;

  HRAdd({
    required this.employeeType,
    required this.shorthand,
    required this.typeOfEmployee,
    required this.color,
  });
}