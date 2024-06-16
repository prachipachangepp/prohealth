
class ManageDetails {
  final String officeID;
  final String officeName;
  final String priNumber;
  final String secNumber;
  final String alternateNumber;
  final String address;
  final String email;
  final bool sucess;
  final String message;

  ManageDetails({required this.officeID, required this.sucess, required this.message,required this.officeName, required this.priNumber,
      required this.secNumber, required this.alternateNumber,
      required this.address, required this.email});
  // factory ManageDetails.fromJson(Map<String, dynamic> json) => _$ManageDetailsFromJson(json);
  //
  // // Method to convert a User instance to JSON
  // Map<String, dynamic> toJson() => _$ManageDetailsToJson(this);
}