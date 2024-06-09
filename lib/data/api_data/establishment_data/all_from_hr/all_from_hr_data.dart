import 'dart:ui';

///hr clinical
class HRClinical {
  final bool success;
  final String message;
  final String empType;
  final String abbrivation;
  final String color;

  HRClinical(
      this.success, this.message, this.empType, this.abbrivation, this.color);
}

///hr sales
class HRSales {
  final bool success;
  final String message;
  final String empType;
  final String abbrivation;
  final String color;

  HRSales(
      this.success, this.message, this.empType, this.abbrivation, this.color);
}

///hr administration
class HRAdministration {
  final bool success;
  final String message;
  final String empType;
  final String abbrivation;
  final String color;

  HRAdministration(
      this.success, this.message, this.empType, this.abbrivation, this.color);
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