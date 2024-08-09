//
// class ManageDetails {
//   final String officeID;
//   final String officeName;
//   final String priNumber;
//   final String secNumber;
//   final String alternateNumber;
//   final String address;
//   final String email;
//   final String primaryFax;
//   final String secondaryFax;
//   final List<DetailsServiceData>? serviceDetails;
//   final bool sucess;
//   final String message;
//
//   ManageDetails({
//     required this.officeID,
//     required this.sucess,
//     required this.message,
//     required this.officeName,
//     required this.priNumber,
//       required this.secNumber,
//     required this.alternateNumber,
//       required this.address,
//       required this.primaryFax,
//       required this.secondaryFax,
//     required this.email,
//   this.serviceDetails});
// }
//
// class DetailsServiceData{
// final int OfficeServiceId;
// final int CompanyId;
// final String officeId;
// final String serviceName;
// final String serviceId;
// final String npiNum;
// final String medicareNum;
// final String hcoNum;
//
// DetailsServiceData({
// required this.CompanyId,
// required this.officeId,
// required this.serviceName,
// required this.serviceId,
// required this.npiNum,
// required this.medicareNum,
//   required this.hcoNum,
//   required this.OfficeServiceId
// });
// }

class ManageDetails {
  final String officeID;
  final String officeName;
  final String priNumber;
  final String secNumber;
  final String alternateNumber;
  final String address;
  final String email;
  final String primaryFax;
  final String secondaryFax;
  final List<DetailsServiceData>? serviceDetails;
  final bool success;  // Corrected spelling from 'sucess' to 'success'
  final String message;

  ManageDetails({
    required this.officeID,
    required this.success,  // Corrected spelling
    required this.message,
    required this.officeName,
    required this.priNumber,
    required this.secNumber,
    required this.alternateNumber,
    required this.address,
    required this.primaryFax,
    required this.secondaryFax,
    required this.email,
    this.serviceDetails,
  });

  // Add factory constructor to convert JSON to the model
  factory ManageDetails.fromJson(Map<String, dynamic> json) {
    return ManageDetails(
      officeID: json['officeDetail']['company_Office_id'].toString(),
      success: true, // Assuming 'success' field might come from a larger API response
      message: '', // Placeholder, update with actual message field from API response
      officeName: json['officeDetail']['name'],
      priNumber: json['officeDetail']['primary_phone'],
      secNumber: json['officeDetail']['secondary_phone'],
      alternateNumber: json['officeDetail']['alternative_phone'],
      address: json['officeDetail']['address'],
      primaryFax: json['officeDetail']['primary_fax'],
      secondaryFax: json['officeDetail']['secondary_fax'],
      email: json['officeDetail']['email'],
      serviceDetails: (json['serviceList'] as List<dynamic>?)
          ?.map((item) => DetailsServiceData.fromJson(item))
          .toList(),
    );
  }
}

class DetailsServiceData {
  final int officeServiceId;
  final int companyId;
  final String officeId;
  final String serviceName;
  final String serviceId;
  final String npiNum;
  final String medicareNum;
  final String hcoNum;

  DetailsServiceData({
    required this.officeServiceId,
    required this.companyId,
    required this.officeId,
    required this.serviceName,
    required this.serviceId,
    required this.npiNum,
    required this.medicareNum,
    required this.hcoNum,
  });

  // Add factory constructor to convert JSON to the model
  factory DetailsServiceData.fromJson(Map<String, dynamic> json) {
    return DetailsServiceData(
      officeServiceId: json['OfficeServiceId'],
      companyId: json['CompanyId'],
      officeId: json['officeId'],
      serviceName: json['serviceName'],
      serviceId: json['serviceId'],
      npiNum: json['npiNum'],
      medicareNum: json['medicareNum'],
      hcoNum: json['hcoNum'],
    );
  }
}
