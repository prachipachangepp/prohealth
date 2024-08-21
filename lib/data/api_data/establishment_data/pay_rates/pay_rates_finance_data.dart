class PayRateFinanceData {
  final String department;
  final String? employeeType;
  final String? abbreviation;
  final String typeVisit;
  final int payRates;
  final String? zone;
  final int zoneId;
  final int departmentId;
  final int employeeTypeId;
  final int typeOfVisitId;
  final int payRatesSetupId;
  final int permile;
  PayRateFinanceData(
      {required this.permile,
      required this.department,
      this.employeeType,
      this.abbreviation,
      required this.payRatesSetupId,
      required this.payRates,
      required this.zoneId,
      required this.departmentId,
      required this.employeeTypeId,
      required this.typeOfVisitId,
      required this.typeVisit,
      this.zone});
}

class PayRatePrefillFinanceData {
  final String department;
  final String? employeeType;
  final String? abbreviation;
  final String typeVisit;
  final int payRates;
  final String? zone;
  final int zoneId;
  final int departmentId;
  final int employeeTypeId;
  final int typeOfVisitId;
  final int payRatesSetupId;
  final int perMiles;
  PayRatePrefillFinanceData(
      {required this.perMiles,
      required this.department,
      this.employeeType,
      this.abbreviation,
      required this.payRatesSetupId,
      required this.payRates,
      required this.zoneId,
      required this.departmentId,
      required this.employeeTypeId,
      required this.typeOfVisitId,
      required this.typeVisit,
      this.zone});
}

///zone data file dropdown

class SortByZoneData {
  final int zoneId;
  final String zoneName;

  SortByZoneData({
    required this.zoneId,
    required this.zoneName,
  });
}
///get service dropdown
class ServiceData {
  final int officeServiceId;
  final int companyId;
  final String officeId;
  final String serviceName;
  final String serviceId;
  final String npiNum;
  final String medicareNum;
  final String hcoNum;

  ServiceData({
    required this.officeServiceId,
    required this.companyId,
    required this.officeId,
    required this.serviceName,
    required this.serviceId,
    required this.npiNum,
    required this.medicareNum,
    required this.hcoNum,
  });
}