class CiVisit {
  final String typeofVisit;
  final List<CiVisitList>? eligibleClinician;
  final int visitId;
  final int? employeeTypeId;
  final bool sucess;
  final String message;
  CiVisit(
      {this.employeeTypeId,
      required this.visitId,
      required this.sucess,
      required this.message,
      required this.typeofVisit,
      this.eligibleClinician});
}

class CiVisitList {
  final String eligibleClinician;
  final int empTypeId;
  final String color;
  CiVisitList({
    required this.color,
    required this.eligibleClinician,
    required this.empTypeId,
  });
}

class VisitListData {
  final String visitType;
  final int companyId;
  final int visitId;
  final bool sucess;
  final String message;
  VisitListData(
      {required this.sucess,
      required this.message,
      required this.companyId,
      required this.visitId,
      required this.visitType});
}

class VisitListDataByServiceId {
  final String visitType;
  final int visitId;
  final String serviceId;
  final bool sucess;
  final String message;
  VisitListDataByServiceId({required this.serviceId,
      required this.sucess,
        required this.message,
        required this.visitId,
        required this.visitType});
}

/// Get visit prefill
class VisitListDataPrefill {
  final String visitType;
  final int visitId;
  final bool sucess;
  final String message;
  final String serviceId;
final List<EligibleClinician> eligibleClinicia;
  VisitListDataPrefill({required this.eligibleClinicia,
      required this.sucess,
      required this.message,
      required this.visitId,
    required this.serviceId,
      required this.visitType});
}

class EligibleClinician {
  final int employeeTypeId;
  final String eligibleClinician;
  final String color;
  EligibleClinician({
    required this.employeeTypeId,
    required this.eligibleClinician,
    required this.color,
  });
}

class CiVisitAdd {
  final String? visitType;
  final List? eligibleClinician;
  CiVisitAdd({this.visitType, this.eligibleClinician});
}
