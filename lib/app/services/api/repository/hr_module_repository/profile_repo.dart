class ProfileRepository {
  static String profilesearch = "/employees/searchByStringFilter";

  /// search employee profile
  static String searchEmployeeProfileByText({required int companyId, required String searchText}){
    return "$profilesearch/$companyId/$searchText";
  }

  static String searchEmployeeProfileById({required int companyId, required int Id}){
    return "$profilesearch/$companyId/$Id";
  }
}