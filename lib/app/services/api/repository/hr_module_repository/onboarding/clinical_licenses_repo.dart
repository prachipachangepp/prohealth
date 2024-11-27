class ClinicalLicensesRepo {
  static String drivingLicense = "/driving-license";
  static String practitionerLicense = "/practitioner-license";
  static String practitionerLicenseBase64 = "/practitioner-license/attach-documentbase64";
  static String drivingLicenseBase64 = "/driving-license/attach-documentbase64";



  static String postDrivingLicense() {
    return "$drivingLicense";
  }

  static String postpractitionerLicense() {
    return "$practitionerLicense";
  }

  static String postpractitionerLicensebase64({required int practitionerLicenceId }) {
    return "$practitionerLicenseBase64/$practitionerLicenceId";
  }

  static String postdrivingLicensebase64({required int drivingLicenceId }) {
    return "$drivingLicenseBase64/$drivingLicenceId";
  }
}