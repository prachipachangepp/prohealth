class ManageVendorData{
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
  final bool? sucess;
  final String? message;
  ManageVendorData({this.vendorId, this.officeId,
      this.address, this.city,
      this.email, this.phone,
      this.workEmail, this.workPhone,
      this.zone,this.sucess, this.message, this.vendorName});
}