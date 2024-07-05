
/// discipline dropdown
class AEClinicalDiscipline {
  final bool? success;
  final String? message;
  final String? empType;
  final String? abbrivation;
  final int? deptID;
  final String? color;
  final int employeeTypesId;

  AEClinicalDiscipline(
      {required this.employeeTypesId,
      this.success,
      this.message,
      this.empType,
      this.deptID,
      this.abbrivation,
      this.color});
}

///city dropdown
class AEClinicalCity {
  final bool? success;
  final String? message;
  final String? cityName;
  final int? cityID;
  final String? state;
  final String? country;

  AEClinicalCity(
      {this.cityName,
      this.cityID,
      this.state,
      this.country,
      this.success,
      this.message});
}

/// Reporting Office dropdown
class AEClinicalReportingOffice {
  final bool? success;
  final String? message;
  final int? companyOfficeID;
  final int? companyID;
  final String? officeID;
  final String? primNo;
  final String? secNo;
  final String? primeFax;
  final String? secFax;
  final String? alterNo;
  final String? email;
  final String? name;
  final String? address;

  AEClinicalReportingOffice(
      {this.success,
      this.message,
      this.companyOfficeID,
      this.companyID,
      this.officeID,
      this.primNo,
      this.secNo,
      this.primeFax,
      this.secFax,
      this.alterNo,
      this.email,
      this.name,
      this.address});
}

///zone dropdown
class AEClinicalZone {
  final bool? success;
  final String? message;
  final String? county;
  final int? countyID;
  final int? zoneID;
  final String? zoneName;
  final String? zipCode;
  final String? cities;

  AEClinicalZone(
      {this.success,
      this.message,
      this.county,
      this.countyID,
      this.zoneID,
      this.zoneName,
      this.zipCode,
      this.cities});
}
