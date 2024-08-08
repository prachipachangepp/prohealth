
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
  final bool sucess;
  final String message;

  ManageDetails({
    required this.officeID,
    required this.sucess,
    required this.message,
    required this.officeName,
    required this.priNumber,
      required this.secNumber,
    required this.alternateNumber,
      required this.address,
      required this.primaryFax,
      required this.secondaryFax,
    required this.email});
}

class DetailsServiceData{
final int OfficeServiceId;
final int CompanyId;
final String officeId;
final String serviceName;
final String serviceId;
final String npiNum;
final String medicareNum;
final String hcoNum;

DetailsServiceData({
required this.CompanyId,
required this.officeId,
required this.serviceName,
required this.serviceId,
required this.npiNum,
required this.medicareNum,
  required this.hcoNum,
  required this.OfficeServiceId
});
}