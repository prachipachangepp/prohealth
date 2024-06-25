///zone GET
class AllZoneData {
  final int zoneId;
  final String zoneName;
  final bool sucess;
  final String message;

  AllZoneData(
      {required this.zoneId, required this.zoneName, required this.sucess, required this.message,});
}
///county get last
class AllCountyGet {
  final String? countyName;
  final String? state;
  final String? country;
  final String? zipcodes;
  final bool? sucess;
  final String? message;
  AllCountyGet({required this.countyName,required this.state,required this.country,required this.zipcodes,required this.sucess,required this.message,});
}

///zipcode,zone get
class AllZipCodeGet{
  final int? zipcodeSetupId;
  final int? zoneId;
  final int? countyID;
  final int? companyID;
  final String? city;
  final String? zipcode;
  final String? latitude;
  final String? longitude;
  final String? landmark;
  final String? officeId;
  final bool? sucess;
  final String? message;

  AllZipCodeGet({required this.zipcodeSetupId,required this.zoneId,required this.countyID,required this.companyID,required this.city,required this.zipcode,required this.latitude,required this.longitude,required this.landmark,required this.officeId,required this.sucess,required this.message,});
}