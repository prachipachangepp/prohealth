class CreateDataScheduler {
  final int? schedulerCreateId;
  final int? patientId;
  final int? clinicianId;
  final String? visitType;
  final String? assignDate;
  final String? startTime;
  final String? endTime;
  final String? details;

  CreateDataScheduler(
      {required this.schedulerCreateId,
      required this.patientId,
      required this.clinicianId,
      required this.visitType,
      required this.assignDate,
      required this.startTime,
      required this.endTime,
      required this.details});
}
////////
class statedata {
  final int stateId;
  final String name;
  final String short;
  final int countryId;
  final String country;

  statedata(
      {required this.stateId,
      required this.name,
      required this.short,
      required this.countryId,
      required this.country});
}
//////////
class citydata {
  final int city_id;
  final String cityName;
  final String state;
  final String Country;

  citydata(
      {required this.city_id,
      required this.cityName,
      required this.state,
      required this.Country});
}
/////

class relationshipdata{

  final int relationshipId;
  final String relationship;

  relationshipdata({required this.relationshipId, required this.relationship});

}


//////
class languageSpokendata{
  final int languageSpokenId;
  final String languageSpoken;

  languageSpokendata({required this.languageSpokenId, required this.languageSpoken});

}


/////
class metrialStatusdata{
  final int maritalStatusId;
  final String maritalStatus;

  metrialStatusdata({required this.maritalStatusId, required this.maritalStatus});
}

////


class racedata{

  final int raceId;
  final String race;

  racedata({required this.raceId, required this.race});
}

///////


class religiondata{

  final int religionId;
  final String religion;

  religiondata({required this.religionId, required this.religion});
}


/////

class patientStatusdata{

  final int patientStatusId;
  final String patientStatus;

  patientStatusdata({required this.patientStatusId, required this.patientStatus});
}