class SeeAllRepository{
  static String emp = "/employees";
  static String all = "/all";

  ///employees/all/{companyId}
  static String getEmpSeeAll({required int compId}){
    return "$emp$all/$compId";
  }
}