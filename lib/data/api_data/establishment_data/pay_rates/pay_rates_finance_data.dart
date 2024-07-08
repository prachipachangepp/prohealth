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
  PayRateFinanceData({required this.permile,
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
  PayRatePrefillFinanceData({required this.perMiles,
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
