class AppConfig {
  // static const String dev =  "https://demoapp.symmetry.care";
  static const String dev = "https://resource.symmetry.care";
  static const String demo = "https://demoapp.symmetry.care";

  static const String local = "";
  static const String prod = "";
  static const String endpoint = demo;
  // static const String endpoint = demo;

  /// Document types
  static const int corporateAndCompliance = 1;
  static const int vendorContracts = 2;
  static const int policiesAndProcedure = 3;

  ///CCD
  static const int subDocId1Licenses = 1;
  static const int subDocId2Adr = 2;
  static const int subDocId3CICCMedicalCR = 3;
  static const int subDocId4 = 4;
  static const int subDocId5 = 5;

  ///VC
  static const int subDocId6 = 6;
  static const int subDocId7 = 7;
  static const int subDocId8 = 8;
  static const int subDocId9 = 9;
  static const int subDocId10 = 10;

  /// Policies & procedures
  static const int subDocId0 = 0;

  ///health record form
  static const int empdocumentTypeMetaDataId = 1;
  static const int employeeDocumentTypeMetaDataId = 5;

  ///Employee Document types
  static const int healthDocId = 1;
  static const int certificationDocId = 2;
  static const int employmentDocId = 3;
  // IDs 4, 5, 6, 7 are deleted
  static const int clinicalVerificationDocId = 4;
  static const int acknowledgementDocId = 5;
  static const int compensationDocId = 6;
  static const int performanceDocId = 7;

  /// All From HR EM
  static const int clinicalId = 1;
  static const int salesId = 2;
  static const int AdministrationId = 3;
}
