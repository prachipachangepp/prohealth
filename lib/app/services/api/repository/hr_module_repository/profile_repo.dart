class ProfileRepository {
  static String profilesearch = "/employees/searchByStringFilter";
  static String employees = "/employees";
  static String score = "GetProfileScore";
  static String zone = "/zone";
  static String countyWiseZone = "/zoneByCounty/";
  static String gender = "/gender-dropdown";


  /// search employee profile
  static String searchEmployeeProfileByText({
    required int companyId, required String searchText}){
    return "$profilesearch/$companyId/$searchText";
  }

  static String searchEmployeeProfileById({required int companyId, required int Id}){
    return "$profilesearch/$companyId/$Id";
  }

  static String searchByEmployeeIdProfile({required int employeeId}){
    return "$employees/$employeeId";
  }
  static String getPercentage({required int employeeId}){
    return "$employees/$score/$employeeId";
  }
  static String getCountyWiseZone({
    required int countyId
   }){
    return "$zone$countyWiseZone$countyId";
  }
///gender
  static String getGender(){
    return "$gender";
  }
}