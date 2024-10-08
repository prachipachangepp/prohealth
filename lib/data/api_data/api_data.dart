class ApiData {
  final bool success;
  final String message;
  final int statusCode;
  final Object? data;
  final String? imageUrl;
  final String? officeId;
  final int? employeeId;
  final int? patientId;
  final int? labReportId;
  final int? miscNoteId;
  final int? rDignosisId;
  final int? orgOfficeDocumentId;
  final int? employeeEnrollId;

  ApiData(
      {this.officeId,
        this.employeeEnrollId,
      required this.statusCode,
      required this.success,
      required this.message,
      this.labReportId,
      this.data,
      this.imageUrl,
      this.employeeId,
      this.patientId,
      this.miscNoteId,
      this.rDignosisId,
      this.orgOfficeDocumentId});
}

class ApiDataFilter {
  final int employeeId;
  final String code;
  final int userId;
  final String firstName;
  final String lastName;
  final int departmentId;
  final int employeeTypeId;
  final String expertise;
  final int cityId;
  final int countryId;
  final int zoneId;
  final String SSNNbr;
  final String primaryPhoneNbr;
  final String secondryPhoneNbr;
  final String workPhoneNbr;
  final String regOfficId;
  final String personalEmail;
  final String workEmail;
  final String address;
  final String dateOfBirth;
  final String emergencyContact;
  final String employment;
  final String covreage;
  final String gender;
  final String status;
  final String service;
  final String imgurl;
  final String resumeurl;
  final String onboardingStatus;
  final String createdAt;
  final int companyId;
  final bool terminationFlag;
  final bool approved;
  final String dateofTermination;
  final String dateofResignation;
  final String rehirable;
  final String finalAddress;
  final String type;
  final String reason;
  final double finalPayCheck;
  final String checkDate;
  final double grossPay;
  final double netPay;
  final String methods;
  final String materials;
  final String dateofHire;
  final String position;
  final String driverLicenceNbr;
  final String race;
  final String rating;

  ApiDataFilter({
    required this.rating,
    required this.employeeId,
    required this.code,
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.departmentId,
    required this.employeeTypeId,
    required this.expertise,
    required this.cityId,
    required this.countryId,
    required this.zoneId,
    required this.SSNNbr,
    required this.primaryPhoneNbr,
    required this.secondryPhoneNbr,
    required this.workPhoneNbr,
    required this.regOfficId,
    required this.personalEmail,
    required this.workEmail,
    required this.address,
    required this.dateOfBirth,
    required this.emergencyContact,
    required this.employment,
    required this.covreage,
    required this.gender,
    required this.status,
    required this.service,
    required this.imgurl,
    required this.resumeurl,
    required this.onboardingStatus,
    required this.createdAt,
    required this.companyId,
    required this.terminationFlag,
    required this.approved,
    required this.dateofTermination,
    required this.dateofResignation,
    required this.rehirable,
    required this.finalAddress,
    required this.type,
    required this.reason,
    required this.finalPayCheck,
    required this.checkDate,
    required this.grossPay,
    required this.netPay,
    required this.methods,
    required this.materials,
    required this.dateofHire,
    required this.position,
    required this.driverLicenceNbr,
    required this.race,
  });
}

class ApiDataRegister {
  final bool success;
  final String message;
  final int statusCode;
  final Object? data;
  final int? licenses;
  final int? banckingId;
  final int? educationId;
  final int? legalDocumentId;

  ApiDataRegister({
    this.educationId,
    this.legalDocumentId,
    this.banckingId,
    this.licenses,
    required this.success,
    required this.statusCode,
    required this.message,
    this.data,
  });
}

class ApiAddCovrageData {
  final String city;
  final int countyId;
  final int zoneId;
  final List<int> zipCodes;
  ApiAddCovrageData(
      {required this.city,
      required this.countyId,
      required this.zoneId,
      required this.zipCodes});
  Map<String, dynamic> toJson() {
    return {
      'city': city,
      'countyId': countyId,
      'zoneId': zoneId,
      'zipCode': zipCodes,
    };
  }
}

class ApiPatchCovrageData {
  final int employeeEnrollCoverageId;
  final String city;
  final int countyId;
  final String countyName; // New field for countyName
  final int zoneId;
  final String zoneName; // New field for zoneName
  final List<int> zipCodes;

  ApiPatchCovrageData({
    required this.employeeEnrollCoverageId, // Added employeeEnrollCoverageId
    required this.city,
    required this.countyId,
    required this.countyName, // Added countyName
    required this.zoneId,
    required this.zoneName, // Added zoneName
    required this.zipCodes,
  });

  // Convert the model to JSON format
  Map<String, dynamic> toJson() {
    return {
      'employeeEnrollCoverageId': employeeEnrollCoverageId, // Added to JSON
      'city': city,
      'countyId': countyId,
      'countyName': countyName, // Added to JSON
      'zoneId': zoneId,
      'zoneName': zoneName, // Added to JSON
      'zipCodes': zipCodes, // Fixed to match the field name 'zipCodes'
    };
  }
}

