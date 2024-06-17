import 'package:prohealth/app/resources/color.dart';

/// Company Model
class CompanyModel {
  // final String? name;
  final String? address;
  final String? officeName;
  final int? companyId;
  final bool? sucess;
  final String? message;

  CompanyModel({
    this.sucess,
    this.message, this.officeName,
    this.companyId,
    // this.name,
    this.address,
  });
}

/// Company Logo Model
class CompanyLogoModel {
  final int? logoId;
  final String? type;

  CompanyLogoModel({this.logoId, this.type});
}

/// Company Upload Logo Model
class UploadCompanyLogoModel {
  final int? companyId;
  final String? type;

  UploadCompanyLogoModel(
      {
      this.companyId,
      this.type});
}
class CompanyIdentityModel {
  final String? name;
  final String address;
  final String officeName;
  final int companyId;
  final int pageNo;
  final int rowsNo;
  //final OfficeList officeList;
  final bool sucess;
  final String message;

  CompanyIdentityModel({this.name, required this.address, required this.officeName, required this.companyId, required this.pageNo, required this.rowsNo,
    //required this.officeList,
    required this.sucess,
    required this.message,
  });
}
// class OfficeList{
//   final String address;
//   final String officeName;
//   final int companyId;
//   final int pageNo;
//   final int rowsNo;
//   OfficeList( {
//     required this.pageNo,
//     required this.rowsNo,
//     required this.officeName,
//     required this.companyId,
//     required this.address,
//   });
// }