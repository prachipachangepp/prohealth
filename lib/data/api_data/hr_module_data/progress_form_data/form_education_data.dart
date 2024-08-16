///city dropdown
class EduactionDegree {
  final bool? success;
  final String? message;

  final int? degreeId;
  final String? degree;
  final int? companyId;

  EduactionDegree(
      {this.degreeId, this.degree, this.companyId, this.success, this.message});
}

//"degreeId": 0,
//   "degree": "string",
//   "companyId": 0



///onboarding-qualification-education
class EducationDataForm {
final int? educationID;
  final int? empId;
  final String? graduate;
  final String? degree;
  final String? major;
  final String? city;
  final String? college;
  final String? phone;
  final String? state;
  bool? approved;
  final String? country;
  final String? startDate;


  EducationDataForm(
      {
        required this.educationID,
        required this.empId,
        required this.graduate,
        required this.degree,
        required this.major,
        required this.city,
        required this.college,
        required this.phone,
        required this.state,
        this.approved,
        required this.country,
        required this.startDate,
      });
}
