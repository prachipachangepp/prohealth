class EstablishmentManagerRepository {
  ///Company
  static String addCompany = "/Company/Insert";
  static String company = "/Company";
  static String details = "Details";
  static String companyLogo = "/company-logo";
  static String uploadLogo = "uploadLogo";
  static String companyOffice = "/company-office";
  static String add = "/add";

  static String companyAll(){
    return "$company";
  }
  static String companyById({required int companyId}) {
    return "$company/$companyId";
  }

  static String companyDetails({required int companyId}) {
    return "$company/$companyId/$details";
  }

  static String uploadCompanyLogo(
      {required int companyId, required String type}) {
    return "$companyLogo/$type/$companyId/$uploadLogo";
  }

  static String addNewOffice() {
    return "$companyOffice/$add";
  }

  static String companyOfficeGet() {
    return "$companyOffice";
  }


}
