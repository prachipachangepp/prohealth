class ManageVendorData{
  final int insuranceVendorId;
  final String vendorName;
  final String? address;
  final String? phone;
  final int companyId;
  final String officeId;
  final bool? sucess;
  final String? message;
  ManageVendorData({
    required this.companyId,
    required this.insuranceVendorId,
    required this.officeId,
      this.address, this.phone,
     this.sucess, this.message,required this.vendorName});
}

///prefill
class ManageVendorPrefill{
  final int? vendorId;
  final String? officeId;
  final String? vendorName;
  final String? address;
  final String? city;
  final String? email;
  final String? phone;
  final String? workEmail;
  final String? workPhone;
  final String? zone;
  ManageVendorPrefill({this.vendorId, this.officeId,
    this.address, this.city,
    this.email, this.phone,
    this.workEmail, this.workPhone,
    this.zone, this.vendorName});
}
