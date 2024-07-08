class OnboardingQualificationData {
  final int employmentId;
  final int empId;
  final String employer;
  final String city;
  final String reason;
  final String supervisor;
  final String supMobile;
  final String title;
  final String dateOfJoin;
  final String endDate;
  final bool approve;

  OnboardingQualificationData(
      {required this.employmentId,
      required this.empId,
      required this.employer,
      required this.city,
      required this.reason,
      required this.supervisor,
      required this.supMobile,
      required this.title,
      required this.dateOfJoin,
      required this.endDate,
      required this.approve});
}
