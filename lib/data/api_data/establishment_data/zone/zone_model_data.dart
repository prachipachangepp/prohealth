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
  final int zoinId;
  final String? state;
  final String? country;
  final String? zipcodes;
  final String zoneName;
  final bool? sucess;
  final String? message;
  AllCountyGet({required this.zoinId,required this.zoneName,required this.countyName,required this.state,required this.country,required this.zipcodes,required this.sucess,required this.message,});
}

/// County zone get
class AllCountyZoneGet {
  final String countyName;
  final int countyId;
  final int zoneId;
  final String zoneName;
  final String zipcodes;
  final String cities;
  final bool sucess;
  final String message;
  AllCountyZoneGet({required this.countyName, required this.countyId, required this.zoneId,
    required this.zoneName, required this.zipcodes, required this.cities, required this.sucess, required this.message});
}
/// prefill county zone
class CountyZonePrefillGet {
  final String countyName;
  final int countyId;
  final int zoneId;
  final String zoneName;
  final String zipcodes;
  final String cities;
  final bool sucess;
  final String message;
  CountyZonePrefillGet({required this.countyName, required this.countyId, required this.zoneId,
    required this.zoneName, required this.zipcodes, required this.cities, required this.sucess, required this.message});
}

/// County List Data
class AllCountyGetList {
  final String countyName;
  final int countyId;
  final int companyId;
  final String state;
  final String country;
  final String latitude;
  final String longitude;
  final String officeID;
  final bool sucess;
  final String message;
  AllCountyGetList({required this.officeID,required this.countyId, required this.companyId, required this.latitude, required this.longitude, required this.countyName,required this.state,required this.country,required this.sucess,required this.message,});
}
//
// class AllCountyGet {
//   final int? countyId;
//   final String? countyName;
//   final String? state;
//   final String? country;
//   final String? latitude;
//   final String? longitude;
//   final int? compId;
//   final int? officeId;
//   final bool? sucess;
//   final String? message;
//   AllCountyGet({required this.countyId,required this.latitude,required this.longitude,required this.compId,required this.officeId, required this.countyName,required this.state,required this.country,required this.sucess,required this.message,});
// }
///zipcode,zone get
class AllZipCodeGet{
  final int? zipcodeSetupId;
  final int? zoneId;
  final int? countyID;
  final int? companyID;
  final String zoneName;
  final String countyName;
  final String? city;
  final String? zipcode;
  final String? latitude;
  final String? longitude;
  final String? landmark;
  final String? officeId;
  final bool? sucess;
  final String? message;

  AllZipCodeGet({required this.zoneName, required this.countyName,required this.zipcodeSetupId,required this.zoneId,required this.countyID,required this.companyID,required this.city,required this.zipcode,required this.latitude,required this.longitude,required this.landmark,required this.officeId,required this.sucess,required this.message,});
}

///zipcode,zone get prefill
class ZipCodeGetPrefill{
  final int? zipcodeSetupId;
  final int? zoneId;
  final int? countyID;
  final int? companyID;
  final String zoneName;
  final String countyName;
  final String? city;
  final String? zipcode;
  final String? latitude;
  final String? longitude;
  final String? landmark;
  final String? officeId;
  final bool? sucess;
  final String? message;

  ZipCodeGetPrefill({required this.zoneName, required this.countyName,required this.zipcodeSetupId,required this.zoneId,required this.countyID,required this.companyID,required this.city,required this.zipcode,required this.latitude,required this.longitude,required this.landmark,required this.officeId,required this.sucess,required this.message,});
}