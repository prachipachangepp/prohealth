class ManageZoneCounty{
  final String? zone;
  final String? name;
  final String? zipcode;
  final String? landmark;

  ManageZoneCounty({this.zone, this.name, this.zipcode, this.landmark});
}

///manage zone zone
class ManageZone{
  final String? zoneNum;
  final String? zipcode;
  final String? city;

  ManageZone({this.zoneNum, this.zipcode, this.city});
}

class ZoneAdd{
  final String zoneNum;
  final String zipCode;
  final String city;

  ZoneAdd(this.zoneNum, this.zipCode, this.city);
}

